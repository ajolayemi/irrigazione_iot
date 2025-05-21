// ignore_for_file: avoid_manual_providers_as_generated_provider_dependency
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_pressure.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typed_data/typed_data.dart' as typed;

import 'package:irrigazione_iot/env/env.dart';
import 'package:irrigazione_iot/src/config/data/mqtt_configs.dart';
import 'package:irrigazione_iot/src/config/enums/mqtt_enums.dart';
import 'package:irrigazione_iot/src/data/datasource/dao/mqtt_dao.dart';
import 'package:irrigazione_iot/src/features/collectors/models/collector_pressure.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_flow.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_pressure.dart';
import 'package:irrigazione_iot/src/features/pumps/models/pump_status.dart';
import 'package:irrigazione_iot/src/features/sectors/models/sector_status.dart';
import 'package:irrigazione_iot/src/features/terminal/models/terminal_pressure.dart';
import 'package:irrigazione_iot/src/shared/models/item_status_request.dart';
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
    try {
      await client.connect(_brokerUsername, _brokerPassword);

      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        _subscribeToTopics(client);
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
    List<PumpStatus> pumpStatuses = [];
    List<SectorStatus> sectorStatuses = [];
    List<PumpFlow> pumpFlows = [];
    List<PumpPressure> pumpPressures = [];
    List<CollectorPressure> collectorPressures = [];
    List<TerminalPressure> terminalPressures = [];
    List<SectorPressure> sectorPressures = [];

    for (final item in data) {
      final recordMsg = item.payload;

      if (recordMsg is MqttPublishMessage) {
        final fromBytes = MqttPublishPayload.bytesToStringAsString(
          recordMsg.payload.message,
        );

        final decoded = jsonDecode(fromBytes) as Map<String, dynamic>;
        final messageType = decoded['type'].toString().toMqttMsgType();

        if (messageType == null) {
          continue;
        }

        switch (messageType) {
          case MqttMessageTypes.pumpStatus:
          case MqttMessageTypes.sectorStatus:
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
                companyId: statusObj.companyId,
                createdAt: statusObj.createdAt ?? DateTime.now(),
              );
              sectorStatuses.add(secStatus);
            }
            break;
          case MqttMessageTypes.pumpFlow:
            final pumpFlow = PumpFlow.fromJson(decoded);
            pumpFlows.add(pumpFlow);
            break;
          case MqttMessageTypes.pumpPressure:
            final pumpPressure = PumpPressure.fromJson(decoded);
            pumpPressures.add(pumpPressure);
            break;
          case MqttMessageTypes.collectorPressure:
            final collectorPressure = CollectorPressure.fromJson(decoded);
            collectorPressures.add(collectorPressure);
            break;
          case MqttMessageTypes.terminalPressure:
            final terminalPressure = TerminalPressure.fromJson(decoded);
            terminalPressures.add(terminalPressure);
            break;
          case MqttMessageTypes.sectorPressure:
            final sectorPressure = SectorPressure.fromJson(decoded);
            sectorPressures.add(sectorPressure);
            break;
        }
      }
    }

    if (pumpStatuses.isNotEmpty) {
      await _mqttDao.insertPumpStatuses(statuses: pumpStatuses);
      await _mqttDao.insertPumpsSwitchedOn(
        data: pumpStatuses.toPumpsSwitchedOn(),
      );
    } else if (sectorStatuses.isNotEmpty) {
      await _mqttDao.insertSectorStatuses(statuses: sectorStatuses);
      await _mqttDao.insertSectorsSwitchedOn(
        data: sectorStatuses.toSectorsSwitchedOn(),
      );
    } else if (pumpFlows.isNotEmpty) {
      await _mqttDao.insertPumpFlows(data: pumpFlows);
    } else if (pumpPressures.isNotEmpty) {
      await _mqttDao.insertPumpPressures(data: pumpPressures);
    } else if (collectorPressures.isNotEmpty) {
      await _mqttDao.insertCollectorPressures(data: collectorPressures);
    } else if (terminalPressures.isNotEmpty) {
      await _mqttDao.insertTerminalPressures(data: terminalPressures);
    } else if (sectorPressures.isNotEmpty) {
      await _mqttDao.insertSectorPressures(data: sectorPressures);
    }
  }

  void _subscribeToTopics(MqttServerClient client) {
    final topics = _ref.read(mqttConfigsProvider).mqttTopicsToSubscribe;

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
