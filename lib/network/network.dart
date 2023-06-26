import 'dart:developer';

import 'package:dio/dio.dart';


String host = "http://10.0.2.2:8000/";

Dio? dio;
typedef FunctionVoidCallback = void Function(void o);
Future globalRequest({
  required String path,
  required Map<String, dynamic> body,
  bool isGet = false,
  required FunctionVoidCallback errorCallback,
}) async {
  BaseOptions options =
  BaseOptions(baseUrl: host, contentType: "application/json", headers: {
    "Access-Control-Allow-Origin": "*",
    "Access-Control-Allow-Headers": "*",
    "Access-Control-Allow-Methods": "*",
    "Access-Control-Allow-Credentials": "true",
  });
  dio = Dio(options);

  Map<String, dynamic> httpBody = Map<String, dynamic>.from(body);

  log("host: $host \npath: $path \nparams: [$httpBody]");
  Map<String, dynamic> headers = ({});
  Response response;
  try {
    if (isGet) {
      response = await dio!.get(path,
          queryParameters: httpBody, options: Options(headers: headers));
    } else {
      response = await dio!
          .post(path, data: httpBody, options: Options(headers: headers));
    }
  } catch (e) {
    print("network error:$e");
    errorCallback(e);
    return {};
  }
  var result = response.data;
  print("response:$result");
  return result;
}