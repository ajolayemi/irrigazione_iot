// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typed_data/typed_data.dart' as typed;

import 'package:irrigazione_iot/env/env.dart';
import 'package:irrigazione_iot/src/config/data/mqtt_configs.dart';
import 'package:irrigazione_iot/src/config/enums/mqtt_enums.dart';
import 'package:irrigazione_iot/src/data/datasource/dao/mqtt_dao.dart';
import 'package:irrigazione_iot/src/features/collectors/data/collector_sector_repository.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure.dart';
import 'package:irrigazione_iot/src/features/company_users/data/selected_company_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/data/pump_repository.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/sectors/data/sector_repository.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pressure.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
import 'package:irrigazione_iot/src/shared/models/keys_from_pressure_msg.dart';
import 'package:irrigazione_iot/src/utils/extensions/string_extensions.dart';

part 'mqtt_client_service.g.dart';

/// Holds logic to connect to the MQTT broker and publish messages.
class MqttService {
  const MqttService(this._mqttDao, this._ref);

  final MqttDao _mqttDao;
  final Ref _ref;

  static final _brokerUrl = Env.mqttBrokerUrl;
  static final _brokerUsername = Env.mqttBrokerUsername;
  static final _brokerPassword = Env.mqttBrokerPassword;

  /// Publishes a message to the given topic.
  /// Throws an exception if the message could not be published.
  /// The client is disconnected after the message is published.
  ///
  /// Returns the message ID of the published message.˚
  Future<int?> publishMessage({
    required String topic,
    required Map<String, dynamic> message,
    MqttServerClient? client,
  }) async {
    if (client == null) {
      debugPrint('MQTT client is null');
      return Future.value(null);
    }
    try {
      final builder = MqttClientPayloadBuilder();
      builder.addBuffer(convertMapToBuffer(message));

      final messageId = client.publishMessage(
        topic,
        MqttQos.atLeastOnce,
        builder.payload!,
      );

      return messageId;
    } catch (e) {
      debugPrint('Failed to publish message - $e');
      rethrow;
    }
  }

  /// Connects to the MQTT broker and returns the client.
  Future<MqttServerClient> connect() async {
    final company = await _ref.read(currentTappedCompanyProvider.future);
    final mqttCompanyName = company?.mqttTopicName;
    final client = MqttServerClient.withPort(
      _brokerUrl,
      _getRandomClientId(),
      1883,
    );

    client.setProtocolV311();

    client.logging(on: false);

    client.onConnected = _onConnected;

    client.onDisconnected = _onDisconnected;

    client.onSubscribed = _onSubscribed;

    client.onUnsubscribed = _onUnsubscribed;
    try {
      await client.connect(_brokerUsername, _brokerPassword);

      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        _subscribeToTopics(client, mqttCompanyName);
        client.updates?.listen(_updatesListener);
        return client;
      } else {
        debugPrint(
          'Failed to connect to MQTT Broker at $_brokerUrl - state: ${client.connectionStatus!.state}',
        );
        client.disconnect();
        throw Exception('Failed to connect to MQTT Broker at $_brokerUrl');
      }
    } on NoConnectionException catch (e) {
      // This is raised by the client when connection fails.
      debugPrint('Client exception - $e');
      client.disconnect();
      rethrow;
    } on SocketException catch (e) {
      // Raised by the socket layer
      debugPrint('Socket exception - $e');
      client.disconnect();
      rethrow;
    } catch (e) {
      // General error handling
      debugPrint('Error - $e');
      client.disconnect();
      rethrow;
    }
  }

  Future<void> _updatesListener(
    List<MqttReceivedMessage<MqttMessage>> data,
  ) async {
    final currentTime = DateTime.now();
    List<PumpStatus> pumpStatuses = [];
    List<SectorStatus> sectorStatuses = [];
    List<PumpFlow> pumpFlows = [];
    List<PumpPressure> pumpPressures = [];
    List<CollectorPressure> collectorPressures = [];
    List<TerminalPressure> terminalPressures = [];
    List<SectorPressure> sectorPressures = [];

    try {
      for (final item in data) {
        final recordMsg = item.payload;

        if (recordMsg is MqttPublishMessage) {
          final fromBytes = MqttPublishPayload.bytesToStringAsString(
            recordMsg.payload.message,
          );

          final decoded = jsonDecode(fromBytes) as Map<String, dynamic>;
          debugPrint('Received message: $decoded');
          final messageType = decoded['type'].toString().toMqttMsgType();

          if (messageType == null) {
            continue;
          }

          switch (messageType) {
            case AppMqttMessageTypes.pumpStatus:
            case AppMqttMessageTypes.sectorStatus:
              final statusObj = ItemStatusRequest.fromJson(decoded);

              if (messageType.isPumpStatus) {
                final pStatus = PumpStatus(
                  id: '',
                  pumpId: statusObj.itemId,
                  status: statusObj.message,
                  statusBoolean: statusObj.statusBoolean,
                  companyId: statusObj.companyId,
                  createdAt: statusObj.createdAt ?? DateTime.now(),
                );
                pumpStatuses.add(pStatus);
              } else if (messageType.isSectorStatus) {
                final secStatus = SectorStatus(
                  id: '',
                  sectorId: statusObj.itemId,
                  status: statusObj.message,
                  statusBoolean: statusObj.statusBoolean,
                  createdAt: statusObj.createdAt ?? DateTime.now(),
                  companyId: statusObj.companyId,
                );
                sectorStatuses.add(secStatus);
              }
              break;
            case AppMqttMessageTypes.pumpFlow:
              final pumpFlowFromMqtt = PumpFlowFromMqtt.fromJson(decoded);
              final pump = await filterPumpByMqttName(
                pumpFlowFromMqtt.mqttIdentifierName,
              );
              if (pump == null) break;
              final pumpFlow = PumpFlow.fromMqttMsg(
                pumpFlowFromMqtt,
                pumpId: pump.id,
                createdAt: currentTime,
              );
              pumpFlows.add(pumpFlow);
              break;
            case AppMqttMessageTypes.pumpPressure:
              final pumpPressureFromMqtt =
                  PumpPressureFromMqtt.fromJson(decoded);
              final pump = await filterPumpByMqttName(
                pumpPressureFromMqtt.mqttName,
              );

              if (pump == null) break;
              final pumpPressure = PumpPressure.fromMqttMsg(
                pumpPressureFromMqtt,
                pumpId: pump.id,
                createdAt: currentTime,
              );
              pumpPressures.add(pumpPressure);
              break;
            case AppMqttMessageTypes.pressure:
              final keys = _getKeysFromPressureMsg(
                decoded,
              );

              // At least one sector is expected to have been found, if that's not the case,break this flow
              if (keys.sectorKeys.isEmpty || keys.splittedSectorKeys.isEmpty) {
                break;
              }

              final firstSector = await selectSector(keys.splittedSectorKeys);

              if (firstSector == null) {
                break;
              }

              final collector = await _ref
                  .read(collectorSectorRepositoryProvider)
                  .getCollectorBySectorId(firstSector.id);

              if (collector == null) {
                break;
              }

              final terminalPressure = TerminalPressure(
                createdAt: currentTime,
                collectorId: collector.id,
                pressure: double.tryParse(
                  decoded[keys.terminalPressureKey] ?? '',
                ),
              );
              terminalPressures.add(terminalPressure);

              final collectorPressure = CollectorPressure(
                createdAt: currentTime,
                collectorId: collector.id,
                filterInPressure: double.tryParse(decoded['Filter_IN'] ?? ''),
                filterOutPressure: double.tryParse(decoded['Filter_OUT'] ?? ''),
              );

              collectorPressures.add(collectorPressure);

              for (final sectorKey in keys.sectorKeys) {
                final splittedKey = sectorKey.split('_');

                if (splittedKey.isEmpty) continue;

                final mqttKey = splittedKey.first;
                final sector = await filterSectorByMqttName(mqttKey);

                if (sector == null) continue;

                final sectorPressure = SectorPressure(
                  sectorId: sector.id,
                  createdAt: currentTime,
                  pressure: double.tryParse(decoded[sectorKey] ?? ''),
                );

                sectorPressures.add(sectorPressure);
              }
          }
        }
      }

      if (pumpStatuses.isNotEmpty) {
        await _mqttDao.insertPumpStatuses(statuses: pumpStatuses);
        await _mqttDao.insertPumpsSwitchedOn(
          data: pumpStatuses.toPumpsSwitchedOn(),
        );
      }

      if (sectorStatuses.isNotEmpty) {
        await _mqttDao.insertSectorStatuses(statuses: sectorStatuses);
        await _mqttDao.insertSectorsSwitchedOn(
          data: sectorStatuses.toSectorsSwitchedOn(),
        );
      }

      if (pumpFlows.isNotEmpty) {
        await _mqttDao.insertPumpFlows(data: pumpFlows);
      }

      if (pumpPressures.isNotEmpty) {
        await _mqttDao.insertPumpPressures(data: pumpPressures);
      }

      if (collectorPressures.isNotEmpty) {
        await _mqttDao.insertCollectorPressures(data: collectorPressures);
      }

      if (terminalPressures.isNotEmpty) {
        await _mqttDao.insertTerminalPressures(data: terminalPressures);
      }
      if (sectorPressures.isNotEmpty) {
        await _mqttDao.insertSectorPressures(data: sectorPressures);
      }
    } catch (e) {
      debugPrint('An error occurred while listening to mqtt message');
    }
  }

  /// Processes the keys in a pressure message to get the necessary keys that will later be used to
  /// process the full msg
  KeysFromPressureMsg _getKeysFromPressureMsg(Map<String, dynamic> msg) {
    final msgKeys = msg.keys.toList();

    // Get the ket for terminal pressure, it's represented by the key "Final_CH4"
    // to do this, we filter the keys to get the one that has the word "Final" in it
    final terminalPressureKey = msgKeys.firstWhereOrNull(
      (item) => item.contains('Final'),
    );

    // Get the keys for collector pressures, they are represented by all keys
    // that start with Filter
    final collectorPressureKeys = msgKeys
        .where(
          (item) => item.startsWith('Filter'),
        )
        .toList();

    // Get all other keys that are not terminal pressure or collector pressure keys
    // These are the sector keys
    final sectorKeys = msgKeys.where((item) {
      return !collectorPressureKeys.contains(item) &&
          item != terminalPressureKey &&
          item != 'type';
    }).toList();
    // Split the sector keys to remove the "_CH" part
    final splittedSectorKeys = sectorKeys.map(
      (item) {
        final splittedItem = item.split('_');
        if (splittedItem.isNotEmpty) {
          return splittedItem.first;
        }
      },
    ).toList();
    return KeysFromPressureMsg(
      terminalPressureKey: terminalPressureKey,
      collectorPressureKeys: collectorPressureKeys,
      sectorKeys: sectorKeys,
      splittedSectorKeys: splittedSectorKeys.whereType<String>().toList(),
    );
  }

  Future<Pump?> filterPumpByMqttName(String? mqttName) async {
    final pumps = await _ref.read(companyPumpsProvider.future) ?? <Pump>[];
    return pumps.getPumpByMqttName(mqttName);
  }

  Future<Sector?> selectSector(
    List<String> mqttNames,
  ) async {
    final sectors = await _ref.read(sectorsProvider.future) ?? <Sector>[];
    Sector? res;
    for (final name in mqttNames) {
      res = sectors.getSectorByMqttName(name);

      if (res != null) {
        break;
      }
    }
    return res;
  }

  Future<Sector?> filterSectorByMqttName(String? mqttName) async {
    final sectors = await _ref.read(sectorsProvider.future) ?? <Sector>[];
    return sectors.getSectorByMqttName(mqttName);
  }

  void _subscribeToTopics(
    MqttServerClient client,
    String? mqttCompanyName,
  ) {
    if (mqttCompanyName == null || mqttCompanyName.isEmpty) {
      return;
    }
    final topics = _ref
        .read(mqttConfigsProvider)
        .buildMqttTopicsForSubscription(mqttCompanyName);

    if (topics.isEmpty) {
      return;
    }

    for (final topic in topics) {
      client.subscribe(topic, MqttQos.atLeastOnce);
    }
  }

  String _getRandomClientId() {
    return 'flutter_client_${DateTime.now().millisecondsSinceEpoch}';
  }

  /// Converts a map to a Uint8Buffer to be sent as a message payload.
  typed.Uint8Buffer convertMapToBuffer(Map<String, dynamic> data) {
    // Serialize the map to a JSON string
    String jsonString = jsonEncode(data);

    // Encode the JSON string to a list of bytes
    List<int> byteList = utf8.encode(jsonString);

    // Convert the list of bytes to a Uint8Buffer
    typed.Uint8Buffer buffer = typed.Uint8Buffer();
    buffer.addAll(byteList);

    return buffer;
  }

  void _onConnected() {
    debugPrint('Connection to MQTT Broker at $_brokerUrl established');
  }

  void _onDisconnected() {
    debugPrint('Disconnected from MQTT Broker at $_brokerUrl');
  }

  void _onSubscribed(String topic) {
    debugPrint('Subscribed to topic: $topic');
  }

  void _onUnsubscribed(String? topic) {
    if (topic != null && topic.isNotEmpty) {
      debugPrint('Unsubscribed from topic: $topic');
    }
  }
}

@Riverpod(keepAlive: true)
MqttService mqttService(MqttServiceRef ref) {
  final dao = ref.watch(mqttDaoProvider);
  return MqttService(dao, ref);
}

@Riverpod(keepAlive: true)
FutureOr<MqttServerClient> mqttServerClient(MqttServerClientRef ref) async {
  final service = ref.watch(mqttServiceProvider);
  final client = await service.connect();
  ref.onDispose(() {
    client.disconnect();
  });
  return client;
}
