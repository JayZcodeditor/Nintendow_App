import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/app_config.dart';
import 'package:flutter_application_1/models/receipt.dart';
import 'package:http/http.dart' as http;

class ReceiptPage extends StatefulWidget {
  static const routeName = "/receipt";
  final int? userId;
  const ReceiptPage({Key? key, this.userId}) : super(key: key);

  @override
  _ReceiptPageState createState() => _ReceiptPageState();
}

class _ReceiptPageState extends State<ReceiptPage> {
  int? userId;
  List<Receipt> _receiptlist = [];
  Widget mainBody = Container();

  @override
  void initState() {
    super.initState();
    userId = widget.userId;
    print(userId);
    getReceipt(userId!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Receipts'),
      ),
      body: mainBody,
    );
  }

  Future<void> getReceipt(int userId) async {
    try {
      var url = Uri.http(AppConfig.server, "Receipt");
      var resp = await http.get(url);
      print(resp.body);
      if (resp.statusCode == 200) {
        setState(() {
          _receiptlist = receiptFromJson(resp.body).toList();
          mainBody = showreceipt(_receiptlist, userId);
        });
      } else {}
    } catch (e) {}
  }

  Widget showreceipt(List<Receipt> _receiptList, int userId) {
    final filteredReceipts =
        _receiptList.where((receipt) => receipt.userId == userId).toList();

    return ListView.builder(
      itemCount: filteredReceipts.length,
      itemBuilder: (context, index) {
        final receipt = filteredReceipts[index];
        final dateTime = receipt.time;
        final games = receipt.game;

        return Card(
          margin: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: Text('Date and Time: ${dateTime.toString()}'),
                subtitle: Text('Total: ${receipt.total}'),
              ),
              SizedBox(height: 10.0),
              Text('Games:'),
              Column(
                children: games?.map((game) {
                      return ListTile(
                        title: Text('Title: ${game.title}'),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Type: ${game.type}'),
                            Text('Release: ${game.release}'),
                            Text('Price: \$${game.price}'),
                            Text('Total: ${game.total}'),
                          ],
                        ),
                      );
                    }).toList() ??
                    [],
              ),
            ],
          ),
        );
      },
    );
  }
}
