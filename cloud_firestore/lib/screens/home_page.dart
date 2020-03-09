import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_tutorial/screens/add_item_page.dart';
import 'package:cloud_firestore_tutorial/screens/item_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("T Store"),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection("catalog").snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Column(
                  children: <Widget>[
                    CircularProgressIndicator(),
                    Text("Loading . . . "),
                  ],
                ),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data.documents.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ItemPage(
                                          pdname: snapshot
                                              .data.documents[index].documentID,
                                          pddescription: snapshot
                                              .data
                                              .documents[index]
                                              .data["description"],
                                        )));
                          },
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                    snapshot.data.documents[index].documentID),
                                subtitle: Text(snapshot
                                    .data.documents[index].data["description"]),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                child: Image.asset("assets/images/logo.png"),
                decoration: BoxDecoration(
                  color: Colors.blue,
                ),
              ),
              ListTile(
                title: Row(
                  children: <Widget>[
                    Icon(Icons.add),
                    Text('Add item'),
                  ],
                ),
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AddItemPage()));
                },
              ),
            ],
          ),
        ));
  }
}
