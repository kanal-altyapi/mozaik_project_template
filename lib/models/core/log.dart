// import 'package:ziraat_mobile_approval/models/core/core_models_export.dart';

// class Log implements IApiBaseModel {
//   String message;
//   dynamic ex;
//   StackTrace stackTrace;
//   dynamic context;
//   String exceptionId;
//   String sessionId;
//   DateTime sessionStartTime;
//   DateTime errorTime;
//   String environment;
//   String bundleName;
//   bool addCustomKey;
//   String userName;
//   String deviceId;
//   String osType;
//   String osVersion;
//   String phoneNumber;
//   String applicationVersion;
//   String logLevel;
//   String recordTrxCode;
//   String recordUserCode;
//   String branchCode;

//   Log(
//       {this.context,
//       this.ex,
//       this.message,
//       this.stackTrace,
//       this.exceptionId,
//       this.sessionId,
//       this.sessionStartTime,
//       this.errorTime,
//       this.environment,
//       this.bundleName,
//       this.addCustomKey = true,
//       this.userName,
//       this.deviceId,
//       this.osType,
//       this.osVersion,
//       this.phoneNumber,
//       this.applicationVersion,
//       this.logLevel,
//       this.recordTrxCode,
//       this.recordUserCode,
//       this.branchCode});

//   @override
//   String toString() {
//     String result = '';

//     if (exceptionId != null) {
//       result = "User Exception Id:" + exceptionId;
//     }
//     if (message != null && message != "") {
//       result = result + " Message: $message ";
//     }
//     if (sessionId != null && sessionId != "") {
//       result = result + " sessionId: $sessionId ";
//     }
//     if (ex != null) {
//       result = result + " Exception:" + ex.toString();
//     }
//     if (stackTrace != null) {
//       result = result + " StackTrace:" + stackTrace.toString();
//     }
//     if (context != null) {
//       result = result + " Context:" + context.toString();
//     }
//     if (environment != null) {
//       result = result + " environment:" + environment;
//     }
//     if (sessionStartTime != null) {
//       result = result + " sessionStartTime:" + sessionStartTime.toString();
//     }
//     if (errorTime != null) {
//       result = result + " errorTime:" + errorTime.toString();
//     }
//     if (bundleName != null) {
//       result = result + " requestId:" + bundleName;
//     }

//     if (userName != null) {
//       result = result + " userName:" + userName;
//     }
//     if (deviceId != null) {
//       result = result + " deviceId:" + deviceId;
//     }
//     if (osType != null) {
//       result = result + " osType:" + osType;
//     }
//     if (osVersion != null) {
//       result = result + " osVersion:" + osVersion;
//     }
//     if (phoneNumber != null) {
//       result = result + " phoneNumber:" + phoneNumber;
//     }
//     if (applicationVersion != null) {
//       result = result + " applicationVersion:" + applicationVersion;
//     }
//     if (logLevel != null) {
//       result = result + " logLevel:" + logLevel;
//     }
//     if (branchCode != null) {
//       result = result + " branchCode:" + branchCode;
//     }
//     return result;
//   }

//   Map<String, dynamic> toMap() {
//     final Map<String, dynamic> map = <String, dynamic>{};
//     map['Context'] = context.toString();
//     map['ExceptionDsc'] = ex.toString().substring(
//         0, ex.toString().length < 4000 ? ex.toString().length : 3999);
//     map['MessageDsc'] =
//         message.substring(0, message.length < 4000 ? message.length : 3999);
//     map['StackTraceDsc'] = stackTrace.toString().substring(
//         0,
//         stackTrace.toString().length < 4000
//             ? stackTrace.toString().length
//             : 3999);
//     map['ExceptionUid'] = exceptionId;
//     map['SessionUid'] = sessionId;
//     map['SessionStartTm'] = sessionStartTime.toString();
//     map['ErrorTm'] = errorTime.toString();
//     map['Environment'] = environment;
//     map['BundleNm'] = bundleName.substring(
//         0, bundleName.length < 100 ? bundleName.length : 99);
//     map['AddCustomKey'] = addCustomKey;
//     map['UserNm'] =
//         userName.substring(0, userName.length < 100 ? userName.length : 99);
//     map['DeviceUid'] =
//         deviceId.substring(0, deviceId.length < 36 ? deviceId.length : 35);
//     map['OsTypeDsc'] =
//         osType.substring(0, osType.length < 20 ? osType.length : 19);
//     map['OsTypeVersionDsc'] =
//         osVersion.substring(0, osVersion.length < 20 ? osVersion.length : 19);
//     map['PhoneNumberDsc'] = phoneNumber;
//     map['ApplicationVersionCd'] = applicationVersion.substring(
//         0, applicationVersion.length < 20 ? applicationVersion.length : 19);
//     map['LevelCd'] = logLevel;
//     map['RecordTrxCd'] = recordTrxCode.substring(
//         0, recordTrxCode.length < 100 ? recordTrxCode.length : 99);
//     map['RecordUserCd'] = recordUserCode.substring(
//         0, recordUserCode.length < 20 ? recordUserCode.length : 19);
//     map['RecordTm'] = DateTime.now().toString();

//     return map;
//   }

//   Log.fromJson(Map<String, dynamic> json) {
//     context = json['context'];
//     ex = json['ex'];
//     message = json['message'];
//     stackTrace = json['stackTrace'];
//     exceptionId = json['exceptionId'];
//     sessionId = json['sessionId'];
//     sessionStartTime = json['sessionStartTime'];
//     errorTime = json['errorTime'];
//     environment = json['environment'];
//     bundleName = json['bundleName'];
//     addCustomKey = json['addCustomKey'];
//     userName = json['userName'];
//     deviceId = json['deviceId'];
//     osType = json['osType'];
//     osVersion = json['osVersion'];
//     phoneNumber = json['phoneNumber'];
//     applicationVersion = json['applicationVersion'];
//     logLevel = json['logLevel'];
//     recordTrxCode = json['recordTrxCode'];
//   }
// }
