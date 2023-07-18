// ignore_for_file: file_names, unused_local_variable, avoid_print, unused_field, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, sort_child_properties_last, sized_box_for_whitespace, body_might_complete_normally_nullable

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sde_007_assignment/Mobiledetail.dart';
import 'package:sde_007_assignment/mobileSearch.dart';

class MobileHomePage extends StatefulWidget {
  const MobileHomePage({super.key});

  @override
  State<MobileHomePage> createState() => _MobileHomePageState();
}

class _MobileHomePageState extends State<MobileHomePage> {
  List<Map<String, dynamic>> _Eventdata = [];
  bool isfetching = true;
  // Function for data fetching
  _loadevents() async {
    const apiurl =
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event";
    final response = await http.get(Uri.parse(apiurl));
    setState(() {
      isfetching = false;
    });
    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
      final List<dynamic> events = responseData["content"]["data"];
      setState(() {
        _Eventdata = List<Map<String, dynamic>>.from(events);
      });
    } else {
      const Center(child: Text("Some Error Occurred."));
    }
  }

  // FormatedDate
  String formatDateTime(String dateTimeString) {
    final parsedDateTime = DateTime.parse(dateTimeString);
    final formattedDay = DateFormat('EEE').format(parsedDateTime);
    final formattedMonth = DateFormat('MMM').format(parsedDateTime);
    final formattedDate = DateFormat('d').format(parsedDateTime);
    final formattedTime = DateFormat.jm().format(parsedDateTime);
    return '$formattedDay, $formattedMonth $formattedDate \u2022 $formattedTime';
  }

  @override
  void initState() {
    super.initState();
    _loadevents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text("Events"),
        ),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MobileSearch()));
              },
              icon: const Icon(
                Icons.search,
                size: 24,
              )),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.more_vert,
              size: 24,
            ),
          )
        ],
      ),
      body: isfetching
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : ListView.builder(
              itemCount: _Eventdata.length,
              itemBuilder: ((context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => MobileDetailPage(
                                    eventdata: _Eventdata[index],
                                  )));
                    },
                    child: Card(
                      color: Colors.white,
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(6),
                                child: Image.network(
                                  _Eventdata[index]["banner_image"],
                                  fit: BoxFit.fill,
                                  errorBuilder: (context, error, stackTrace) =>
                                      const Icon(
                                    Icons.error,
                                    size: 40,
                                  ),
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return const Padding(
                                        padding: EdgeInsets.all(32.0),
                                        child: CircularProgressIndicator(
                                          color: Colors.black,
                                        ),
                                      );
                                    }
                                  },
                                ),
                              ),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5)),
                            ),
                            if (index == 12)
                              const SizedBox(width: 6)
                            else
                              const SizedBox(width: 16),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatDateTime(
                                      _Eventdata[index]["date_time"]),
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      color: Color.fromARGB(255, 86, 105, 254)),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  _Eventdata[index]["title"],
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontSize: 15,
                                      color: Color.fromARGB(255, 18, 13, 38)),
                                ),
                                const SizedBox(height: 8),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    const Icon(
                                      Icons.location_on,
                                      size: 16,
                                      color: Colors.grey,
                                    ),
                                    Text(
                                      _Eventdata[index]["venue_name"],
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Row(
                                  children: [
                                    const SizedBox(
                                      width: 2.5,
                                    ),
                                    Text(
                                      _Eventdata[index]["venue_city"],
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                    const Text(
                                      ",",
                                      style: TextStyle(color: Colors.grey),
                                    ),
                                    const SizedBox(
                                      width: 3,
                                    ),
                                    Text(
                                      _Eventdata[index]["venue_country"],
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ]),
                    ),
                  ),
                );
              }),
            ),
    );
  }
}
