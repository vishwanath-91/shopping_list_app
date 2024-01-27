import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shopping_list_app/Data/categories_Data.dart';

import 'Model/category_model.dart';

class AddNewItem extends StatefulWidget {
  const AddNewItem({super.key});

  @override
  State<AddNewItem> createState() => _AddNewItemState();
}

class _AddNewItemState extends State<AddNewItem> {
  final _formKey = GlobalKey<FormState>();
  String _enteredName = "";
  late int _quantity;
  CategoryModel? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _quantity = 1;
    _selectedCategory = categoriesDataMap[CategoriesEnumList.vegetables];
  }

/*  void _saveItems() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      Navigator.of(context).pop(GroceryItemModel(
          id: DateTime.now().toString(),
          name: _enteredName,
          quantity: _quantity,
          category: _selectedCategory!));
    }
  }*/

  void _saveItemsInFirebase() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final url = Uri.https("shoppinglistapp-dc941-default-rtdb.firebaseio.com",
          "shoppingListApp.json");
      http.post(
        url,
        headers: {
          'content-type': 'application/json',
        },
        body: jsonEncode(
          {
            'name': _enteredName,
            'quantity': _quantity,
            'category': _selectedCategory!.title
          },
        ),
      );
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text("Add a new item"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                maxLength: 25,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  labelText: "Name",
                ),
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 2 ||
                      value.trim().length >= 25) {
                    return "must be between 1 and 25 characters";
                  } else {
                    return null;
                  }
                },
                onSaved: (newValue) {
                  _enteredName = newValue!;
                },
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        labelText: "Quantity",
                      ),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null ||
                            value.isEmpty ||
                            int.tryParse(value.trim()) == null ||
                            int.parse(value.trim()) <= 0) {
                          return "must be a valid positive number";
                        } else {
                          return null;
                        }
                      },
                      initialValue: _quantity.toString(),
                      onSaved: (newValue) {
                        _quantity = int.parse(newValue!);
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: DropdownButtonFormField<CategoryModel>(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      value: _selectedCategory,
                      items: categoriesDataMap.entries.map((category) {
                        return DropdownMenuItem<CategoryModel>(
                          value: category.value,
                          child: Container(
                            color: category.value.color,
                            child: Row(
                              children: [
                                Text(category.value.title),
                                const SizedBox(width: 6),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedCategory = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _formKey.currentState!.reset();
                    },
                    child: const Text("Reset"),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      _saveItemsInFirebase();
                    },
                    child: const Text("Submit"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
