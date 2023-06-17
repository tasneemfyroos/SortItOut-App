import 'package:http/http.dart' as http;
import 'dart:convert';
// import 'package:googleapis_auth/auth_io.dart';

Future<List<dynamic>> fetchNearbySites(
    double latitude, double longitude, String type) async {
  final apiKey = "";
  final radius = 500;
  // final type = 'clothing_donation';

  final url = Uri.parse(
    'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
    'location=$latitude,$longitude'
    '&radius=$radius'
    '&type=$type'
    '&key=$apiKey',
  );

  final response = await http.get(url);

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['results'];
  } else {
    throw Exception('Failed to fetch donation sites');
  }
}

// Future<String> fetchApiKeyFromSecretManager() async {
//   // name of secret in Google Secret Manager
//   final secretName = 'google_maps_api_key';
//
//   final client = await clientViaApplicationDefaultCredentials(scopes: const [
//     'https://www.googleapis.com/auth/cloud-platform',
//   ]);
//
//   final response = await client.send(http.Request(
//     'GET',
//     Uri.parse(
//       'https://secretmanager.googleapis.com/v1/projects/-/secrets/$secretName/versions/latest',
//     ),
//   ));
//
//   if (response.statusCode == 200) {
//     final jsonResponse = await response.stream.bytesToString();
//     final data = json.decode(jsonResponse);
//     return data['payload']['data'];
//   } else {
//     throw Exception('Failed to fetch API key from Secret Manager');
//   }
// }

// import 'package:http/http.dart' as http;
// import 'dart:convert';
//
// Future<List<dynamic>> fetchNearbyDonationSites(
//     double latitude, double longitude) async {
//   final apiKey = await fetchApiKeyFromSecretManager();
//   final radius = 5000;
//   final type = 'clothing_donation';
//
//   final url = Uri.parse(
//     'https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
//     'location=$latitude,$longitude'
//     '&radius=$radius'
//     '&type=$type'
//     '&key=$apiKey',
//   );
//
//   final response = await http.get(url);
//
//   if (response.statusCode == 200) {
//     final data = json.decode(response.body);
//     return data['results'];
//   } else {
//     throw Exception('Failed to fetch donation sites');
//   }
// }
//
// Future<String> fetchApiKeyFromSecretManager() async {
//   // Replace 'YOUR_PROJECT_ID' with your Google Cloud project ID
//   final projectId = 'spartan-card-389108';
//   // Replace 'YOUR_SECRET_NAME' with the name of the secret where your API key is stored
//   final secretName = 'google_maps_api_key';
//
//   final endpointUrl =
//       'https://secretmanager.googleapis.com/v1/projects/$projectId/secrets/$secretName/versions/latest';
//
//   final response = await http.get(Uri.parse(endpointUrl));
//
//   if (response.statusCode == 200) {
//     final jsonResponse = json.decode(response.body);
//     final apiKey = jsonResponse['payload'][
//         'data']; // Adjust the JSON parsing based on the structure of the response
//     return apiKey;
//   } else {
//     throw Exception('Failed to fetch API key from Secret Manager');
//   }
// }