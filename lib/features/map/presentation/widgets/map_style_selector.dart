import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapStyleSelector extends StatelessWidget {
  final MapType currentMapType;
  final Function(MapType) onMapTypeChanged;

  const MapStyleSelector({
    super.key,
    required this.currentMapType,
    required this.onMapTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildMapTypeButton(
            context,
            'Normal',
            Icons.map,
            MapType.normal,
          ),
          _buildMapTypeButton(
            context,
            'Satellite',
            Icons.satellite,
            MapType.satellite,
          ),
          _buildMapTypeButton(
            context,
            'Terrain',
            Icons.terrain,
            MapType.terrain,
          ),
          _buildMapTypeButton(
            context,
            'Hybrid',
            Icons.layers,
            MapType.hybrid,
          ),
        ],
      ),
    );
  }

  Widget _buildMapTypeButton(
    BuildContext context,
    String label,
    IconData icon,
    MapType mapType,
  ) {
    final isSelected = currentMapType == mapType;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: FilledButton.tonal(
        onPressed: () => onMapTypeChanged(mapType),
        style: FilledButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primaryContainer
              : Theme.of(context).colorScheme.surfaceVariant,
          foregroundColor: isSelected
              ? Theme.of(context).colorScheme.onPrimaryContainer
              : Theme.of(context).colorScheme.onSurfaceVariant,
        ),
        child: Row(
          children: [
            Icon(icon, size: 18),
            const SizedBox(width: 4),
            Text(label),
          ],
        ),
      ),
    );
  }
}