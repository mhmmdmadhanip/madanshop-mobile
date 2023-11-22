import 'package:flutter/material.dart';
import 'package:madanshop/screens/inventorylist_form.dart';
import 'package:madanshop/widgets/inventory_card.dart';
import 'package:madanshop/widgets/left_drawer.dart';

class MyHomePage extends StatelessWidget {
    MyHomePage({Key? key}) : super(key: key);

    final List<InventoryItem> items = [
      InventoryItem("Lihat Item", Icons.checklist, Colors.red.shade400),
      InventoryItem("Tambah Item", Icons.add_shopping_cart, Colors.green.shade400),
      InventoryItem("Logout", Icons.logout, Colors.blue.shade400),
    ];

    @override
    Widget build(BuildContext context) {
        return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Madanshop',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.cyan.shade300,
        ),
        drawer: const LeftDrawer(),
        body: SingleChildScrollView(
          // Widget wrapper yang dapat discroll
          child: Padding(
            padding: const EdgeInsets.all(10.0), // Set padding dari halaman
            child: Column(
              // Widget untuk menampilkan children secara vertikal
              children: <Widget>[
                const Padding(
                  padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                  // Widget Text untuk menampilkan tulisan dengan alignment center dan style yang sesuai
                  child: Text(
                    'Madanshop', // Text yang menandakan toko
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Grid layout
                GridView.count(
                  // Container pada card kita.
                  primary: true,
                  padding: const EdgeInsets.all(20),
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  crossAxisCount: 3,
                  shrinkWrap: true,
                  children: items.map((InventoryItem item) {
                    // Iterasi untuk setiap item
                    return InventoryCard(item);
                  }).toList(),
                ),
              ],
            ),
          ),
        ),
      );
    }
}