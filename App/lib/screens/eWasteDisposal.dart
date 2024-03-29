import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../main.dart';
import '../services/nearby_service.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class EwasteDisposal extends StatefulWidget {
  @override
  _EwasteDisposalState createState() => _EwasteDisposalState();
}

class _EwasteDisposalState extends State<EwasteDisposal> {
  List<dynamic> ewasteSites = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchEwasteSites();
  }

  Future<void> _fetchEwasteSites() async {
    // Check if location permissions are granted
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted) {
      setState(() {
        isLoading = true;
      });

      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latitude = position.latitude;
      final longitude = position.longitude;

      final sites =
          await fetchNearbySites(latitude, longitude, "electronic_waste");

      setState(() {
        ewasteSites = sites;
        isLoading = false;
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
      body: isLoading
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Fetching closest site to you',
                  style: TextStyle(
                    fontFamily: 'marcellus',
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 16),
                SpinKitWave(
                  color: Color(0xFF132A32),
                  size: 50.0,
                ),
              ],
            )
          : ListView.builder(
              itemCount: ewasteSites.length,
              itemBuilder: (context, index) {
                final site = ewasteSites[index];
                final name = site['name'] ?? 'No Name';
                final address = site['vicinity'] ?? 'No Address';

                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                        100), // Adjust the radius as desired
                  ),
                  color: getColor()[200],
                  child: ListTile(
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
                  ),
                );
              },
            ),
    );
  }
}
