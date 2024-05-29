import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/utils/delay.dart';
import 'package:mqtt_client/mqtt_client.dart';
import 'package:mqtt_client/mqtt_server_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:typed_data/typed_data.dart' as typed;

import 'package:irrigazione_iot/env/env.dart';

part 'mqtt_client_service.g.dart';

/// Holds logic to connect to the MQTT broker and publish messages.
class MqttClientService {
  const MqttClientService();

  static final _brokerUrl = Env.mqttBrokerUrl;
  static final _brokerUsername = Env.mqttBrokerUsername;
  static final _brokerPassword = Env.mqttBrokerPassword;

  /// Publishes a message to the given topic.
  /// Throws an exception if the message could not be published.
  /// The client is disconnected after the message is published.
  ///
  /// Returns the message ID of the published message.˚
  Future<int> publishMessage(MqttServerClient client, String topic,
      Map<String, dynamic> message) async {
    try {
      final builder = MqttClientPayloadBuilder();
      builder.addBuffer(convertMapToBuffer(message));

      final messageId = client.publishMessage(
        topic,
        MqttQos.atLeastOnce,
        builder.payload!,
      );

      // add 10 seconds delay to allow supabase data sync
      await delay(true, 5000);

      client.disconnect();
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

    try {
      await client.connect(_brokerUsername, _brokerPassword);

      if (client.connectionStatus!.state == MqttConnectionState.connected) {
        return client;
      } else {
        debugPrint(
            'Failed to connect to MQTT Broker at $_brokerUrl - state: ${client.connectionStatus!.state}');
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
}

@Riverpod(keepAlive: true)
MqttClientService mqttClientService(MqttClientServiceRef ref) {
  return const MqttClientService();
}
