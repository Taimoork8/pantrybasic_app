import 'package:flutter/material.dart';
import 'package:pantry_app/models/pantry_item.dart';
import 'package:pantry_app/services/firestore_service.dart';
import 'package:intl/intl.dart';

class ItemList extends StatelessWidget {
  const ItemList({super.key});

  @override
  Widget build(BuildContext context) {
    final firestoreService = FirestoreService();

    return StreamBuilder<List<PantryItem>>(
      stream: firestoreService.getPantryItems(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final items = snapshot.data!;

        return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(
                  'Quantity: ${item.quantity} - Expires: ${DateFormat('yyyy-MM-dd').format(item.expireDate)}'),
              trailing: IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => firestoreService.deletePantryItem(item.id),
              ),
            );
          },
        );
      },
    );
  }
}
