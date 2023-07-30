import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:koperasi/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'images/Koperasi.png',
              width: 500,
              height: 500,
            ),
            SizedBox(height: 10),
            Center(
              child: Text(
                'Membantu Menyediakan Apapun',
                style: TextStyle(
                    fontSize: 27,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Center(
              child: Text(
                'Yang Anda Cari',
                style: TextStyle(
                    fontSize: 27,
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 25),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MenuPage(),
                  ),
                );
              },
              child: Text(
                'Mulai Belanja',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 255, 255, 255)),
              ),
              style: ElevatedButton.styleFrom(
                minimumSize: Size(200, 60),
                primary: Color.fromARGB(255, 194, 60, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
