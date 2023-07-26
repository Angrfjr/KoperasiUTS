import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:koperasi/Makanan/listmakanan.dart';
import 'package:koperasi/menu.dart';
import 'package:http/http.dart' as http;

class CreateData extends StatefulWidget {
  const CreateData({super.key});

  @override
  State<CreateData> createState() => _CreateDataState();
}

class _CreateDataState extends State<CreateData> {
  final apiUrl = 'http://localhost:5000/users';

  List<dynamic> data = [];
  bool isLoading = true;

  TextEditingController namaController = TextEditingController();
  TextEditingController hargaController = TextEditingController();
  TextEditingController imageController = TextEditingController();

  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
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
      getData();
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
              MaterialPageRoute(builder: (context) => ListMakanan()),
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
            decoration: InputDecoration(
                border: OutlineInputBorder(), hintText: 'Masukkan Nama Barang'),
            controller: namaController,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan Harga Barang'),
            controller: hargaController,
          ),
          SizedBox(height: 10),
          TextField(
            decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Masukkan Link Foto Barang'),
            controller: imageController,
          ),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              addData();
            },
            child: Text(
              'Create',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
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
