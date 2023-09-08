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
  List<Map<String, dynamic>> _receiptlist = [];
  Widget mainBody = Container();

@override
  void initState() {
    super.initState();
    userId = widget.userId;
    print(userId); // Set _userId from widget property
      // Now you can use _userId in other methods or widgets as needed.
 
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
        _receiptlist = receiptFromJson(resp.body)
            // .where((receipt) => receipt.userId = userId)
            .toList(); // Filter receipts by userId
        mainBody = showreceipt(_receiptlist);
      });
    } else {
      // Handle HTTP request errors here
      // You can display an error message to the user
    }
  } catch (e) {
    // Handle exceptions here
    // You can display an error message to the user
  }
}


Widget showreceipt(List<Map<String, dynamic>> receiptList) {
// Store the userId in the state
  return ListView.builder(
    itemCount: receiptList.length,
    itemBuilder: (context, index) {
      final receipt = receiptList[index];
      final dateTime = DateTime.parse(receipt['Time'] as String);

      return Card(
        margin: EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text('Date and Time: ${dateTime.toString()}'),
              subtitle: Text('Total: \$${receipt['total']}'),
            ),
            SizedBox(height: 10.0),
            Text('Games:'),
            Column(
              children: (receipt['game'] as List<Map<String, dynamic>>)
                  .map(
                    (game) => ListTile(
                      title: Text('Title: ${receipt['title']}'),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Type: ${receipt['type']}'),
                          Text('Release: ${receipt['release']}'),
                          Text('Price: \$${receipt['price']}'),
                          Text('Total: ${receipt['total']}'),
                        ],
                      ),
                    ),
                  )
                  .toList(),
            ),
          ],
        ),
      );
    },
  );
}

}
