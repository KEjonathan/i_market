// lib/session/user_session.dart

import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserSession {
  // Singleton pattern
  static final UserSession _instance = UserSession._internal();

  factory UserSession() {
    return _instance;
  }

  UserSession._internal();

  static UserSession get instance => _instance;

  LatLng? _userLocation;

  LatLng? get userLocation => _userLocation;

  set userLocation(LatLng? location) {
    _userLocation = location;
  }
}
