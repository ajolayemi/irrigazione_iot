import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:irrigazione_iot/gen/assets.gen.dart';
import 'package:irrigazione_iot/src/features/weenat/models/weenat_plot.dart';
import 'package:irrigazione_iot/src/utils/bitmap_descriptor_helper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class WeenatUtils {
  const WeenatUtils._();

  static Future<BitmapDescriptor> getPlotSelectedIcon() async {
    return BitmapDescriptorHelper.getBitmapDescriptorFromSvgAsset(
      Assets.images.weenat.plotSelected.path,
      const Size(32, 32),
    );
  }

  static Future<BitmapDescriptor> getPlotUnselectedIcon() async {
    return BitmapDescriptorHelper.getBitmapDescriptorFromSvgAsset(
      Assets.images.weenat.plotUnselected.path,
      const Size(28, 28),
    );
  }

  static Future<void> moveCamera({
    required WeenatPlot item,
    GoogleMapController? mapController,
  }) async {
    await mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(
          item.lat ?? 0.0,
          item.lng ?? 0.0,
        ),
        15.0,
      ),
    );
    
  }

  static Future<void> scrollCarousel({
    required int index,
    required ItemScrollController scrollController,
    VoidCallback? onScrollCompleted,
  }) async {
    if (scrollController.isAttached) {
      await scrollController
          .scrollTo(
            index: index,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          )
          .then((_) => onScrollCompleted?.call());
    }
  }
}
