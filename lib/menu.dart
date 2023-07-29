import 'package:flutter/material.dart';
import 'package:koperasi/cart.dart';
import 'package:koperasi/Alat/listatk.dart';
import 'package:koperasi/Makanan/listmakanan.dart';
import 'package:koperasi/Minuman/listminuman.dart';
import 'package:koperasi/Snack/listsnack.dart';
import 'package:koperasi/page.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
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
          icon: Icon(Icons.shopping_cart,
              color: Color.fromARGB(255, 216, 49, 49)),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CartPage()),
            );
          },
        ),
        title: Text(
          "KOTESU",
          style: TextStyle(fontSize: 20, color: Colors.black),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Hai Telkom Citizen,",
              style: TextStyle(
                fontSize: 17,
              ),
            ),
          ),
          SizedBox(height: 5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 25),
            child: Text(
              "Mau beli apa hari ini?",
              style: TextStyle(
                fontSize: 36,
                color: Color.fromARGB(255, 216, 49, 49),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 10),
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            childAspectRatio: 1.00,
            children: [
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 209, 209, 209),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Makanan",
                        style: TextStyle(
                            color: Color.fromARGB(255, 194, 38, 38),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListMakanan()),
                  );
                },
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 209, 209, 209),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Snack",
                        style: TextStyle(
                            color: Color.fromARGB(255, 194, 38, 38),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListSnack()),
                  );
                },
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 209, 209, 209),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Minuman",
                        style: TextStyle(
                            color: Color.fromARGB(255, 194, 38, 38),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ListMinuman()),
                  );
                },
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  margin: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color.fromARGB(255, 209, 209, 209),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Alat Tulis",
                        style: TextStyle(
                            color: Color.fromARGB(255, 194, 38, 38),
                            fontSize: 30,
                            fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ListAtk()),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
