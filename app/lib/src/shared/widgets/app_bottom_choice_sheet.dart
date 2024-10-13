import 'package:flutter/material.dart';
import 'package:irrigazione_iot/src/config/enums/button_types.dart';
import 'package:irrigazione_iot/src/config/theme/app_colors_palette.dart';
import 'package:irrigazione_iot/src/constants/app_sizes.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_cta_button.dart';
import 'package:irrigazione_iot/src/shared/widgets/app_radio.dart';
import 'package:irrigazione_iot/src/shared/widgets/no_glow_scroll.dart';
import 'package:irrigazione_iot/src/utils/extensions/build_ctx_extensions.dart';

class AppBottomChoiceSheet extends StatefulWidget {
  const AppBottomChoiceSheet({
    super.key,
    required this.title,
    required this.items,
    required this.selectedIndex,
  });

  /// The bottom sheet title
  final String title;

  /// The list of items to display in the bottom sheet
  final List<String> items;

  /// The current selected item index
  final int selectedIndex;

  @override
  State<AppBottomChoiceSheet> createState() => _AppBottomChoiceSheetState();
}

class _AppBottomChoiceSheetState extends State<AppBottomChoiceSheet> {
  /// Keeps track of the current selected item index
  int? _currentIndex;

  /// Keeps track of the current selected item
  String? _currentItem;

  List<String> get _items => widget.items;

  int get _selectedIndex => widget.selectedIndex;

  @override
  void initState() {
    super.initState();
    if (_items.isNotEmpty) {
      _currentIndex = _selectedIndex;

      if (_currentIndex != null) {
        _currentItem = _items[_currentIndex!];
      }
    }
  }

  void _onChanged(String? value) {
    if (value == null) return;
    final index = _items.indexOf(value);
    setState(() {
      _currentItem = value;
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = context.textTheme;
    final loc = context.loc;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      width: context.screenWidth,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: NoGlowScroll(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        widget.title,
                        style: textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => context.popNavigator(),
                        child: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  gapH24,
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: _items.length,
                    itemBuilder: (context, index) {
                      final item = _items[index];
                      return Column(
                        children: [
                          gapH16,
                          GestureDetector(
                            onTap: () => _onChanged(item),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    item,
                                    style: textTheme.bodyMedium,
                                  ),
                                ),
                                AppRadio(
                                  value: item,
                                  groupValue: _currentItem,
                                  onChanged: _onChanged,
                                )
                              ],
                            ),
                          ),
                          gapH12,
                          const Divider(
                            height: 0,
                            color: AppColorsPalette.grey2,
                          ),
                        ],
                      );
                    },
                  ),
                  gapH16,
                  CTAButton(
                    text: loc.genericConfirmButtonLabel,
                    buttonType: ButtonType.primary,
                    onPressed: () => context.popNavigator(_currentIndex),
                  ),
                  gapH12,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
