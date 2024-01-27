import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/Data/categories_Data.dart';
import 'package:shopping_list_app/Model/grocery_item_model.dart';

import 'add_new_item.dart';

class GroceryListScreen extends StatefulWidget {
  const GroceryListScreen({super.key});

  @override
  State<GroceryListScreen> createState() => _GroceryListScreenState();
}

class _GroceryListScreenState extends State<GroceryListScreen> {
  final List<GroceryItemModel> _groceryItemsScreen = [];

  Future<void> _addItem() async {
    final newItems = await Navigator.push<GroceryItemModel>(
      context,
      MaterialPageRoute(
        builder: (context) => const AddNewItem(),
      ),
    );
    if (newItems == null) {
      return;
    }

    setState(() {
      _groceryItemsScreen.add(newItems);
    });

    final url = Uri.https(
      "shoppinglistapp-dc941-default-rtdb.firebaseio.com",
      "shoppingListApp.json",
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final Map<String, dynamic> listData = jsonDecode(response.body);

        for (final item in listData.entries) {
          final category = categoriesDataMap.entries
              .firstWhere(
                (element) => element.value.title == item.value['category'],
              )
              .value;
          setState(() {
            _groceryItemsScreen.add(GroceryItemModel(
              id: item.key,
              name: item.value['name'],
              quantity: item.value['quantity'],
              category: category,
            ));
          });
        }
      } else {
        // Handle non-200 status code
        print("Error: ${response.statusCode}");
        print("Body: ${response.body}");
      }
    } catch (error) {
      // Handle general error
      print("Error: $error");
    }
  }

  void _deleteItems(GroceryItemModel groceryItemModel) {
    _groceryItemsScreen.remove(groceryItemModel);
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const Center(
      child: Text("No items added yet"),
    );

    if (_groceryItemsScreen.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryItemsScreen.length,
        itemBuilder: (context, index) => Card(
          color: _groceryItemsScreen[index].category.color,
          child: Dismissible(
            key: Key(_groceryItemsScreen[index].id),
            onDismissed: (direction) =>
                _deleteItems(_groceryItemsScreen[index]),
            child: ListTile(
              title: Text(
                _groceryItemsScreen[index].name,
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
              trailing: Text(
                _groceryItemsScreen[index].quantity.toString(),
                style: const TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      );
    }

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
