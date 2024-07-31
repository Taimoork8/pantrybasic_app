// ignore_for_file: use_rethrow_when_possible

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pantry_app/models/pantry_item.dart';

class FirestoreService {
  final CollectionReference _pantryCollection =
      FirebaseFirestore.instance.collection('pantry_items');

  Stream<List<PantryItem>> getPantryItems() {
    return _pantryCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return PantryItem.fromMap(doc.id, doc.data() as Map<String, dynamic>);
      }).toList();
    });
  }

  Future<void> addPantryItem(PantryItem item) async {
    try {
      await _pantryCollection.add(item.toMap());
      debugPrint('Successfully added item: ${item.name}');
    } catch (e) {
      debugPrint('Error adding pantry item: $e');
      if (e is FirebaseException) {
        debugPrint('Firebase error code: ${e.code}');
        debugPrint('Firebase error message: ${e.message}');
      }
      throw e;
    }
  }

  Future<void> updatePantryItem(PantryItem item) async {
    try {
      await _pantryCollection.doc(item.id).update(item.toMap());
    } catch (e) {
      debugPrint('Error updating pantry item: $e');
      throw e;
    }
  }

  Future<void> deletePantryItem(String id) async {
    try {
      await _pantryCollection.doc(id).delete();
    } catch (e) {
      debugPrint('Error deleting pantry item: $e');
      throw e;
    }
  }

  Future<void> clearAllData() async {
    try {
      QuerySnapshot snapshot = await _pantryCollection.get();
      for (DocumentSnapshot doc in snapshot.docs) {
        await doc.reference.delete();
      }
    } catch (e) {
      debugPrint('Error clearing all data: $e');
      throw e;
    }
  }
}
