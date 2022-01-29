import 'package:flutter/material.dart';
import 'package:la_plaza/src/models/bazzaio_model.dart';
import 'package:intl/intl.dart';

class ProductPreview extends StatelessWidget {
  final Product product;
  final VoidCallback onPress;
  final format = NumberFormat("#,##0.00", "en_US");

  ProductPreview({
    required this.onPress,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.45,
        height: 350,
        child: RaisedButton(
            elevation: 5,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            color: Colors.white,
            onPressed: onPress,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Align(
                        alignment: Alignment.topCenter,
                        child: SizedBox(
                          height: 200,
                          width: 190,
                          child: ClipRRect(
                            borderRadius:
                                BorderRadius.circular(10), // Image border
                            child: SizedBox.fromSize(
                              // size: Size.fromRadius(MediaQuery.of(context).size.width * 0.35), // Image radius
                              child: Image.network(
                                product.imagen,
                                fit: BoxFit.cover,
                                loadingBuilder: (BuildContext context,
                                    Widget child,
                                    ImageChunkEvent? loadingProgress) {
                                  if (loadingProgress == null) return child;
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 170,
                            ),
                            Container(
                              alignment: Alignment.center,
                              width: 70,
                              height: 40,
                              decoration: BoxDecoration(color: Colors.green),
                              child: Text(
                                '${product.valorPromo}%',
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        product.nombre,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.grey,
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '\$ ${format.format(double.parse(product.precio))} COP',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                        ),
                      )),
                  Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '\$ ${format.format(double.parse(newValue(product.precio, product.valorPromo)))} COP',
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 17,
                          fontWeight: FontWeight.w900,
                        ),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.favorite_border_outlined)),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.shopping_basket_outlined)),
                    ],
                  ),
                ],
              ),
            )),
      ),
    );
  }

  String newValue(String valor, String porcentaje) {
    double value = double.parse(valor);
    double per = double.parse(porcentaje) / 100;

    // int res = int.parse(((value * (1 - per))/50).toStringAsFixed(0));

    // return (res*50).toStringAsFixed(0);
    return (value * (1 - per)).toStringAsFixed(0);
  }
}