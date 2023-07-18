// ignore_for_file: prefer_typing_uninitialized_variables, file_names, sized_box_for_whitespace

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TabletDetailPage extends StatefulWidget {
  const TabletDetailPage({Key? key, required this.eventdata}) : super(key: key);

  final eventdata;

  @override
  State<TabletDetailPage> createState() => _TabletDetailPageState();
}

// format date type 1
String formatDate(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDate = DateFormat('d').format(dateTime);
  String formattedMonth = DateFormat('MMMM').format(dateTime);
  String formattedYear = DateFormat('y').format(dateTime);
  return '$formattedDate $formattedMonth, $formattedYear';
}

// format Date Type 2
String formatDateTime(String dateTimeString) {
  DateTime dateTime = DateTime.parse(dateTimeString);
  String formattedDay = DateFormat('EEEE').format(dateTime);
  String formattedTime = DateFormat.jm().format(dateTime);
  return '$formattedDay, $formattedTime';
}

class _TabletDetailPageState extends State<TabletDetailPage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                child: ListView(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 32,
                        ),
                        Align(
                          alignment: AlignmentDirectional.topStart,
                          child: Text(
                            widget.eventdata["title"],
                            style: const TextStyle(
                                fontWeight: FontWeight.w400, fontSize: 35),
                          ),
                        ),
                        const SizedBox(
                          height: 18,
                        ),
                        ListTile(
                          leading: Image.network(
                            widget.eventdata["organiser_icon"],
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.error,
                              size: 40,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const CircularProgressIndicator(
                                  color: Colors.black,
                                );
                              }
                            },
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.eventdata["organiser_name"],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              const Text(
                                "Organizer",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 114, 113, 113),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.calendar_month,
                            size: 50,
                            color: Colors.blue,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                formatDate(widget.eventdata["date_time"]),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                formatDateTime(widget.eventdata["date_time"]),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 114, 113, 113),
                                    fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.location_on,
                            size: 50,
                            color: Colors.blue,
                          ),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.eventdata["venue_name"],
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 16),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  const SizedBox(
                                    width: 2.5,
                                  ),
                                  Text(
                                    widget.eventdata["venue_city"],
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 114, 113, 113),
                                        fontSize: 12),
                                  ),
                                  const Text(
                                    ",",
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    widget.eventdata["venue_country"],
                                    style: const TextStyle(
                                        color:
                                            Color.fromARGB(255, 114, 113, 113),
                                        fontSize: 12),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        const Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "About Event",
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 18),
                            textAlign: TextAlign.left,
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              isExpanded = !isExpanded;
                            });
                          },
                          child: ExpandableText(
                            widget.eventdata["description"],
                            expandText: 'Read More',
                            collapseText: 'Read Less',
                            maxLines: 5,
                            linkColor: Colors.blue,
                            style: const TextStyle(fontSize: 16),
                            expanded: isExpanded,
                            onUrlTap: (value) {
                              setState(() {
                                isExpanded = !isExpanded;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: Container(
                height: double.infinity,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      leading: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.arrow_back,
                            color: Colors.white,
                          )),
                      title: const Text(
                        "Event Details",
                        style: TextStyle(color: Colors.white, fontSize: 24),
                      ),
                      expandedHeight: 244,
                      flexibleSpace: FlexibleSpaceBar(
                        background: Opacity(
                          opacity: 0.96,
                          child: Image.network(
                            widget.eventdata["banner_image"],
                            fit: BoxFit.fill,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                              Icons.error,
                              size: 40,
                            ),
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) {
                                return child;
                              } else {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: Colors.black,
                                  ),
                                );
                              }
                            },
                          ),
                        ),
                      ),
                      actions: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.bookmark_add_outlined,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        extendedPadding: const EdgeInsets.all(32),
        backgroundColor: const Color.fromARGB(255, 86, 105, 255),
        onPressed: () {},
        label: const Text(
          'Book Now',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        icon: const Icon(
          Icons.arrow_circle_right_outlined,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
