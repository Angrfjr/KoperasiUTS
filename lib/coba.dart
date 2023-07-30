import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:koperasi/Makanan/CreateMakanan.dart';
import 'package:koperasi/menu.dart';
import 'package:http/http.dart' as http;

class MyWidget extends StatefulWidget {
  const MyWidget({super.key});

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final apiUrl = 'http://localhost:5000/makanan';

  List<dynamic> data = [];
  bool isLoading = true;

  final idController = TextEditingController();
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getMakanan();
  }

  Future<void> getMakanan() async {
    setState(() {
      isLoading = false;
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

  Future<void> updateData(String id) async {
    final response = await http.patch(
      Uri.parse('$apiUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'nama': namaController.text,
        'harga': hargaController.text,
        'image': imageController.text,
      }),
    );

    if (response.statusCode == 200) {
      getMakanan();
      idController.clear();
      namaController.clear();
      hargaController.clear();
      imageController.clear();
    } else {
      throw Exception('Failed to update data');
    }
  }

  Future<void> deleteData(String id) async {
    final response = await http.delete(Uri.parse('$apiUrl/$id'));

    if (response.statusCode == 200) {
      getMakanan();
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: Color.fromARGB(255, 216, 49, 49),
          child: Icon(Icons.add),
        ),
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          centerTitle: true,
          leading: IconButton(
            icon:
                Icon(Icons.arrow_back, color: Color.fromARGB(255, 216, 49, 49)),
            onPressed: () {},
          ),
          title: Text(
            "KOTESU",
            style: TextStyle(fontSize: 20, color: Colors.black),
          ),
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Container(
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              leading: Image.network(data[index]['image']),
                              title: Text(data[index]['text']),
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ));
  }
}
