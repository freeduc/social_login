class ApiResponse {
  ApiResponse({
    this.code = 500,
    this.data,
    this.msg = '',
  }) {
    success = (code == 200 ? true : false);
  }

  int code;
  String msg;
  var data;
  bool success = false;

  factory ApiResponse.fromJson(Map<String, dynamic> json) {
    ApiResponse apiResponse = ApiResponse();

    apiResponse.code = json['code'];
    apiResponse.msg = json['msg'];
    apiResponse.data = json['data'];
    apiResponse.success = json['success'];

    return apiResponse;
  }

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'code': code,
      'msg': msg,
      'data': data,
      'success': success,
    };
  }

  factory ApiResponse.failed({int? code, String? msg}) {
    ApiResponse apiResponse = ApiResponse();

    apiResponse.code = code ?? 500;
    apiResponse.msg = msg ?? '알 수 없는 에러';
    apiResponse.success = false;

    return apiResponse;
  }

  factory ApiResponse.success({int? code, String? msg}) {
    ApiResponse apiResponse = ApiResponse();

    apiResponse.code = code ?? 200;
    apiResponse.msg = msg ?? '성공';
    apiResponse.success = true;

    return apiResponse;
  }
}
