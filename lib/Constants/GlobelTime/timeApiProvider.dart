import 'dart:convert';
import 'dart:io';
import 'package:auto_fix/Constants/GlobelTime/Api.dart';
import 'package:auto_fix/Constants/GlobelTime/timeMdl.dart';
import 'package:http/http.dart' as http;


class WorldTimeApiProvider {
  Future<TimeModel> getTimeRequest(String timeZone) async {
    var responseJson;

    print(Api.API_TIME_BASE_URL + "$timeZone");
    String fullUrlString = Api.API_TIME_BASE_URL + "$timeZone";
    try {
      final response =
          await http.get(Uri.parse(fullUrlString),);

      print(response.body);
      responseJson = _response(response);
      if (response.statusCode == 200) {
        return TimeModel.fromJson(json.decode(response.body));
      } else {
        return TimeModel.fromJson(json.decode(response.body));
      }
    } on SocketException{
      print("error occurred");

      //final errorLogin = ;
      //return errorLogin;
    }
    return responseJson;
  }

  dynamic _response(http.Response response) {
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body);
        print("responseJson");
        print(responseJson);
        return responseJson;

      default:
        var responseJson = json.decode(response.body);
        print("responseJson");
        print(responseJson);
        return responseJson;
    }
  }
}
