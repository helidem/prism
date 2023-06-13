import 'dart:convert';
import 'package:flutter/material.dart';
import 'citizen_details_page.dart';
import 'package:http/http.dart' as http;

class CitizensListPage extends StatefulWidget {
  const CitizensListPage({super.key});

  @override
  State<CitizensListPage> createState() => _CitizensListPageState();
}

class _CitizensListPageState extends State<CitizensListPage> {
  late List citizens = [] as List<dynamic>;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          ElevatedButton(
            onPressed:
                fetchCitizens, // Call fetchData when the button is pressed
            child: const Text('Fetch Data'),
          ),
          const SizedBox(
              height: 16), // Add some spacing between the button and the list
          Expanded(
            child: ListView.builder(
              itemCount: citizens.length,
              itemBuilder: (context, index) {
                final citizen = citizens[index];
                final fullName =
                    "${citizen['name']['first']} ${citizen['name']['last']}";
                final pictureUrl = citizen['picture']['large'];
                "${citizen['location']['city']}, ${citizen['location']['state']}, ${citizen['location']['country']}";

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            CitizenDetailsPage(citizen: citizen),
                      ),
                    );
                  },
                  child: Card(
                    child: ListTile(
                      title: Text(
                        fullName,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(pictureUrl),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void fetchCitizens() async {
    final response =
        await http.get(Uri.parse('https://randomuser.me/api/?results=40'));
    final data = jsonDecode(response.body);
    setState(() {
      citizens = data['results'];
    });
  }
}
