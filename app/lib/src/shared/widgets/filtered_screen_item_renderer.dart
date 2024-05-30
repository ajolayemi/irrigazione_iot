import 'package:flutter/widgets.dart';
import 'package:irrigazione_iot/src/shared/widgets/empty_search_result.dart';

/// On screens where search feature is available, multiple conditions
/// are checked to determine what to display on the screen.
/// This widget abstracts off the decision of what to display based on
/// the search state.
class FilteredScreenItemRenderer<T> extends StatelessWidget {
  const FilteredScreenItemRenderer({
    super.key,
    required this.baseItems,
    required this.filteredItems,
    required this.noBaseItemsWidget,
    required this.mainWidget,
  });

  /// A list of base items
  /// This is used to check if there were original items before the search
  final List<T>? baseItems;

  /// A list of items that are filtered based on the search query
  final List<T>? filteredItems;

  /// Widget to display when there were no base items
  /// before the search
  final Widget noBaseItemsWidget;

  /// The main widget to display based on the search state
  final Widget mainWidget;

  bool get _hasBaseItems => baseItems != null && baseItems!.isNotEmpty;

  bool get _filteredItemsNotEmpty => filteredItems?.isEmpty ?? true;

  @override
  Widget build(BuildContext context) {
    // If there are no base items, display the noBaseItemsWidget
    if (!_hasBaseItems) {
      return noBaseItemsWidget;
    }

    // If there are base items and the filtered items are empty,
    // display the no search results widget
    if (_hasBaseItems && _filteredItemsNotEmpty) {
      return const EmptySearchResult();
    }

    // If there are base items and the filtered items are not empty,
    // display the main widget
    return mainWidget;
  }
}
