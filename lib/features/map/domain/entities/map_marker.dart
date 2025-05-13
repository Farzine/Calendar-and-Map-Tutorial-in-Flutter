import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarker extends Equatable {
  final String id;
  final String title;
  final String description;
  final double latitude;
  final double longitude;
  final BitmapDescriptor? icon;
  final Color color;

  const MapMarker({
    required this.id,
    required this.title,
    required this.description,
    required this.latitude,
    required this.longitude,
    this.icon,
    this.color = Colors.red,
  });

  LatLng get position => LatLng(latitude, longitude);

  Marker toGoogleMapsMarker() {
    return Marker(
      markerId: MarkerId(id),
      position: position,
      infoWindow: InfoWindow(
        title: title,
        snippet: description,
      ),
      icon: icon ?? BitmapDescriptor.defaultMarkerWithHue(
        BitmapDescriptor.hueRed,
      ),
    );
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        latitude,
        longitude,
        icon,
        color,
      ];

  MapMarker copyWith({
    String? id,
    String? title,
    String? description,
    double? latitude,
    double? longitude,
    BitmapDescriptor? icon,
    Color? color,
  }) {
    return MapMarker(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      icon: icon ?? this.icon,
      color: color ?? this.color,
    );
  }
}