import 'package:mozaik_common/api-common/error_response.dart';
import 'package:mozaik_common/api-common/moz_api_base_response.dart';

class ApiResponse<T> extends MozaikApiBaseResponse<T> {
  ApiResponse(T? data, List<T>? dataList, ErrorResponse? errorResponse, bool isSuccess, String? message)
      : super(data: data, dataList: dataList, errorResponse: errorResponse, isSuccess: isSuccess, message: message);

  factory ApiResponse.fromJsonForDataList(
      {required Map<String, dynamic> json, required List<T> dataList, required SetDataList<T> setDataList, String? transferData}) {
    final MozaikApiBaseResponse<T> response = MozaikApiBaseResponse.fromJsonForDataList(json, dataList, setDataList);
    return ApiResponse<T>(null, response.dataList, response.errorResponse, response.isSuccess, response.message);
  }

  factory ApiResponse.fromJsonForData({required Map<String, dynamic> json,  T? data, required SetData<T> setData, String? transferData}) {
    final MozaikApiBaseResponse<T> response = MozaikApiBaseResponse.fromJsonForData(json, data, setData,transferData: transferData);

    return ApiResponse<T>(response.data, null, response.errorResponse, response.isSuccess, response.message);
  }
}
