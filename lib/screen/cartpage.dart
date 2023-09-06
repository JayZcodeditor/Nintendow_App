import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/app_config.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  static const routeName = "/cart";
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  Widget mainBody = Container();
  List<Cart> _cartList = [];

  Future<void> getCart() async {
    var url = Uri.http(AppConfig.server, "Cart");
    var resp = await http.get(url);
    setState(() {
      _cartList = cartFromJson(resp.body);
      mainBody = showCart(_cartList);
    });
  }

  @override
  void initState() {
    super.initState();
    getCart();
  }

  Widget showCart(List<Cart> _cartList) {
    double pricetotal = 0.0;
    for (Cart cart in _cartList) {
      double subtotal = (cart.total ?? 1) * (cart.sprice ?? 0.0);
      pricetotal += subtotal;
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            itemCount: _cartList.length,
            itemBuilder: (context, index) {
              Cart cart = _cartList[index];
              return Dismissible(
                key: UniqueKey(),
                direction: DismissDirection.endToStart,
                background: Container(
                  color: Colors.red,
                  margin: EdgeInsets.symmetric(horizontal: 15),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  child: ListTile(
                    leading: Image.network("${cart.spicture}"),
                    title: Text("${cart.stitle}"),
                    subtitle: Text("${cart.srelease}"),
                    trailing: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "Price \$${cart.sprice}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Count ${cart.total}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  removercart(cart);
                },
              );
            },
          ),
        ),
        Text(
          'Total Price \$${pricetotal}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart Page"),
      ),
      body: mainBody,
    );
  }

  Future<void> removercart(Cart cart) async {
    var url = Uri.http(AppConfig.server, "Cart/${cart.id}");
    var resp = await http.delete(url);
    print(resp.body);
    await getCart();
  }
}
