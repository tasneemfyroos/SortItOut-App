import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../services/nearby_service.dart';

class ClothingDisposal extends StatefulWidget {
  @override
  _ClothingDisposalState createState() => _ClothingDisposalState();
}

class _ClothingDisposalState extends State<ClothingDisposal> {
  List<dynamic> donationSites = [];

  @override
  void initState() {
    super.initState();
    _fetchDonationSites();
  }

  Future<void> _fetchDonationSites() async {
    // Check if location permissions are granted
    final status = await Permission.locationWhenInUse.request();
    if (status.isGranted || status.isLimited) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latitude = position.latitude;
      final longitude = position.longitude;

      final sites =
          await fetchNearbySites(latitude, longitude, "clothing_donation");

      setState(() {
        donationSites = sites;
      });
    } else if (status.isDenied) {
      // Permission denied
      print('Location permission denied');
    } else {
      // Permission denied
      print('Location permission denied');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // title: Text('Clothing Disposal Sites'),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Clothing Disposal Sites',
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
        itemCount: donationSites.length,
        itemBuilder: (context, index) {
          final site = donationSites[index];
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
