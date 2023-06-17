import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/nearby_service.dart';

class EwasteDisposal extends StatefulWidget {
  @override
  _EwasteDisposalState createState() => _EwasteDisposalState();
}

class _EwasteDisposalState extends State<EwasteDisposal> {
  List<dynamic> ewasteSites = [];

  @override
  void initState() {
    super.initState();
    _fetchEwasteSites();
  }

  Future<void> _fetchEwasteSites() async {
    // Check if location permissions are granted
    final status = await Permission.location.request();
    if (status.isGranted) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latitude = position.latitude;
      final longitude = position.longitude;

      final sites =
          await fetchNearbySites(latitude, longitude, "electronic_waste");

      setState(() {
        ewasteSites = sites;
      });
    } else {
      // Permission denied
      print('Location permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('E-Waste Disposal Sites'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('E-Waste Disposal Sites',
                style: TextStyle(
                  fontFamily: "marcellus",
                  fontSize: 18,
                )),
            SizedBox(width: 8),
            Image(image: AssetImage('images/logo.png'), height: 50),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: ewasteSites.length,
        itemBuilder: (context, index) {
          final site = ewasteSites[index];
          final name = site['name'] ?? 'No Name';
          final address = site['vicinity'] ?? 'No Address';

          return ListTile(
            title: Text(name,
                style: TextStyle(
                  fontFamily: "marcellus",
                  fontSize: 16,
                )),
            subtitle: Text(address,
                style: TextStyle(
                  fontFamily: "marcellus",
                  fontSize: 12,
                )),
          );
        },
      ),
    );
  }
}
