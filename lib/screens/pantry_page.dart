import 'package:flutter/material.dart';
import 'package:pantry_app/widgets/item_list.dart';
import 'package:pantry_app/widgets/add_item_form.dart';

class PantryPage extends StatelessWidget {
  const PantryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          'Pantry App',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            AddItemForm(),
            Expanded(child: ItemList()),
          ],
        ),
      ),
    );
  }
}
