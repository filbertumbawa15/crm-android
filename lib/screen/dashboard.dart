import 'package:crm_android/components/dashboard_item_small_card.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Dashboard",
            style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Lato')),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () {},
          ),
          const CircleAvatar(
            backgroundImage: AssetImage('assets/images/user.png'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.count(
          crossAxisCount: 3,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          children: <Widget>[
            DashboardSmallCard(
              icon: Icons.people,
              title: "Customers",
              onTap: () {
                Navigator.pushNamed(context, '/customers');
              },
            ),
            DashboardSmallCard(
              icon: Icons.fingerprint,
              title: "Kehadiran",
              onTap: () {},
            ),
            DashboardSmallCard(
              icon: Icons.calendar_today,
              title: "Absensi",
              onTap: () {},
            ),
            DashboardSmallCard(
              icon: Icons.map,
              title: "Visit",
              onTap: () {
                Navigator.pushNamed(context, '/listvisit');
              },
            ),
            DashboardSmallCard(
              icon: Icons.book_online,
              title: "Cuti",
              onTap: () {},
            ),
            DashboardSmallCard(
              icon: Icons.production_quantity_limits,
              title: "Produk",
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
