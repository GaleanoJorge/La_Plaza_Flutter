import 'package:flutter/material.dart';
import 'package:la_plaza/src/models/bazzaio_model.dart';
import 'package:la_plaza/src/providers/bazzaio_provider.dart';
import 'package:la_plaza/src/utils/shared_preferences.dart';

class HomeController {
  BuildContext? context;
  late Function refresh;

  late BazzaioProvider _bazzaioProvider;
  Bazzaio? bazzaio = null;

  List<String> busquedas = [];
  late SharedPref _sharedPref;

  GlobalKey<FormState> keyForm = GlobalKey();

  TextEditingController searchController = TextEditingController();

  bool isSearched = true;
  bool primeraBusqueda = false;
  bool hasPressed = true;

  Future? init(BuildContext context, Function refresh) async {
    this.context = context;
    this.refresh = refresh;

    _bazzaioProvider = BazzaioProvider();
    _sharedPref = SharedPref();

    List<String>? res = await _sharedPref.readList('busquedas');
    if (res != null) {
      for (String i in res) {
        busquedas.add(i);
        print('+++++++++++++++++++++++ $i ++++++++++++++++++++++');
      }
    }
  }

  void buscar() async {
    hasPressed = true;
    if (searchController.text.isNotEmpty) {
      primeraBusqueda = true;
      var bool = !busquedas.contains(searchController.text);
      if (bool) {
        busquedas.add(searchController.text);
        _sharedPref.saveList('busquedas', busquedas);
      }
      bazzaio = null;
      bazzaio = await _bazzaioProvider.search('');
    }
    isSearched = true;
    refresh();
  }

  void sendProduct(Product product) {
    Map<String, dynamic> data = {
      'product': product,
    };
    Navigator.pushNamed(context!, '/detail', arguments: data);
  }

  String descuento(String valor, String porcentaje) {
    double value = double.parse(valor);
    double per = double.parse(porcentaje) / 100;

    return (value * (1 - per)).toString();
  }

  void textChange(String val) {
    if (busquedas.isNotEmpty) hasPressed = false;
    refresh();
  }
}
