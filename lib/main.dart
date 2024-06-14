import 'package:flutter/material.dart';
import 'package:flutter_app_1/provider/MediTrack.dart';
import 'package:flutter_app_1/provider/PageTracker.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

import 'addMedic.dart';
import 'homePage.dart';
import 'medicationList.dart';
import 'missedMedic.dart';

void main() {
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    // Define provider(s) to access information
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MediTrack()),
        ChangeNotifierProvider(create: (context) => PageTracker())
      ],
      child: MaterialApp(
        title: 'MediTrack',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 3, 121, 255)),
          useMaterial3: true,
        ),
        home: const MyHomePage(title: 'MediTrack'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  // All available pages in application (index 0 to 3)
  final _pageOptions = [
    DefaultPage(),
    MedicList(),
    AddMedic(),
    MissedMedic()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<PageTracker>(
      builder: (context, value, child) => Scaffold(
      
          // Create bottom navigation bar
          bottomNavigationBar: Container(
          color: Colors.black,
          
          // To make navigation bar higher and centerer
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          
            // Use google nav bar
            child: GNav(
              backgroundColor: Colors.black,
          
              // Color of text
              color: Colors.white,
          
              // Changes color of active tab
              activeColor: Colors.white,
          
              // Color of background active tab
              tabBackgroundColor: Colors.grey.shade800,
              padding: const EdgeInsets.all(16),
              gap: 8,
          
              // Change page when clicked
              onTabChange: (index) {
                value.changePage(id: index);
              },
          
              // Define all buttons in navigation bar
              tabs: const [
                GButton(icon: Icons.home, text: "Home"),
                GButton(icon: Icons.list, text: "Medic list"),
                GButton(icon: Icons.add, text: "Add medic"),
                GButton(icon: Icons.call_missed, text: "Missed medic"),
              ],
            ),
          ),
            ),
        
          // Appbar top of application
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            title: Text(widget.title),
          ),
      
          // Column to list all Widget from HomePage
          body: _pageOptions[value.getPage]
        ),
    );
  }
}
