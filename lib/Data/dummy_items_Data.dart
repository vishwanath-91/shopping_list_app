import 'package:shopping_list_app/Data/categories_Data.dart';
import 'package:shopping_list_app/Model/category_model.dart';
import 'package:shopping_list_app/Model/grocery_item_model.dart';

final groceryItems = [
  GroceryItemModel(
      id: 'a',
      name: 'Milk',
      quantity: 1,
      category: categoriesDataMap[CategoriesEnumList.dairy]!),
  GroceryItemModel(
      id: 'b',
      name: 'Bananas',
      quantity: 5,
      category: categoriesDataMap[CategoriesEnumList.fruit]!),
  GroceryItemModel(
      id: 'c',
      name: 'Beef Steak',
      quantity: 1,
      category: categoriesDataMap[CategoriesEnumList.meat]!),
];
