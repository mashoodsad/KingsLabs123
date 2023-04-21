import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductPage extends StatefulWidget {
  final Map<String, dynamic> product;

  ProductPage({required this.product});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final _formKey = GlobalKey<FormState>();
  late String _title;
  late int _price;
  late String _thumbnail;
  late String _description;

  @override
  void initState() {
    super.initState();
    _title = widget.product['title'];
    _price = widget.product['price'];
    _thumbnail = widget.product['thumbnail'];
    _description = widget.product['description'];
  }

  void _updateProduct() async {
    final response = await http.put(
      Uri.parse('https://dummyjson.com/'),
      body: json.encode({
        'title': _title,
        'price': _price,
        'thumbnail': _thumbnail,
        'description': _description,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context, true); // go back to Home page
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update product')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Product'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                initialValue: _title,
                decoration: InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Title is required';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                initialValue: _price.toString(),
                decoration: InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Price is required';
                  }
                  return null;
                },
                onSaved: (value) => _price = int.parse(value!),
              ),
              SizedBox(height: 12.0),
              TextFormField(
                initialValue: _thumbnail,
                decoration: InputDecoration(labelText: 'Thumbnail'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Thumbnail is required';
                  }
                  return null;
                },
                onSaved: (value) => _thumbnail = value!,
              ),
              SizedBox(height: 12.0),
              TextFormField(
                initialValue: _description,
                decoration: InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Description is required';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              SizedBox(height: 24.0),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState!.save();
                      _updateProduct();
                    }
                  },
                  child: Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
