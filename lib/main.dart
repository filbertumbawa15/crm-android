import 'package:crm_android/bloc/customers/customers_bloc.dart';
import 'package:crm_android/screen/customer.dart';
import 'package:crm_android/screen/dashboard.dart';
import 'package:crm_android/screen/home.dart';
import 'package:crm_android/screen/listvisit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => CustomersBloc()..add(ListCustomerEvent()),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const StartScreen(),
          '/customers': (context) => const CustomerPage(),
          '/listvisit': (context) => const SalesVisitLogScreen(),
        },
      ),
    );
  }
}

class StartScreen extends StatefulWidget {
  const StartScreen({super.key});

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _widgetOptions();
  }

  List<Widget> _widgetOptions() {
    return [
      const HomeScreen(),
      const DashboardScreen(),
    ];
  }

  void onItemTapped(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await SystemNavigator.pop();
        return false;
      },
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: _widgetOptions().elementAt(selectedIndex),
        ),
        // bottomNavigationBar: Theme(
        //   data: ThemeData(
        //     splashColor: Colors.transparent,
        //     highlightColor: Colors.transparent,
        //   ),
        //   child: Material(
        //     elevation: 10,
        //     child: BottomNavigationBar(
        //       items: const <BottomNavigationBarItem>[
        //         BottomNavigationBarItem(
        //           icon: Icon(Icons.home),
        //           label: 'Beranda',
        //           tooltip: '',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: Stack(
        //             children: <Widget>[
        //               Icon(Icons.account_circle_sharp),
        //             ],
        //           ),
        //           label: "Profil",
        //           tooltip: '',
        //         ),
        //         BottomNavigationBarItem(
        //           icon: Icon(Icons.settings),
        //           label: 'Pengaturan',
        //           tooltip: '',
        //         ),
        //       ],
        //       currentIndex: 0,
        //       selectedLabelStyle: const TextStyle(
        //         fontFamily: 'Nunito-Medium',
        //       ),
        //       unselectedLabelStyle: const TextStyle(
        //         fontFamily: 'Nunito-Medium',
        //         fontSize: 14.0,
        //       ),
        //       fixedColor: const Color(0xFF5599E9),
        //     ),
        //   ),
        // ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: onItemTapped,
          currentIndex: selectedIndex,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.movie_filter_sharp), label: "Dashboard"),
            BottomNavigationBarItem(icon: Icon(Icons.list), label: "Documents"),
          ],
        ),
      ),
    );
  }
}
