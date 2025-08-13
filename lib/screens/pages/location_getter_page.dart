import 'package:experiments/reusable_widget/drawer_widget.dart';
import 'package:flutter/material.dart';

class LocationGetterPage extends StatefulWidget {
  const LocationGetterPage({super.key});

  @override
  State<LocationGetterPage> createState() => _LocationGetterPageState();
}

class _LocationGetterPageState extends State<LocationGetterPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey, 
      endDrawer: const DrawerWidget(),
      appBar: AppBar(
        title: const Text("GETTER LOCATION"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(),
            icon: const Icon(Icons.search) // Ganti icon search menjadi menu
          )
        ],
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on,
              size: 100,
              color: Colors.blue,
            ),
            SizedBox(height: 20),
            Text(
              "Location Getter Page",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Tap menu icon to open drawer",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}