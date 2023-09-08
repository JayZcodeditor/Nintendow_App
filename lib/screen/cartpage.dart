import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter_application_1/models/cart.dart';
import 'package:flutter_application_1/models/app_config.dart';
import 'package:http/http.dart' as http;

class CartPage extends StatefulWidget {
  static const routeName = "/cart";
  final int? userId;
  const CartPage({Key? key, this.userId}) : super(key: key);

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  int? userId; // Store the userId in the state
  Widget mainBody = Container();
  List<Cart> _cartList = []; // Define _cartList here
  double pricetotal = 0.0; // Define pricetotal here
  double calculateTotalPrice(List<Cart> cartList) {
  double totalPrice = 0.0;
  for (Cart cart in cartList) {
    double subtotal = (cart.total ?? 1) * (cart.price ?? 0.0);
    totalPrice += subtotal;
  }
  return totalPrice;
}

@override
void initState() {
  super.initState();
  userId = widget.userId;
  getCart();
}

  Widget showCart(List<Cart> _cartList) {
    double pricetotal = 0.0;
    final userId = widget.userId; // Access userId here
    print(userId);
    for (Cart cart in _cartList) {
      double subtotal = (cart.total ?? 1) * (cart.price ?? 0.0);
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
                  margin: EdgeInsets.symmetric(vertical: 1),
                  alignment: Alignment.centerRight,
                  child: Icon(Icons.delete, color: Colors.white),
                ),
                child: Card(
                  child: Row(
                    children: [
                      Expanded(
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${cart.title}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 9,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Release Date: ",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "${cart.release}",
                                    style: TextStyle(
                                      fontSize: 12,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Genre:",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    " ${cart.type}",
                                    style: TextStyle(
                                      fontSize: 12,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Row(children: [
                            Text("Price", style: TextStyle(fontSize: 13)),
                            SizedBox(width: 15),
                            Text(
                              "${cart.price ?? 1}",
                              style: TextStyle(fontSize: 16),
                            ),
                          ]), // Price
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "Count:",
                                style: TextStyle(fontSize: 13),
                              ),
                              IconButton(
                                icon: Icon(Icons.remove,
                                    size: 20, color: Colors.black),
                                onPressed: () {
                                  // Implement the logic for decreasing count here
                                  setState(() {
                                    if (cart.total != null && cart.total! > 1) {
                                      cart.total = (cart.total ?? 1) - 1;
                                      updateCartItem(cart);
                                      getCart();
                                    }
                                  });
                                },
                              ),
                              SizedBox(
                                  width:
                                      5), // Add spacing between "-" and "Count"
                              Text(
                                "${cart.total ?? 1}",
                                style: TextStyle(fontSize: 10),
                              ),
                              SizedBox(
                                  width:
                                      5), // Add spacing between "Count" and "+"
                              IconButton(
                                icon: Icon(Icons.add,
                                    size: 20, color: Colors.black),
                                onPressed: () {
                                  // Implement the logic for increasing count here
                                  setState(() {
                                    cart.total = (cart.total ?? 0) + 1;
                                    updateCartItem(cart);
                                    getCart();
                                  });
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                onDismissed: (direction) {
                  removercart(cart);
                },
              );
            },
          ),
        ),
        SizedBox(
          height: 15,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Total',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              width: 200,
            ),
            Text(
              '\$${pricetotal.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
        submitButton(userId),   // You can add your submit button here
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SizedBox(
          height: 120, // Adjust the height as needed
          child: Image.network(
            'https://cdn.freebiesupply.com/logos/large/2x/nintendo-2-logo-png-transparent.png',
            fit: BoxFit
                .fitHeight, // Ensure the image fits within the specified height
          ),
        ),
      ),
      body: mainBody,
    );
  }

Future<void> getCart() async {
  try {
    var url = Uri.http(AppConfig.server, "Cart"); // Modify the URL to include the user's ID
    var resp = await http.get(url);

    if (resp.statusCode == 200) {
      List<Cart> fetchedCartItems = cartFromJson(resp.body);

      setState(() {
        _cartList = fetchedCartItems;
        pricetotal = calculateTotalPrice(fetchedCartItems);
        mainBody = showCart(_cartList);
      });
    } else {
      // Handle the HTTP request error (e.g., cart not found)
      // You can display an error message to the user
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    // You can display an error message to the user
  }
}


  Future<void> removercart(Cart cart) async {
    var url = Uri.http(AppConfig.server, "Cart/${cart.id}");
    var resp = await http.delete(url);
    print(resp.body);
    await getCart();
  }

  Future<void> updateCartItem(Cart cart) async {
    try {
      var url = Uri.http(AppConfig.server, "Cart/${cart.id}");
      var resp = await http.put(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          "title": cart.title, // Include the title if needed
          "type": cart.type,   // Include other properties if needed
          "release": cart.release,
          "price": cart.price,
          "picture": cart.picture,
          "total": cart.total,
          "id": cart.id,
        }), // Send the updated cart data as JSON
      );

      if (resp.statusCode == 200) {
        // Item updated successfully
        // You may want to handle any additional logic here
      } else {
        // Handle the HTTP request error here
        // You can display an error message to the user
      }
    } catch (e) {
      // Handle any exceptions that may occur during the request
      // You can display an error message to the user
    }
  }

Widget submitButton(int? userId) {
  return Center(
    child: SizedBox(
      width: 200.0,
      child: ElevatedButton(
        onPressed: () {
          // Pass the required data as parameters to the savereceipt function
          saveReceipt(userId);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        child: Text("Purchase"),
      ),
    ),
  );
}

Future<void> saveReceipt(int? userId) async {
  try {
    // Fetch the cart items from the server
    var cartUrl = Uri.http(AppConfig.server, "Cart");
    var cartResp = await http.get(cartUrl);

    if (cartResp.statusCode == 200) {
      List<Cart> fetchedCartItems = cartFromJson(cartResp.body);

      // Prepare the receipt data using the fetched cart items
      Map<String, dynamic> receiptData = {
        "Time": DateTime.now().toString(),
        "userId": userId,
        "game": fetchedCartItems.map((cart) {
          return {
            "title": cart.title,
            "type": cart.type,
            "release": cart.release,
            "price": cart.price,
            "total": cart.total,
          };
        }).toList(),
        "total": calculateTotalPrice(fetchedCartItems), // Calculate the total price based on fetched cart items
      };

      // Send a POST request to create and save the receipt
      var receiptUrl = Uri.http(AppConfig.server, "/Receipt");
      var resp = await http.post(
        receiptUrl,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(receiptData),
      );

      if (resp.statusCode == 200) {
        // Receipt created and saved successfully
        // You can handle the response or show a confirmation to the user
      } else {
        // Handle the HTTP request error here
        // You can display an error message to the user
      }
    }
  } catch (e) {
    // Handle any exceptions that may occur during the request
    // You can display an error message to the user
  }
}



}
