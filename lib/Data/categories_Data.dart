import 'package:flutter/material.dart';
import 'package:shopping_list_app/Model/category_model.dart';

const categoriesDataMap = {
  CategoriesEnumList.vegetables: CategoryModel(
    'Vegetables',
    Color.fromARGB(255, 0, 255, 128),
  ),
  CategoriesEnumList.fruit: CategoryModel(
    'Fruit',
    Color.fromARGB(255, 145, 255, 0),
  ),
  CategoriesEnumList.meat: CategoryModel(
    'Meat',
    Color.fromARGB(255, 255, 102, 0),
  ),
  CategoriesEnumList.dairy: CategoryModel(
    'Dairy',
    Color.fromARGB(255, 0, 208, 255),
  ),
  CategoriesEnumList.carbs: CategoryModel(
    'Carbs',
    Color.fromARGB(255, 0, 60, 255),
  ),
  CategoriesEnumList.sweets: CategoryModel(
    'Sweets',
    Color.fromARGB(255, 255, 149, 0),
  ),
  CategoriesEnumList.spices: CategoryModel(
    'Spices',
    Color.fromARGB(255, 255, 187, 0),
  ),
  CategoriesEnumList.convenience: CategoryModel(
    'Convenience',
    Color.fromARGB(255, 191, 0, 255),
  ),
  CategoriesEnumList.hygiene: CategoryModel(
    'Hygiene',
    Color.fromARGB(255, 149, 0, 255),
  ),
  CategoriesEnumList.other: CategoryModel(
    'Other',
    Color.fromARGB(255, 0, 225, 255),
  ),
};
