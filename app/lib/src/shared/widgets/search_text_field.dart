import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/shared/widgets/responsive_center.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

/// Search bar displayed at the top of screens like
/// pump list, sector list, etc.
class SearchTextField extends StatefulWidget {
  const SearchTextField({super.key, this.onSearch});

  /// Function to execute when the search is performed.
  final Function(String)? onSearch;

  @override
  State<SearchTextField> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final loc = context.loc;
    return ResponsiveSliverCenter(
      padding: const EdgeInsets.symmetric(
        horizontal: Sizes.p16,
        vertical: Sizes.p16,
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: loc.search,
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              _searchController.clear();
              widget.onSearch?.call('');
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          hintStyle: const TextStyle(color: Colors.grey),
        ),
        onChanged: widget.onSearch,
      ),
    );
  }
}
