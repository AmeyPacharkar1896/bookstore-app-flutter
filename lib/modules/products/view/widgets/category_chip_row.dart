import 'package:bookstore_app/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class CategoryChipsRow extends StatelessWidget {
  final List<String> categories;
  final String? selectedCategory;
  final Function(String) onCategorySelected;

  const CategoryChipsRow({
    super.key,
    required this.categories,
    required this.selectedCategory,
    required this.onCategorySelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final category = categories[index];
          final isSelected = category == selectedCategory;
          return ChoiceChip(
            label: Text(category),
            selected: isSelected,
            selectedColor: AppTheme.deepTeal,
            backgroundColor: AppTheme.lightMistGrey,
            labelStyle: TextStyle(
              color: isSelected ? Colors.white : AppTheme.inkBlack,
              fontWeight: FontWeight.w600,
            ),
            onSelected: (_) => onCategorySelected(category),
          );
        },
      ),
    );
  }
}
