import 'package:crm_android/components/image_preview_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class VisitDetailScreen extends StatefulWidget {
  const VisitDetailScreen({super.key});

  @override
  State<VisitDetailScreen> createState() => _VisitDetailScreenState();
}

class _VisitDetailScreenState extends State<VisitDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
        "Visit Detail Screen",
        style: TextStyle(
          fontFamily: 'Lato',
        ),
      )),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("RSUD. Pringadi",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  )),
              const SizedBox(height: 4),
              const Text("Jalan Patimura Gg. Sabar No. 15A Komp. Amasari Medan",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                    fontFamily: 'Lato',
                  )),
              const SizedBox(height: 12),
              const Divider(),
              const SizedBox(height: 12),
              const Text("Check-in: 09:00 AM",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  )),
              const Text("Check-out: 11:00 AM",
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Lato',
                  )),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Check-in Photo",
                        style: TextStyle(
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ImagePreviewScreen(
                                  imagePath: 'assets/images/checkin.jpg'),
                            ),
                          );
                        },
                        child: Hero(
                            tag: 'assets/images/checkin.jpg',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/checkin.jpg',
                                width: 120,
                              ),
                            )),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Check-out Photo",
                        style: TextStyle(
                          fontFamily: 'Lato',
                        ),
                      ),
                      const SizedBox(height: 8),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ImagePreviewScreen(
                                  imagePath: 'assets/images/checkout.jpg'),
                            ),
                          );
                        },
                        child: Hero(
                            tag: 'assets/images/checkout.jpg',
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/checkout.jpg',
                                width: 120,
                              ),
                            )),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Location on Map",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato',
                  )),
              const SizedBox(height: 10),
              Container(
                height: 300,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                // child: ClipRRect(
                //   borderRadius: BorderRadius.circular(10),
                //   child: GoogleMap(
                //     initialCameraPosition: CameraPosition(
                //       target: LatLng(visit['latitude'], visit['longitude']),
                //       zoom: 15,
                //     ),
                //     markers: {
                //       Marker(
                //         markerId: MarkerId(visit['placeName']),
                //         position: LatLng(visit['latitude'], visit['longitude']),
                //         infoWindow: InfoWindow(title: visit['placeName']),
                //       ),
                //     },
                //   ),
                // ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
