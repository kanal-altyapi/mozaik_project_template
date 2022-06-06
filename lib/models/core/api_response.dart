// import 'package:ziraat_mobile_approval/models/core/api_error_response.dart';
// import 'package:ziraat_mobile_approval/models/login_response.dart';
// import '../models_export.dart';
// import 'moz_model/bool_data_models.dart';

// class ApiResponse<T> {
//   ApiResponse({this.data, this.dataList, this.isSuccess, this.errorResponse, this.message, this.statusCode, this.requestId});

//   int statusCode;
//   bool isSuccess;
//   T data;
//   List<T> dataList;
//   String message;
//   ApiErrorResponse errorResponse;
//   String requestId;

//   factory ApiResponse.fromJsonForData(Map<String, dynamic> json, T data, {String transferData}) {
//     final bool isSuccess = json['isSuccess'] as bool;
//     final String message = json['message'] as String;
//     final int statusCode = json['statusCode'] as int;
//     final String requestId = json['requestId'] as String;

//     ApiErrorResponse errorResponse;
//     if (isSuccess == false && json['errorResponse'] != null) {
//       errorResponse = ApiErrorResponse.fromJson(json['errorResponse'] as Map<String, dynamic>);
//     }

//     if (data is LoginResponse) {
//       data = LoginResponse.fromMap(json) as T;
//     } else if (data is SmsResponse) {
//       data = SmsResponse.fromJson(json) as T;
//     } else if (data is MobileApprovementDetail) {
//       data = MobileApprovementDetail.fromJson(json['data']['mobileApprovementDetail'], transferData) as T;
//     } else if (data is MobileApprovementActionResult) {
//       data = MobileApprovementActionResult.fromJson(json['data']) as T;
//     } else if (data is BoolData) {
//       bool curValue;
//       if ((json['data'] as bool) == true) {
//         curValue = true;
//       } else {
//         curValue = false;
//       }
//       data = BoolData(curValue) as T;
//     } else if (data is MobileApprovementActionResultCollection) {
//       data = MobileApprovementActionResultCollection.fromJson(json['data'] as Map<String, dynamic>) as T;
//     } else if (data is DocumentDetail) {
//       data = DocumentDetail.fromJson(json['data']) as T;
//     }
//     return ApiResponse(
//         data: data,
//         dataList: null,
//         errorResponse: errorResponse,
//         isSuccess: isSuccess,
//         message: message,
//         statusCode: statusCode,
//         requestId: requestId);
//   }

//   factory ApiResponse.fromJsonForDataList(Map<String, dynamic> json, List<T> dataListInspector) {
//     final bool isSuccess = json['isSuccess'] as bool;
//     final String message = json['message'] as String;
//     final int statusCode = json['statusCode'] as int;
//     final String requestId = json['requestId'] as String;

//     ApiErrorResponse errorResponse;
//     if (isSuccess == false && json['errorResponse'] != null) {
//       errorResponse = ApiErrorResponse.fromJson(json['errorResponse'] as Map<String, dynamic>);
//     }

//     if (dataListInspector is List<NotificationPayload>) {
//       dataListInspector = List<T>.from((json['data'] as List<dynamic>)
//           // ignore: always_specify_types
//           .map((x) => NotificationPayload.fromJson(x as Map<String, dynamic>)));
//     } else if (dataListInspector is List<MobileApprovementInfo>) {
//       dataListInspector = List<T>.from((json['data']['mobileApprovementInfo'] as List<dynamic>)
//           // ignore: always_specify_types
//           .map((x) => MobileApprovementInfo.fromJson(x as Map<String, dynamic>)));
//     }

//     return ApiResponse(
//         data: null,
//         dataList: dataListInspector,
//         errorResponse: errorResponse,
//         isSuccess: isSuccess,
//         message: message,
//         statusCode: statusCode,
//         requestId: requestId);
//   }
// }
