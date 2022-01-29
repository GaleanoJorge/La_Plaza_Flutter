import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:la_plaza/src/models/bazzaio_model.dart';
import 'package:la_plaza/src/pages/home/home_controller.dart';
import 'package:la_plaza/src/utils/values.dart' as utils;
import 'package:la_plaza/src/widgets/product_preview.dart';

class Home extends StatefulWidget {
  Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final HomeController _con = HomeController();

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
      body: SafeArea(
        child: ListView(
          children: [
            _header(),
            _con.isSearched ? _body() : _loading(),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const SizedBox(
          height: 30,
        ),
        Image.asset('assets/title.png',
        height: 70,),
        // const Text(utils.Values.titleApp),
        const SizedBox(
          height: 30,
        ),
        Form(
            key: _con.keyForm,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(color: Colors.black12),
                  child: TextFormField(
                    controller: _con.serchController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: '   Buscar',
                      suffixIcon: IconButton(
                        onPressed: () {
                          _con.isSearched = false;
                          refresh();
                          _con.buscar();
                        },
                        icon: const Icon(
                          Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (validate) {
                      if (validate == null || validate.isEmpty) {
                        return 'Buscar';
                      }
                      return null;
                    },
                  ),
                ),
              ),
            )),
      ],
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
    return Container(
      width: MediaQuery.of(context).size.width,
      child: _con.bazzaio != null ? _request() : _noResults(),
    );
  }

  Widget _request() {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      child: _productList(),
    );
  }

  Widget _productList() {
    return ListView(children: [
      const Padding(
        padding: EdgeInsets.all(8.0),
        child: Text(
          'Todos los productos',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      Wrap(
        alignment: WrapAlignment.spaceEvenly,
        spacing: 8.0, // gap between adjacent chips
        runSpacing: 4.0,
        children: _con.bazzaio!.data
            .map((e) => _provicionalProductView(e))
            .toList()
            .cast<Widget>(),
      ),
    ]);
  }

  Widget _provicionalProductView(Product product) {
    return ProductPreview(onPress: () {_con.sendProduct(product);}, product: product);
  }

  Widget _noResults() {
    return Center(
      child: Text('No se encontraron resultados'),
    );
  }

  void refresh() => setState(() {});
}
