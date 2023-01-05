// To parse this JSON data, do
//
//     final activeEspListModel = activeEspListModelFromJson(jsonString);

import 'dart:convert';

ActiveEspListModel activeEspListModelFromJson(String str) =>
    ActiveEspListModel.fromJson(json.decode(str));

String activeEspListModelToJson(ActiveEspListModel data) =>
    json.encode(data.toJson());

class ActiveEspListModel {
  final String? status;
  final List<ActiveAsp?>? activeAsp;

  ActiveEspListModel({
    required this.status,
    required this.activeAsp,
  });

  factory ActiveEspListModel.fromJson(Map<String, dynamic> json) =>
      ActiveEspListModel(
        status: json["STATUS"],
        activeAsp: List<ActiveAsp>.from(
            json["ACTIVE_ASP"].map((x) => ActiveAsp.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "STATUS": status,
        "ACTIVE_ASP": List<dynamic>.from(activeAsp!.map((x) => x!.toJson())),
      };
}

class ActiveAsp {
  final String? id;
  final String? serialNo;
  final String? name;
  final String? description;
  final String? status;
  final String? entryTime;

  ActiveAsp({
    required this.id,
    required this.serialNo,
    required this.name,
    required this.description,
    required this.status,
    required this.entryTime,
  });

  factory ActiveAsp.fromJson(Map<String, dynamic> json) => ActiveAsp(
        id: json["id"] ?? "id",
        serialNo: json["serial_no"] ?? "serial_no",
        name: json["name"] ?? "name",
        description: json["description"] ?? "description",
        status: json["status"] ?? "status",
        entryTime: json["entry_time"] ?? "entry_time",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "serial_no": serialNo,
        "name": name,
        "description": description,
        "status": status,
        "entry_time": entryTime,
      };
}
