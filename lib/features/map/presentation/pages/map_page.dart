import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../providers/map_provider.dart';
import '../widgets/map_style_selector.dart';

class MapPage extends ConsumerStatefulWidget {
  const MapPage({super.key});

  @override
  ConsumerState<MapPage> createState() => _MapPageState();
}

class _MapPageState extends ConsumerState<MapPage> {
  GoogleMapController? _mapController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(mapNotifierProvider.notifier).fetchMarkers();
    });
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final mapState = ref.watch(mapNotifierProvider);
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today),
            onPressed: () => context.go('/'),
          ),
        ],
      ),
      body: Column(
        children: [
          MapStyleSelector(
            currentMapType: mapState.currentMapType,
            onMapTypeChanged: (mapType) {
              ref.read(mapNotifierProvider.notifier).changeMapType(mapType);
            },
          ),
          Expanded(
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: mapState.cameraPosition,
                  mapType: mapState.currentMapType,
                  markers: mapState.markers,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  zoomControlsEnabled: false,
                  onMapCreated: (controller) {
                    _mapController = controller;
                  },
                  onCameraMove: (position) {
                    ref.read(mapNotifierProvider.notifier)
                      .updateCameraPosition(position);
                  },
                ),
                if (mapState.isLoading)
                  const Center(
                    child: CircularProgressIndicator(),
                  ),
                if (mapState.errorMessage != null)
                  Center(
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      color: Colors.red.withOpacity(0.8),
                      child: Text(
                        mapState.errorMessage!,
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: 'zoom_in',
            mini: true,
            onPressed: () {
              _mapController?.animateCamera(
                CameraUpdate.zoomIn(),
              );
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'zoom_out',
            mini: true,
            onPressed: () {
              _mapController?.animateCamera(
                CameraUpdate.zoomOut(),
              );
            },
            child: const Icon(Icons.remove),
          ),
          const SizedBox(height: 8),
          FloatingActionButton(
            heroTag: 'add_location',
            onPressed: () {
              // Open dialog to add new marker
            },
            child: const Icon(Icons.add_location),
          ),
        ],
      ),
    );
  }
}