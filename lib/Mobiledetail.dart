// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MobileDetailPage extends StatefulWidget {
  const MobileDetailPage({Key? key, required this.eventdata}) : super(key: key);

  final eventdata;

  @override
  State<MobileDetailPage> createState() => _MobileDetailPageState();
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

class _MobileDetailPageState extends State<MobileDetailPage> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          CustomScrollView(
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
                      errorBuilder: (context, error, stackTrace) => const Icon(
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
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 32,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32.0),
                      child: Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Text(
                          widget.eventdata["title"],
                          style: const TextStyle(
                              fontWeight: FontWeight.w400, fontSize: 35),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 18,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: ListTile(
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: ListTile(
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
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 19),
                      child: ListTile(
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
                                      color: Color.fromARGB(255, 114, 113, 113),
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
                                      color: Color.fromARGB(255, 114, 113, 113),
                                      fontSize: 12),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "About Event",
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 18),
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32),
                      child: GestureDetector(
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
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
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
