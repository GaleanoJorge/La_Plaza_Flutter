import 'package:flutter/material.dart';
import 'package:la_plaza/src/models/bazzaio_model.dart';
import 'package:la_plaza/src/utils/values.dart' as utils;
import 'package:http/http.dart' as http;

class BazzaioProvider {

  Future<Bazzaio?> search(String search) async {
    Uri _urlSearch = Uri.parse('${utils.Values.urlBase}');
    http.Response response = await http.get(_urlSearch);
    Bazzaio bazzaio = bazzaioFromJson(response.body.toString());
    return bazzaio;
  }
}