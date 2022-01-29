import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AmountCop {
  final format = NumberFormat("#,##0.00", "en_US");
  late String valor;
  late String porcentaje;

  AmountCop(String valor, String porcentaje) {
    this.valor = valor;
    this.porcentaje = porcentaje;
  }

  String getValor() {
    return '\$ ${format.format(double.parse(valor))} COP';
  }

  String getDescuento() {
    double value = double.parse(valor);
    double per = double.parse(porcentaje) / 100;
    return '\$ ${format.format(double.parse((value * (1 - per)).toStringAsFixed(0)))} COP';
  }
}
