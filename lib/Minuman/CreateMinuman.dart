import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:koperasi/Minuman/listminuman.dart';
import 'package:koperasi/menu.dart';
import 'package:http/http.dart' as http;

class CreateMinuman extends StatefulWidget {
  const CreateMinuman({super.key});

  @override
  State<CreateMinuman> createState() => _CreateMinumanState();
}

class _CreateMinumanState extends State<CreateMinuman> {
  final apiUrl = 'http://localhost:5000/minuman';

  List<dynamic> data = [];
  bool isLoading = true;

  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final imageController = TextEditingController();

  void initState() {
    super.initState();
    getMinuman();
  }

  Future<void> getMinuman() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        setState(() {
          data = json.decode(response.body);
          isLoading = false;
        });
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (error) {
      throw Exception('Failed to connect to the server');
    }
  }

  Future<void> addData() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama': namaController.text,
        'image': imageController.text,
        'harga': hargaController.text,
      }),
    );

    if (response.statusCode == 201) {
      getMinuman();
      namaController.clear();
      imageController.clear();
      hargaController.clear();
    } else {
      throw Exception('Failed to add data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 216, 49, 49)),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => ListMinuman()),
            );
          },
        ),
        title: Text(
          "KOTESU",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          TextField(
            controller: namaController,
            decoration: InputDecoration(
              labelText: 'Nama',
            ),
          ),
          TextField(
            controller: hargaController,
            decoration: InputDecoration(
              labelText: 'Harga',
            ),
          ),
          TextField(
            controller: imageController,
            decoration: InputDecoration(
              labelText: 'Link Image',
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              addData();
              Navigator.of(context).pop();
            },
            child: Text(
              'Create',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
            ),
          ),
        ]),
      ),
    );
  }
}
