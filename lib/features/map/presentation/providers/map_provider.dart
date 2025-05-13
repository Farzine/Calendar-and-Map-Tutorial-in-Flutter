import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../domain/entities/map_marker.dart';

part 'map_provider.g.dart';

class MapState {
  final bool isLoading;
  final Set<Marker> markers;
  final String? errorMessage;
  final MapType currentMapType;
  final CameraPosition cameraPosition;
  final List<MapMarker> markerEntities;

  MapState({
    this.isLoading = false,
    this.markers = const {},
    this.errorMessage,
    this.currentMapType = MapType.normal,
    this.cameraPosition = const CameraPosition(
      target: LatLng(37.7749, -122.4194),
      zoom: 12,
    ),
    this.markerEntities = const [],
  });

  MapState copyWith({
    bool? isLoading,
    Set<Marker>? markers,
    String? errorMessage,
    MapType? currentMapType,
    CameraPosition? cameraPosition,
    List<MapMarker>? markerEntities,
  }) {
    return MapState(
      isLoading: isLoading ?? this.isLoading,
      markers: markers ?? this.markers,
      errorMessage: errorMessage,
      currentMapType: currentMapType ?? this.currentMapType,
      cameraPosition: cameraPosition ?? this.cameraPosition,
      markerEntities: markerEntities ?? this.markerEntities,
    );
  }
}

@riverpod
class MapNotifier extends _$MapNotifier {
  @override
  MapState build() {
    return MapState();
  }

  Future<void> fetchMarkers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      // Simulating API call
      await Future.delayed(const Duration(seconds: 1));
      
      // Mock marker data
      final markerEntities = [
        const MapMarker(
          id: '1',
          title: 'Office',
          description: 'Main office location',
          latitude: 37.7749,
          longitude: -122.4194,
        ),
        const MapMarker(
          id: '2',
          title: 'Coffee Shop',
          description: 'Great place for meetings',
          latitude: 37.7850,
          longitude: -122.4100,
        ),
        const MapMarker(
          id: '3',
          title: 'Client Site',
          description: 'Visit scheduled for next week',
          latitude: 37.7700,
          longitude: -122.4320,
        ),
      ];
      
      final markers = markerEntities
          .map((marker) => marker.toGoogleMapsMarker())
          .toSet();
      
      state = state.copyWith(
        isLoading: false,
        markers: markers,
        markerEntities: markerEntities,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: 'Failed to fetch markers: ${e.toString()}',
      );
    }
  }

  void changeMapType(MapType mapType) {
    state = state.copyWith(currentMapType: mapType);
  }

  void updateCameraPosition(CameraPosition cameraPosition) {
    state = state.copyWith(cameraPosition: cameraPosition);
  }

  void addMarker(MapMarker marker) {
    final newMarkerEntities = [...state.markerEntities, marker];
    final newMarkers = newMarkerEntities
        .map((marker) => marker.toGoogleMapsMarker())
        .toSet();
    
    state = state.copyWith(
      markerEntities: newMarkerEntities,
      markers: newMarkers,
    );
  }
}