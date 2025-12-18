import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PickLocationController extends GetxController {
  late LatLng selectedLocation;
  MapType mapType = MapType.normal;
  GoogleMapController? mapController;

  final TextEditingController searchController = TextEditingController();
  final FocusNode searchFocusNode = FocusNode();
  bool isSearching = false;
  List<Map<String, dynamic>> suggestions = [];

  PickLocationController(LatLng initialLocation) {
    selectedLocation = initialLocation;
  }

  @override
  void onInit() {
    searchFocusNode.addListener(() {
      isSearching = searchFocusNode.hasFocus;
      update();
    });
    super.onInit();
  }

  void onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void onMapTap(LatLng position) {
    selectedLocation = position;
    update();
  }

  void toggleMapType() {
    mapType =
        mapType == MapType.normal ? MapType.satellite : MapType.normal;
    update();
  }

  Future<void> moveToCurrentLocation() async {
    log("moveToCurrentLocation");

    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return;

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    selectedLocation = LatLng(position.latitude, position.longitude);

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(selectedLocation, 16),
    );

    update();
  }

  Future<void> searchPlaces(String _) async {
    if (searchController.text.isEmpty) {
      suggestions = [];
      update();
      return;
    }

    await Future.delayed(const Duration(seconds: 2));

    suggestions = [
      {'description': 'عمان – بقالة النزهة', 'lat': 31.9566, 'lng': 35.9106},
      {'description': 'الزرقاء – بقالة العصر', 'lat': 31.9496, 'lng': 35.9334},
      {'description': 'عمان – بقالة', 'lat': 31.9993, 'lng': 35.8362},
    ];

    update();
  }

  void selectPlace(Map<String, dynamic> place) {
    selectedLocation = LatLng(place['lat'], place['lng']);

    mapController?.animateCamera(
      CameraUpdate.newLatLngZoom(selectedLocation, 16),
    );

    suggestions = [];
    searchController.clear();
    searchFocusNode.unfocus();

    update();
  }

  void confirmLocation() {
    Get.back(
      result:
          '${selectedLocation.latitude}, ${selectedLocation.longitude}',
    );
  }

  @override
  void onClose() {
    searchController.dispose();
    searchFocusNode.dispose();
    super.onClose();
  }
}
