import 'package:flutter/material.dart';
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
      body: Column(
        children: [
          Padding(
            padding:
                const EdgeInsets.only(left: 80, right: 80, bottom: 20, top: 50),
            child: Image.asset('images/Koperasi.png'),
          ),
          const Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              "Beli Barang Gaperlu Antri",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                color: Colors.red,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const Text(
            "Menyediakan segala kebutuhan untuk Mahasiswa",
            style: TextStyle(
              fontSize: 20,
              color: Colors.grey,
            ),
          ),
          Spacer(),
          GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) {
                  return const MenuPage();
                },
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 182, 31, 31),
                borderRadius: BorderRadius.circular(20),
              ),
              padding: const EdgeInsets.all(24),
              child: const Text(
                "Belanja Sekarang",
                style: TextStyle(
                    color: Color.fromARGB(255, 255, 255, 255),
                    fontSize: 30,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          Spacer(),
        ],
      ),
    );
  }
}
