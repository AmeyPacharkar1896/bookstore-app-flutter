import 'package:flutter/material.dart';

abstract class SearchFilterController {
  TextEditingController get searchController;

  void onSearchChanged(String query);

  void onClearSearch();

  Future<void> onFilterSortPressed(BuildContext context, VoidCallback onUpdate);

  String get title;
}
