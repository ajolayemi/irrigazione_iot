import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_providers.dart';
import 'package:irrigazione_iot/src/utils/weenat_utils.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/features/weenat/providers/weenat_plot_carousel_providers.dart';
import 'package:irrigazione_iot/src/features/weenat/widgets/weenat_plot_carousel_item.dart';

class WeenatPlotsCard extends ConsumerStatefulWidget {
  const WeenatPlotsCard({
    super.key,
    required this.plots,
    this.mapController,
  });

  final GoogleMapController? mapController;
  final List<WeenatPlot> plots;

  @override
  ConsumerState<WeenatPlotsCard> createState() => _WeenatPlotsCardState();
}

class _WeenatPlotsCardState extends ConsumerState<WeenatPlotsCard> {
  int? indexScrolledTo = 0;
  int? selectedIndex = 0;
  late ItemScrollController _scrollController;
  final _itemPositionsListener = ItemPositionsListener.create();

  List<WeenatPlot> get plots => widget.plots;

  @override
  void initState() {
    _scrollController = ref.read(itemScrollControllerProvider);
    _itemPositionsListener.itemPositions.addListener(() {
      final positions = _itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final index = positions.first.index;
        final currentIndex = ref.read(selectedPlotIndexProvider);
        if (index == currentIndex) {
          final itemAtIndex = plots[index];
          WeenatUtils.moveCamera(
            item: itemAtIndex,
            mapController: widget.mapController,
          );
        }
      }
    });
    super.initState();
  }

  Future<void> _onSwipe({
    int? currentIndex,
    required List<WeenatPlot> plots,
    bool isSwipeRight = false,
  }) async {
    if (currentIndex == null ||
        plots.isEmpty ||
        currentIndex >= plots.length - 1) {
      return;
    }

    final nextIndex = isSwipeRight ? currentIndex - 1 : currentIndex + 1;
    WeenatUtils.scrollCarousel(
      index: nextIndex,
      scrollController: _scrollController,
      onScrollCompleted: () {
        ref.read(selectedPlotIndexProvider.notifier).setSelected(nextIndex);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(
        minHeight: 100,
        maxHeight: 200,
      ),
      child: ScrollablePositionedList.builder(
        itemCount: plots.length,
        scrollDirection: Axis.horizontal,
        itemScrollController: _scrollController,
        itemPositionsListener: _itemPositionsListener,
        physics: const NeverScrollableScrollPhysics(),
        initialScrollIndex: 0,
        itemBuilder: (context, index) {
          final plot = plots[index];
          return Consumer(
            builder: (context, ref, child) {
              final selectedPlotId = ref.watch(selectedPlotProvider.select(
                (value) => value?.id,
              ));
              return WeenatPlotCarouselItem(
                plot: plot,
                isFirstItem: plot == plots.first,
                isLastItem: plot == plots.last,
                isSelected: selectedIndex == index || selectedPlotId == plot.id,
                onSwipeRight: () async {
                  await _onSwipe(
                    currentIndex: index,
                    plots: plots,
                    isSwipeRight: true,
                  );
                },
                onSwipeLeft: () async {
                  await _onSwipe(
                    currentIndex: index,
                    plots: plots,
                    isSwipeRight: false,
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
