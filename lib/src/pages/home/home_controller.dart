import 'package:flutter/material.dart';
import 'package:la_plaza/src/models/bazzaio_model.dart';
import 'package:la_plaza/src/providers/bazzaio_provider.dart';

class HomeController {
  BuildContext? context;
  late Function refresh;

  late BazzaioProvider _bazzaioProvider;
  Bazzaio? bazzaio = null;

  GlobalKey<FormState> keyForm = GlobalKey();

  TextEditingController serchController = TextEditingController();

  bool isSearched = true;

  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;

    _bazzaioProvider = BazzaioProvider();
  }

  void buscar() async {
    bazzaio = await _bazzaioProvider.search('');
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
    double per = double.parse(porcentaje)/100;

    return (value*(1-per)).toString();
  }
}
