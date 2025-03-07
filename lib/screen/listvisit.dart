import 'package:flutter/material.dart';

class SalesVisitLogScreen extends StatefulWidget {
  const SalesVisitLogScreen({super.key});

  @override
  State<SalesVisitLogScreen> createState() => _SalesVisitLogScreenState();
}

class _SalesVisitLogScreenState extends State<SalesVisitLogScreen> {
  int _selectedIndex = 0;
  final List<String> _tabs = ["Prospek", "Visit", "Penawaran", "Follow-Up"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sales Visit", style: TextStyle(fontFamily: 'Lato')),
        actions: [
          IconButton(
            icon: const Icon(Icons.add), // Add visit icon
            onPressed: () {
              Navigator.pushNamed(context, '/formvisit');
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Tab Navigation
          Container(
            color: Colors.purple[50],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                _tabs.length,
                (index) => TextButton(
                  onPressed: () => setState(() => _selectedIndex = index),
                  child: Text(
                    _tabs[index],
                    style: TextStyle(
                      color:
                          _selectedIndex == index ? Colors.purple : Colors.grey,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Lato',
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return const SalesVisitCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}

class SalesVisitCard extends StatelessWidget {
  const SalesVisitCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/visitdetail');
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "RSUD. Pringadi", // Visited Place Name
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato'),
              ),
              const SizedBox(height: 4),
              const Row(
                children: [
                  Icon(Icons.location_pin, color: Colors.purple),
                  SizedBox(width: 2),
                  Expanded(
                      child: Text(
                    "Jalan Patimura Gg. Sabar No. 15A Komp. Amasari Medan",
                    style: TextStyle(
                        fontSize: 14, color: Colors.grey, fontFamily: 'Lato'),
                  )),
                ],
              ),
              // const Text(
              //   "123 Main St, City, Country", // Address
              //   style: TextStyle(fontSize: 14, color: Colors.grey),
              // ),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.login, color: Colors.blue),
                          SizedBox(width: 3),
                          Text(
                            "Check-in: 09:00 AM",
                            style: TextStyle(fontFamily: 'Lato'),
                          ),
                        ],
                      ),
                      SizedBox(height: 5.0),
                      // Text("Check-in: 08:30 AM"),
                      Row(
                        children: [
                          Icon(Icons.logout, color: Colors.black),
                          SizedBox(width: 3),
                          Text(
                            "Check-out: 11:00 AM",
                            style: TextStyle(fontFamily: 'Lato'),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Image.asset('assets/images/checkin.jpg', width: 40),

                      const SizedBox(width: 10),
                      // if (visit['checkOutTime'] != null)
                      Image.asset('assets/images/checkout.jpg', width: 40),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
