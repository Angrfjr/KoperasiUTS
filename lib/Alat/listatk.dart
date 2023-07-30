import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:koperasi/Alat/CreateAlat.dart';
import 'package:koperasi/menu.dart';
import 'package:http/http.dart' as http;

class ListAtk extends StatefulWidget {
  const ListAtk({super.key});

  @override
  State<ListAtk> createState() => _ListAtkState();
}

class _ListAtkState extends State<ListAtk> {
  final apiUrl = 'http://localhost:5000/atk';

  List<dynamic> data = [];
  bool isLoading = true;

  final idController = TextEditingController();
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getAtk();
  }

  Future<void> getAtk() async {
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
      getAtk();
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
      getAtk();
    } else {
      throw Exception('Failed to delete data');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return CreateAlat();
            },
          ),
        ),
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
          icon: Icon(Icons.arrow_back, color: Color.fromARGB(255, 216, 49, 49)),
          onPressed: () {
            Navigator.pop(
              context,
              MaterialPageRoute(builder: (context) => MenuPage()),
            );
          },
        ),
        title: Text(
          "KOTESU",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              child: ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Image.network(
                              data[index]['image'],
                              height: 150,
                              width: 150,
                              fit: BoxFit.contain,
                              scale: 1,
                              errorBuilder: (BuildContext context,
                                  Object exception, StackTrace? stackTrace) {
                                return Text("Failed to load image");
                              },
                            ),
                          ),
                          SizedBox(width: 10),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  data[index]['nama'],
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Color.fromARGB(255, 216, 49, 49),
                                  ),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  '\Rp.${data[index]['harga']}',
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Color.fromARGB(255, 82, 82, 82),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    trailing: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          color: Colors.green,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Update Data'),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
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
                                          labelText: 'Image',
                                        ),
                                      ),
                                    ],
                                  ),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Update'),
                                      onPressed: () {
                                        updateData(
                                            data[index]['id'].toString());
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                        SizedBox(width: 25),
                        IconButton(
                          icon: Icon(Icons.delete),
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Delete Data'),
                                  content: Text(
                                      'Are you sure you want to delete this data?'),
                                  actions: [
                                    TextButton(
                                      child: Text('Cancel'),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text('Delete'),
                                      onPressed: () {
                                        deleteData(
                                            data[index]['id'].toString());
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
    );
  }
}
