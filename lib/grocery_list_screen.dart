import 'package:flutter/material.dart';
import 'package:shopping_list_app/Model/grocery_item.dart';
import 'package:shopping_list_app/add_new_item.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<GroceryItemModel> _groceryItemModel = [];

  void _addItem() {
    Navigator.of(context).push<GroceryItemModel>(MaterialPageRoute(
      builder: (context) => const AddNewItem(),
    ));
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No items added yet"),
    );

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Your Grocery's"),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
