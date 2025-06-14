import 'package:flutter/material.dart';
import 'package:bookstore_app/core/theme/app_theme.dart';

class FilterSortSheet extends StatefulWidget {
  final String? initialSortBy;
  final bool initialAscending;
  final String? initialType;

  const FilterSortSheet({
    super.key,
    this.initialSortBy,
    this.initialAscending = true,
    this.initialType,
  });

  @override
  State<FilterSortSheet> createState() => _FilterSortSheetState();
}

class _FilterSortSheetState extends State<FilterSortSheet> {
  String? _selectedSort;
  bool _ascending = true;
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedSort = widget.initialSortBy;
    _ascending = widget.initialAscending;
    _selectedType = widget.initialType;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Sort By", style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children:
                ['price', 'average_rating', 'title'].map((option) {
                  final isSelected = _selectedSort == option;
                  return ChoiceChip(
                    label: Text(option.toUpperCase()),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedSort = option),
                    selectedColor: AppTheme.deepTeal,
                    backgroundColor: AppTheme.lightMistGrey,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.inkBlack,
                    ),
                  );
                }).toList(),
          ),
          SwitchListTile(
            title: const Text("Ascending"),
            value: _ascending,
            onChanged: (val) => setState(() => _ascending = val),
          ),
          const Divider(),
          Text("Filter by Type", style: theme.textTheme.titleMedium),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            children:
                ['digital', 'physical'].map((type) {
                  final isSelected = _selectedType == type;
                  return ChoiceChip(
                    label: Text(type.capitalize()),
                    selected: isSelected,
                    onSelected: (_) => setState(() => _selectedType = type),
                    selectedColor: AppTheme.deepTeal,
                    backgroundColor: AppTheme.lightMistGrey,
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : AppTheme.inkBlack,
                    ),
                  );
                }).toList(),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'sortBy': null,
                      'ascending': true,
                      'type': null,
                    });
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppTheme.deepTeal,
                  ),
                  child: const Text("Clear All"),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context, {
                      'sortBy': _selectedSort,
                      'ascending': _ascending,
                      'type': _selectedType,
                    });
                  },
                  child: const Text("Apply"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

extension on String {
  String capitalize() =>
      isNotEmpty ? this[0].toUpperCase() + substring(1) : this;
}
