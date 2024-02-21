import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:showcase/models/page_model.dart';
import 'package:showcase/models/response_model.dart';

class Api {
  static const String base = "https://reqres.in/api";

  Future<ResponseModel> register({required String email, required String password}) async {
    const String url = "$base/register";

    Map<String, String> body = {"email": email, "password": password};

    http.Response response = await http.post(Uri.parse(url), body: json.encode(body));
    debugPrint(response.reasonPhrase);

    ResponseModel model = ResponseModel(statusCode: response.statusCode, message: response.reasonPhrase);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      model.body = data;
    }

    return model;
  }

  Future<ResponseModel> login({required String email, required String password}) async {
    const String url = "$base/login";

    Map<String, dynamic> body = {"email": email, "password": password};

    http.Response response = await http.post(Uri.parse(url), body: body);
    debugPrint(response.reasonPhrase);

    ResponseModel model = ResponseModel(statusCode: response.statusCode, message: response.reasonPhrase);

    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);

      model.body = data;
    }

    return model;
  }

  Future<PageModel?> getPage({int page = 1}) async {
    final String url = "$base/users?page=$page";

    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      return PageModel.fromJson(jsonDecode(response.body));
    } else {
      return null;
    }
  }
}
