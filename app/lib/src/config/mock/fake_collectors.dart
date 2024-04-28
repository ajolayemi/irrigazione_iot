import 'package:irrigazione_iot/src/features/collectors/model/collector.dart';

final kFakeCollectors = [
  Collector(
    id: '1',
    name: 'S1 (cisterne)',
    companyId: '1',
    hasFilter: true,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '2',
    name: 'S2 (pozzo)',
    companyId: '1',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '3',
    name: "O1 Mx2a",
    companyId: '1',
    hasFilter: true,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '4',
    name: "O4 (uliveto)",
    companyId: '2',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '5',
    name: 'S3 (reservoir)',
    companyId: '1',
    hasFilter: true,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '6',
    name: 'S4 (well)',
    companyId: '1',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '7',
    name: 'O2 Mx2b',
    companyId: '1',
    hasFilter: true,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '8',
    name: 'O5 (olive grove)',
    companyId: '2',
    hasFilter: false,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '9',
    name: 'O6 (vineyard)',
    companyId: '2',
    hasFilter: false,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '10',
    name: 'O7 Mx2c',
    companyId: '2',
    hasFilter: true,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '11',
    name: 'S5 (tank)',
    companyId: '3',
    hasFilter: false,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '12',
    name: 'S6 (borehole)',
    companyId: '3',
    hasFilter: false,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '13',
    name: 'O3 Mx2d',
    companyId: '3',
    hasFilter: true,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '14',
    name: 'O8 (orchard)',
    companyId: '4',
    hasFilter: false,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '15',
    name: 'O9 (field)',
    companyId: '4',
    hasFilter: false,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '16',
    name: 'O10 Mx2e',
    companyId: '4',
    hasFilter: true,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '17',
    name: 'S7 (cistern)',
    companyId: '5',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '18',
    name: 'S8 (well)',
    companyId: '5',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '19',
    name: 'O11 Mx2f',
    companyId: '5',
    hasFilter: true,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '20',
    name: 'O12 (olive grove)',
    companyId: '6',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '21',
    name: 'O13 (vineyard)',
    companyId: '6',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '22',
    name: 'S9 (tank)',
    companyId: '6',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '23',
    name: 'S10 (borehole)',
    companyId: '7',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '24',
    name: 'O14 Mx2g',
    companyId: '7',
    hasFilter: true,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '25',
    name: 'O15 (orchard)',
    companyId: '7',
    hasFilter: false,
    createdAt: DateTime.parse('2024-01-01'),
    updatedAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
  Collector(
    id: '26',
    name: 'O16 (field)',
    companyId: '4',
    hasFilter: false,
    updatedAt: DateTime.parse('2024-01-01'),
    createdAt: DateTime.parse('2024-01-01'),
    mqttMsgName: 'mqtt_msg_name',
  ),
];
