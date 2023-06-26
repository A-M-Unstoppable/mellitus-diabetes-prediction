import '../network/network.dart';

class Common {
  postMap(
      String url,
      Map<String, dynamic> body,
      var callback,
      FunctionVoidCallback errorCallback,
      ) async {
    var res = await globalRequest(
        path: url, isGet: false, body: body, errorCallback: errorCallback);
    callback(res);
    return res;
  }
}