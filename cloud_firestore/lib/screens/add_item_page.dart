import 'package:cloud_firestore_tutorial/components/show_notification.dart';
import 'package:cloud_firestore_tutorial/services/add_item_service.dart';
import 'package:cloud_firestore_tutorial/services/logger_service.dart';
import 'package:flutter/material.dart';

class AddItemPage extends StatefulWidget {
  AddItemPage({Key key}) : super(key: key);

  @override
  _AddItemPageState createState() => _AddItemPageState();
}

class _AddItemPageState extends State<AddItemPage> {
  final pdname = TextEditingController();
  final pddes = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add item"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        child: Center(
            child: Column(
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: <Widget>[
                  TextField(
                    decoration: InputDecoration(labelText: "Product Name"),
                    controller: pdname,
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  TextField(
                    decoration:
                        InputDecoration(labelText: "Product Description"),
                    controller: pddes,
                  ),
                  Padding(padding: const EdgeInsets.all(10)),
                  RaisedButton(
                    child: Text("Add items"),
                    onPressed: () {
                      if (pdname.text == "" || pddes.text == "") {
                        showMessageBox(context, "Error",
                            "Please enter name and description before adding it to firebase",
                            actions: [dismissButton(context)]);
                        logger.e("pdname or pddes can't be null");
                      } else {
                        addItem(
                            context,
                            {"name": pdname.text, "description": pddes.text},
                            pdname.text);
                        pdname.text = "";
                        pddes.text = "";
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        )),
      ),
    );
  }
}
