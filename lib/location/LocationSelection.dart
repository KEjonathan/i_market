import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:i_market/services/location_service.dart';
import 'package:i_market/sessions/userSession.dart';
import 'package:location/location.dart';


class LocationSelectionScreen extends StatefulWidget {
  @override
  _LocationSelectionScreenState createState() => _LocationSelectionScreenState();
}

class _LocationSelectionScreenState extends State<LocationSelectionScreen> {
  GoogleMapController? mapController;
  LatLng? selectedLocation;

  Future<LocationData?> _getUserLocation() async {
    LocationService locationService = LocationService();
    return await locationService.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Your Location'),
      ),
      body: FutureBuilder<LocationData?>(
        future: _getUserLocation(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || !snapshot.hasData) {
            return Center(child: Text('Could not get location data'));
          }

          final locationData = snapshot.data!;
          final initialLocation = LatLng(locationData.latitude!, locationData.longitude!);

          return Stack(
            children: [
              GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: initialLocation,
                  zoom: 14,
                ),
                onMapCreated: (controller) {
                  mapController = controller;
                },
                onTap: (location) {
                  setState(() {
                    selectedLocation = location;
                  });
                },
                markers: selectedLocation != null
                    ? {
                        Marker(
                          markerId: MarkerId('selectedLocation'),
                          position: selectedLocation!,
                        ),
                      }
                    : {},
              ),
              if (selectedLocation != null)
                Positioned(
                  bottom: 16,
                  left: 16,
                  right: 16,
                  child: ElevatedButton(
                    onPressed: () {
                      UserSession.instance.userLocation = selectedLocation;
                      Navigator.of(context).pop();
                    },
                    child: Text('Save Location'),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
