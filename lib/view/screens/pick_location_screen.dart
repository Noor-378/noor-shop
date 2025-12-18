import 'package:animated_button/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:noor_store/logic/controllers/pick_location_controller.dart';
import 'package:noor_store/utils/colors.dart';

class PickLocationScreen extends StatelessWidget {
  final LatLng initialLocation;
  const PickLocationScreen({super.key, required this.initialLocation});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PickLocationController>(
      init: PickLocationController(initialLocation),
      builder: (controller) {
        return Scaffold(
          appBar: AppBar(title: const Text('Pick Location'), centerTitle: true),
          body: Stack(
            children: [
              GoogleMap(
                mapType: controller.mapType,
                zoomControlsEnabled: false,
                mapToolbarEnabled: false,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 16,
                ),
                onMapCreated: controller.onMapCreated,
                onTap: controller.onMapTap,
                markers: {
                  Marker(
                    markerId: const MarkerId('selected'),
                    position: controller.selectedLocation,
                  ),
                },
              ),

              Positioned(
                top: 12,
                left: 12,
                right: 12,
                child: Column(
                  children: [
                    Material(
                      elevation: 4,
                      borderRadius: BorderRadius.circular(12),
                      child: TextField(
                        controller: controller.searchController,
                        focusNode: controller.searchFocusNode,
                        onChanged: controller.searchPlaces,
                        decoration: const InputDecoration(
                          hintText: 'Search location',
                          prefixIcon: Icon(Icons.search),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.all(14),
                        ),
                      ),
                    ),

                    if (controller.suggestions.isNotEmpty &&
                        controller.isSearching)
                      Container(
                        margin: const EdgeInsets.only(top: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: controller.suggestions.length,
                          itemBuilder: (_, i) {
                            final item = controller.suggestions[i];
                            return ListTile(
                              title: Text(item['description']),
                              onTap: () => controller.selectPlace(item),
                            );
                          },
                        ),
                      ),
                  ],
                ),
              ),

              if (!controller.isSearching)
                _IconButton(
                  top: 120,
                  icon: Icons.layers,
                  onTap: controller.toggleMapType,
                ),

              if (!controller.isSearching)
                _IconButton(
                  top: 170,
                  icon: Icons.my_location,
                  onTap: controller.moveToCurrentLocation,
                ),

              Positioned(
                bottom: 12,
                left: 12,
                right: 12,
                child: Center(
                  child: AnimatedButton(
                    height: 55,
                    width: 325,
                    color: mainColor,
                    borderRadius: 15,
                    onPressed: controller.confirmLocation,
                    child: const Text(
                      'Confirm Location',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _IconButton extends StatelessWidget {
  final double top;
  final IconData icon;
  final VoidCallback onTap;

  const _IconButton({
    required this.top,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      right: 12,
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(color: Colors.white.withValues(alpha: .8)),
          child: Icon(icon, color: Colors.grey),
        ),
      ),
    );
  }
}
