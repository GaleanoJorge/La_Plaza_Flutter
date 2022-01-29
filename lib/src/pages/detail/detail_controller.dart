import 'package:flutter/material.dart';
import 'package:la_plaza/src/models/bazzaio_model.dart';
import 'package:intl/intl.dart';
import 'package:la_plaza/src/providers/amout.dart';

class DetailController {
  BuildContext? context;
  late Function refresh;

  late AmountCop _amountCop;
  late String valor;
  late String descuento;

  int count = 0;

  Product? product = null;

  bool isChecked = false;

  final format = NumberFormat("#,##0.00", "en_US");


  Future? init(BuildContext context, Function refresh) {
    this.context = context;
    this.refresh = refresh;

    Map<dynamic, dynamic>? data =
        ModalRoute.of(context)!.settings.arguments as Map<dynamic, dynamic>;

    if (data != null) {
      product = data['product'];
      _amountCop = AmountCop(product!.precio, product!.valorPromo);
      valor = _amountCop.getValor();
      descuento = _amountCop.getDescuento();
    }
    isChecked = true;
    refresh();
  }
}
