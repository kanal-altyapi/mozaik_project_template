// import 'package:ziraat_mobile_approval/models/core/core_models_export.dart';

// import 'log.dart';

// class LogRequest implements IApiBaseModel {
//   LogRequest({
//     this.logs,
//     this.operationTime,
//   });

//   List<Log> logs;

//   DateTime operationTime;

//   factory LogRequest.fromJson(Map<String, dynamic> json) => LogRequest(
//         logs: List<Log>.from(json["logs"].map((x) => Log.fromJson(x))),
//         operationTime: DateTime.parse(json["operationTime"]),
//       );

//   Map<String, dynamic> toMap() => {
//         "logs": List<dynamic>.from(logs.map((x) => x.toMap())),
//         "operationTime": operationTime.toIso8601String(),
//       };
// }
