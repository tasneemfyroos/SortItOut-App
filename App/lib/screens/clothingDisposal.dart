import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import '../services/donation_service.dart';
import 'package:permission_handler/permission_handler.dart';

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
    final status = await Permission.location.request();
    if (status.isGranted) {
      final position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );
      final latitude = position.latitude;
      final longitude = position.longitude;

      final sites = await fetchNearbyDonationSites(latitude, longitude);

      setState(() {
        donationSites = sites;
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
        title: Text('Clothing Disposal Sites'),
      ),
      body: ListView.builder(
        itemCount: donationSites.length,
        itemBuilder: (context, index) {
          final site = donationSites[index];
          print(site);
          final name = site['name'] ?? 'No Name';
          final address = site['vicinity'] ?? 'No Address';
          // Customize how you display the donation sites
          return ListTile(
            title: Text(name),
            subtitle: Text(address),
          );
        },
      ),
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:geolocator/geolocator.dart';
// import '../services/donation_service.dart';

// Future<void> _fetchDonationSites() async {
//   final position = await Geolocator.getCurrentPosition(
//     desiredAccuracy: LocationAccuracy.high,
//   );
//   final latitude = position.latitude;
//   final longitude = position.longitude;

//   final donationSites = await fetchNearbyDonationSites(latitude, longitude);

//   // Handle the retrieved donation sites as desired in your Flutter app, such as displaying them on a map or listing them in a user interface
//   // Update your UI here or call another method to handle the donation sites data
//   print(donationSites);
// }


// class ClothingDisposal extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Clothing Disposal Sites'),
//       ),
//       body: Center(
//         child: Text('This is the Clothing disposal sites screen'),
//       ),
//     );
//   }
// }
