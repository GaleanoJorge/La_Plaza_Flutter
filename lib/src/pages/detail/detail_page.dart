import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:la_plaza/src/pages/detail/detail_controller.dart';
import 'package:la_plaza/src/utils/values.dart' as utils;

class Detail extends StatefulWidget {
  Detail({Key? key}) : super(key: key);

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  final DetailController _con = DetailController();

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance!.addPostFrameCallback((timeStamp) {
      _con.init(context, refresh);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        title: Text(
          _con.product != null ? _con.product!.nombre : '',
          style: const TextStyle(color: Colors.black54, fontWeight: FontWeight.bold),
          overflow: TextOverflow.ellipsis,
        ),
        centerTitle: true,
        backgroundColor: const Color(0x00ff0000),
      ),
      body: SafeArea(child: _con.isChecked ? _body() : _loading()),
    );
  }

  Widget _loading() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.7,
      child: const Center(
        child:
            SizedBox(width: 80, height: 80, child: CircularProgressIndicator()),
      ),
    );
  }

  Widget _body() {
    return ListView(
      children: [
        Column(
          children: [
            _imagenGrande(),
            _imagenPeque(),
            const SizedBox(
              height: 20,
            ),
            _card(),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ],
    );
  }

  Container _imagenGrande() {
    return Container(
      padding: const EdgeInsets.all(15),
      alignment: Alignment.center,
      child: Image.network(
        _con.product!.imagen,
        width: MediaQuery.of(context).size.width * 0.4,
        height: MediaQuery.of(context).size.width * 0.4,
        fit: BoxFit.fill,
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      ),
    );
  }

  Widget _imagenPeque() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10), // Image border
        child: SizedBox.fromSize(
          size: Size.fromRadius(
              MediaQuery.of(context).size.width * 0.15), // Image radius
          child: Image.network(
            _con.product!.imagen,
            fit: BoxFit.cover,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) return child;
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _card() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            _cardTitle(),
            Container(
              alignment: Alignment.topLeft,
              child: Text(_con.product!.descripcion,
                  style: const TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold)),
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  _con.valor,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    decoration: TextDecoration.lineThrough,
                    color: Colors.red,
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            Container(
                alignment: Alignment.topLeft,
                child: Text(
                  _con.descuento,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.green,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                  ),
                )),
            const SizedBox(
              height: 10,
            ),
            _counter(),
            const SizedBox(
              height: 15,
            ),
            _boton(),
            const SizedBox(
              height: 15,
            ),
            _andCard(),
          ],
        ),
      ),
    );
  }

  Row _cardTitle() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: Text(
                    _con.product!.nombre,
                    style: const TextStyle(
                        fontSize: 18,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  )),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.favorite_border_outlined, color: Colors.grey,)),
                  )
            ],
          );
  }

  Widget _counter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 10,
              offset: const Offset(0, 5), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
                onPressed: () {
                  if (_con.count > 0) {
                    _con.count--;
                    refresh();
                  }
                },
                icon: const Icon(Icons.keyboard_arrow_down)),
            Text(_con.count.toString()),
            IconButton(
                onPressed: () {
                  if (_con.count >= 0) {
                    _con.count++;
                    refresh();
                  }
                },
                icon: const Icon(Icons.keyboard_arrow_up)),
          ],
        ),
      ),
    );
  }

  Widget _boton() {
    return RaisedButton.icon(
        color: Colors.green[300],
        onPressed: () {},
        icon: const Padding(
          padding: EdgeInsets.only(left: 15),
          child: Icon(
            Icons.shopping_basket_outlined,
            color: Colors.white,
            size: 30,
          ),
        ),
        label: const Padding(
          padding: EdgeInsets.symmetric(vertical: 15),
          child: Text(
            utils.Values.shoppingAdd,
            style: TextStyle(
                color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget _andCard() {
    return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  alignment: Alignment.topLeft,
                  child: const Text(
                    utils.Values.description,
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.black54,
                        fontWeight: FontWeight.bold),
                  )),
                  Container(
                    alignment: Alignment.topRight,
                    child: IconButton(onPressed: (){}, icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey,)),
                  )
            ],
          );
  }

  void refresh() => setState(() {});

}
