import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:koperasi/Snack/CreateSnack.dart';
import 'package:koperasi/cart.dart';
import 'package:koperasi/menu.dart';
import 'package:http/http.dart' as http;

class ListSnack extends StatefulWidget {
  const ListSnack({super.key});

  @override
  State<ListSnack> createState() => _ListSnackState();
}

class _ListSnackState extends State<ListSnack> {
  final apiUrl = 'http://localhost:5000/snack';

  List<dynamic> data = [];
  bool isLoading = true;

  final idController = TextEditingController();
  final namaController = TextEditingController();
  final hargaController = TextEditingController();
  final imageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getSnack();
  }

  Future<void> getSnack() async {
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
      getSnack();
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
      getSnack();
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
              return CreateSnack();
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
          : ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Padding(
                    padding: EdgeInsets.symmetric(vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text(data[index]['nama']),
                                  content: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Image.network(
                                        data[index]['image'],
                                        height: 150,
                                        width: 150,
                                        fit: BoxFit.contain,
                                        scale: 1,
                                      ),
                                      SizedBox(height: 10),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CartPage()),
                                          );
                                        },
                                        child: Text("Add to Cart"),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                          child: Text(
                            data[index]['nama'],
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            primary: Color.fromARGB(255, 216, 49, 49),
                          ),
                        ),
                        SizedBox(
                            height:
                                5), // Optional: Add some spacing between the button and subtitle
                        Text(
                          '\Rp.${data[index]['harga']}',
                          style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 82, 82, 82)),
                        ),
                      ],
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
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
                                      updateData(data[index]['id'].toString());
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
                                      deleteData(data[index]['id'].toString());
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
    );
  }
}
