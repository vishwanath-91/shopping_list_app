import 'package:flutter/material.dart';
import 'package:shopping_list_app/Model/grocery_item_model.dart';
import 'package:shopping_list_app/add_new_item.dart';

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
    } else {
      setState(() {
        _groceryItemsScreen.add(newItems);
      });
    }
  }

  void deleteitems(GroceryItemModel groceryItemModel) {
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
            onDismissed: (direction) => deleteitems(_groceryItemsScreen[index]),
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
