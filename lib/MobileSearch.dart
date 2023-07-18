// ignore_for_file: file_names, sized_box_for_whitespace, non_constant_identifier_names
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import 'Mobiledetail.dart';

class MobileSearch extends StatefulWidget {
  const MobileSearch({super.key});

  @override
  State<MobileSearch> createState() => _MobileSearchState();
}

class _MobileSearchState extends State<MobileSearch> {
  List<Map<String, dynamic>> _Eventdata = [];
  String search = "";
  bool isFetching = true;

  // Function for data fetching
  _loadevents() async {
    const apiurl =
        "https://sde-007.api.assignment.theinternetfolks.works/v1/event";
    final response = await http.get(Uri.parse(apiurl));
    setState(() {
      isFetching = false;
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
        title: const Text("Search"),
      ),
      body: isFetching
          ? const Center(
              child: CircularProgressIndicator(
                color: Colors.black,
              ),
            )
          : Container(
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: [
                          BoxShadow(
                            color: const Color.fromARGB(255, 222, 221, 221)
                                .withOpacity(0.3),
                            spreadRadius: 2,
                            blurRadius: 2,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            search = value;
                          });
                        },
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          focusColor: Colors.black,
                          labelStyle: TextStyle(
                            fontSize: 20,
                            color: Colors.black,
                            wordSpacing: 2,
                            letterSpacing: 1.5,
                          ),
                          labelText: 'Type Event Name',
                          prefixIcon: Icon(
                            Icons.search,
                            size: 34,
                          ),
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: ListView.builder(
                      itemCount: _Eventdata.length,
                      itemBuilder: (context, index) {
                        final item = _Eventdata[index];
                        final isMatched =
                            (item["title"].toString().toLowerCase())
                                .contains(search.toLowerCase());
                        if (isMatched) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 8, horizontal: 20),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MobileDetailPage(
                                      eventdata: item,
                                    ),
                                  ),
                                );
                              },
                              child: Card(
                                color: Colors.white,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(6),
                                        child: Image.network(
                                          item["banner_image"],
                                          fit: BoxFit.fill,
                                          errorBuilder:
                                              (context, error, stackTrace) =>
                                                  const Icon(
                                            Icons.error,
                                            size: 40,
                                          ),
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            } else {
                                              return const Padding(
                                                padding: EdgeInsets.all(32.0),
                                                child:
                                                    CircularProgressIndicator(
                                                  color: Colors.black,
                                                ),
                                              );
                                            }
                                          },
                                        ),
                                      ),
                                    ),
                                    if (index == 12)
                                      const SizedBox(width: 6)
                                    else
                                      const SizedBox(width: 16),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          formatDateTime(item["date_time"]),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            color: Color.fromARGB(
                                                255, 86, 105, 254),
                                          ),
                                        ),
                                        const SizedBox(height: 6),
                                        Text(
                                          item["title"],
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 15,
                                            color:
                                                Color.fromARGB(255, 18, 13, 38),
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.location_on,
                                              size: 16,
                                              color: Colors.grey,
                                            ),
                                            Text(
                                              item["venue_name"],
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Row(
                                          children: [
                                            const SizedBox(width: 2.5),
                                            Text(
                                              item["venue_city"],
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                            const Text(
                                              ",",
                                              style:
                                                  TextStyle(color: Colors.grey),
                                            ),
                                            const SizedBox(width: 3),
                                            Text(
                                              item["venue_country"],
                                              style: const TextStyle(
                                                color: Colors.grey,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        } else {
                          return const SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
