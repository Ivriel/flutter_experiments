import 'package:flutter/material.dart';

class LocationGetterPage extends StatefulWidget {
  const LocationGetterPage({super.key});

  @override
  State<LocationGetterPage> createState() => _LocationGetterPageState();
}

class _LocationGetterPageState extends State<LocationGetterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("GETTER LOCATION"),
        centerTitle: true,
      ),
    );
  }
}