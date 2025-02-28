import 'package:crm_android/components/info_card.dart';
import 'package:crm_android/components/project_card.dart';
import 'package:crm_android/components/status_filter_chip.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        elevation: 0,
        title: const Text("Home Screen",
            style: TextStyle(
                fontSize: 18, fontFamily: 'Lato', color: Colors.white)),
        actions: const [
          Icon(Icons.notifications, color: Colors.white),
          SizedBox(width: 10),
          CircleAvatar(backgroundImage: AssetImage('assets/images/user.png')),
          SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Hi, Aaron Barr",
                style: TextStyle(fontSize: 18, fontFamily: 'Lato')),
            const Text("Welcome Back",
                style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Lato')),
            const SizedBox(height: 20),
            GridView.count(
              crossAxisCount: 3,
              shrinkWrap: true,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              children: const <Widget>[
                InfoCard(
                    title: "Projects",
                    value: "1",
                    icon: Icons.insert_drive_file),
                InfoCard(title: "Clients", value: "2", icon: Icons.group),
                InfoCard(title: "Tasks", value: "13", icon: Icons.task),
                InfoCard(
                    title: "Income", value: "00", icon: Icons.attach_money),
                InfoCard(title: "Expense", value: "00", icon: Icons.money_off),
                InfoCard(
                    title: "Profit",
                    value: "00",
                    icon: Icons.account_balance_wallet),
              ],
            ),
            const SizedBox(height: 20),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("My Projects",
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Lato')),
                Text("See All",
                    style: TextStyle(
                        fontSize: 14, color: Colors.blue, fontFamily: 'Lato')),
              ],
            ),
            const SizedBox(height: 10),
            const Row(
              children: [
                StatusFilterChip(label: "Completed", color: Colors.purple),
                SizedBox(width: 10),
                StatusFilterChip(label: "Not Started", color: Colors.red),
              ],
            ),
            const SizedBox(height: 10),
            const ProjectCard(),
          ],
        ),
      ),
    );
  }
}
