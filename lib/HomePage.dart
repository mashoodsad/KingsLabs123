import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'EditPage.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> _dataList = [];

  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final response = await http.get(Uri.parse('https://dummyjson.com/'));

    if (response.statusCode == 200) {
      setState(() {
        _dataList = json.decode(response.body);
      });
    }
  }

  void _editProduct(int index) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context)=> ProductPage(product: {},)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product List:',
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12.0),
            Expanded(
              child: ListView.builder(
                itemCount: _dataList.length,
                itemBuilder: (BuildContext context, int index) {
                  final data = _dataList[index];
                  return ListTile(
                    title: Text(data['name']),
                    subtitle: Text(data['description']),
                    trailing: IconButton(
                      icon: Icon(Icons.edit,color: Colors.blue,),
                      onPressed: () => _editProduct(index),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
