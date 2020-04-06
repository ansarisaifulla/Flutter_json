import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'data.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo of json',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHome(),
    );
  }
}

class MyHome extends StatefulWidget {
  @override
  _MyHomeState createState() => _MyHomeState();
}

class _MyHomeState extends State<MyHome> {
  Future<List<Data>> get_all_data() async {
    var users = await http
        .get("http://www.json-generator.com/api/json/get/cfBurrlzTm?indent=2");
    var data_decoded = json.decode(users.body);
    List<Data> datalist = [];
    for (var u in data_decoded) {
      Data d = Data(u["userId"], u["firstName"], u["lastName"],
          u["emailAddress"], u["phineNumber"]);
      datalist.add(d);
    }
    return datalist;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Json Data"),
        backgroundColor: Colors.black87,
        elevation: 0.0,
        leading: Icon(Icons.arrow_back_ios),
      ),
      body: Container(
        child: FutureBuilder(
          future: get_all_data(),
          builder: (BuildContext context, AsyncSnapshot Snapshot) {
            if (Snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text("loading"),
                ),
              );
            } else {
              return ListView.builder(
                  itemCount: Snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(left:8.0,right:8.0,bottom:8.0),
                      child: Container(
                          child: ListTile(
                            title: Text(Snapshot.data[index].firstName),
                            subtitle: Text(Snapshot.data[index].emailAddress),
                            onTap: () {},
                          ),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.white,
                              border: Border.all(
                                  width: 1.0, color: Colors.grey[200]),
                              boxShadow: [
                                BoxShadow(
                                    blurRadius: 0.0,
                                    color: Colors.grey[300],
                                    offset: Offset(
                                      0,
                                      3.0,
                                    ))
                              ])),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
