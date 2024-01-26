import 'package:shopping_list_app/Data/categories.dart';
import 'package:shopping_list_app/Model/category.dart';
import 'package:shopping_list_app/Model/grocery_item.dart';

final groceryItems = [
  GroceryItemModel(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categories[CategoriesEnumList.dairy]!),
  GroceryItemModel(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categories[CategoriesEnumList.fruit]!),
  GroceryItemModel(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categories[CategoriesEnumList.meat]!),
];
