// To parse this JSON data, do
//
//     final watchDogModel = watchDogModelFromJson(jsonString);

import 'dart:convert';

WatchDogModel watchDogModelFromJson(String str) =>
    WatchDogModel.fromJson(json.decode(str));

String watchDogModelToJson(WatchDogModel data) => json.encode(data.toJson());

class WatchDogModel {
  WatchDogModel({
    required this.id,
    required this.status,
    required this.deviceId,
    required this.aspDeviceId,
    required this.humidity,
    required this.temperature,
    required this.powerOutage,
    required this.powerOutageDuration,
    required this.battery,
    required this.ac,
    required this.entryTime,
    required this.acStatus,
    required this.generatorStatus,
  });

  final String? id;
  final String? status;
  final String? deviceId;
  final String? aspDeviceId;
  final String? humidity;
  final String? temperature;
  final String? powerOutage;
  final int? powerOutageDuration;
  final String? battery;
  final String? ac;
  final String? entryTime;
  final String? acStatus;
  final String? generatorStatus;

  factory WatchDogModel.fromJson(Map<String, dynamic> json) => WatchDogModel(
        id: json["id"] ?? "0",
        status: json["status"] ?? "0",
        deviceId: json["device_id"] ?? "0",
        aspDeviceId: json["asp_device_id"] ?? "0",
        humidity: json["humidity"] ?? "0",
        temperature: json["temperature"] ?? "0",
        powerOutage: json["powerOutage"] ?? "00:00:00",
        powerOutageDuration: json["powerOutageDuration"] ?? 0,
        battery: json["battery"] ?? "0",
        ac: json["ac"] ?? "0",
        entryTime: json["entry_time"] ?? "00:00:00",
        acStatus: json["ac_status"] ?? "0",
        generatorStatus: json["generator_status"] ?? "0",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "status": status,
        "device_id": deviceId,
        "asp_device_id": aspDeviceId,
        "humidity": humidity,
        "temperature": temperature,
        "powerOutage": powerOutage,
        "powerOutageDuration": powerOutageDuration,
        "battery": battery,
        "ac": ac,
        "entry_time": entryTime,
        "ac_status": acStatus,
        "generator_status": generatorStatus,
      };
}
