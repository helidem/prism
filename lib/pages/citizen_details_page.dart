import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class CitizenDetailsPage extends StatelessWidget {
  final Map<String, dynamic> citizen;

  CitizenDetailsPage({required this.citizen});

  @override
  Widget build(BuildContext context) {
    final fullName = "${citizen['name']['first']} ${citizen['name']['last']}";
    final pictureUrl = citizen['picture']['large'];
    final location =
        "${citizen['location']['postcode']} ${citizen['location']['city']}, ${citizen['location']['state']}, ${citizen['location']['country']}";
    final street =
        "${citizen['location']['street']['number']} ${citizen['location']['street']['name']}";
    final email = citizen['email'];
    final phone = citizen['phone'];
    final cell = citizen['cell'];
    final dateOfBirth = DateTime.parse(citizen['dob']['date']);
    final age = citizen['dob']['age'];
    final latitude =
        double.parse(citizen['location']['coordinates']['latitude']);
    final longitude =
        double.parse(citizen['location']['coordinates']['longitude']);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Citizen Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: CircleAvatar(
                radius: 80,
                backgroundImage: NetworkImage(pictureUrl),
              ),
            ),
            const SizedBox(height: 16.0),
            Text(
              fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Location: $location',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Street: $street',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Email: $email',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Phone: $phone',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Cell: $cell',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Date of Birth: ${dateOfBirth.toLocal()}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 8.0),
            Text(
              'Age: $age',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: FlutterMap(
                options: MapOptions(
                  center: LatLng(latitude, longitude),
                  zoom: 1.0,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        "https://tile.openstreetmap.org/{z}/{x}/{y}.png",
                    userAgentPackageName: 'fr.helidem.prism',
                  ),
                  MarkerLayer(
                    markers: [
                      Marker(
                        width: 40.0,
                        height: 40.0,
                        point: LatLng(latitude, longitude),
                        builder: (context) => const Icon(
                          Icons.location_on,
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
