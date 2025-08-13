import 'dart:developer';
import 'dart:io';

import 'package:experiments/reusable_widget/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({super.key});

  @override
  State<ImagePickerPage> createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //global key buat kontrol drawer ( buka dari floating button dan drawernya di page lain)

  @override
  void initState() {
    super.initState();
    // getLocation();
    // pickImageFromCamera();
  }

  File? _image;
  final _picker = ImagePicker();
  
  // Location variables
  double? _latitude;
  double? _longitude;
  String _locationStatus = "Getting location...";

  pickImageFromCamera() async {
   final pickedFile = await  _picker.pickImage(source: ImageSource.camera); // nullable

    if(pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        
      });
    }
  }

  
  pickImageFromGalery() async {
   final pickedFile = await  _picker.pickImage(source: ImageSource.gallery); // nullable

    if(pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {
        
      });
    }
  }

  getLocation() async {
    log("🔍 Starting getLocation() function...");
    setState(() {
      _locationStatus = "Starting location request...";
    });
    
    try {
      Location location = Location();
      log("📍 Location object created");

      // Check if location service is enabled
      bool serviceEnabled = await location.serviceEnabled();
      log("🔧 Location service enabled: $serviceEnabled");
      
      if(!serviceEnabled) {
        log("⚠️ Requesting location service...");
        serviceEnabled = await location.requestService();
        if(!serviceEnabled) {
          log("❌ Location service request failed");
          setState(() {
            _locationStatus = "Location service disabled";
          });
          return;
        }
      }

      // Check location permission
      PermissionStatus permissionGranted = await location.hasPermission();
      log("🔐 Location permission status: $permissionGranted");
      
      if(permissionGranted == PermissionStatus.denied) {
        log("⚠️ Requesting location permission...");
        permissionGranted = await location.requestPermission();
        if(permissionGranted != PermissionStatus.granted) {
          log("❌ Location permission denied");
          setState(() {
            _locationStatus = "Location permission denied";
          });
          return;
        }
      }

      log("✅ Getting current location...");
      LocationData locationData = await location.getLocation();
      log("📍 Location data received: ${locationData.latitude}, ${locationData.longitude}");
      
      setState(() {
        _latitude = locationData.latitude;
        _longitude = locationData.longitude;
        _locationStatus = "Location obtained successfully";
      });
      
      log("✅ Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}");
      
    } catch (e) {
      log("❌ Error in getLocation: $e");
      setState(() {
        _locationStatus = "Error getting location: $e";
      });
      log("Error getting location: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const DrawerWidget(),
      appBar: AppBar(
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => _scaffoldKey.currentState?.openEndDrawer(), 
            icon: const Icon(Icons.search)
          )
        ],
        title: const Text("Image Picker in Flutter",style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Column(
        children: [
          // Location display
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.blue.shade50,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.blue.shade200),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Location Status: $_locationStatus",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                if (_latitude != null && _longitude != null) ...[
                  Text("Latitude: ${_latitude!.toStringAsFixed(6)}"),
                  Text("Longitude: ${_longitude!.toStringAsFixed(6)}"),
                ],
              ],
            ),
          ),
          // Image display
          Center(
            child: _image == null?
             const Text("No Image Picked"):
             Container(
              height: 150,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.green,
                image: DecorationImage(image: FileImage(_image!), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(10)
                ),
                child: _image == null ? const CircularProgressIndicator() : null,
              // child: Image.file(_image!)
            ) ,
          ),
          ElevatedButton(
            onPressed: (){
              setState(() {
                _image = null; 
              });
            },
            child: const Text("Delete Image")
          ),
          ElevatedButton(
            onPressed: pickImageFromCamera,
            child: const Text("Take Phoyo")
          ),
          // Refresh location button
          ElevatedButton(
            onPressed: getLocation,
            child: const Text("Refresh Location")
          )
        ],
      ),
      floatingActionButton: Stack(
        children:[ 
          Positioned(
            bottom: 16,
            right: 8,
            child: FloatingActionButton(
            onPressed: (){
                pickImageFromCamera();
            },
            tooltip: 'Ambil gambar dari kamera',
            heroTag: "camera_fab",
            child: const Icon(Icons.camera_alt)
          ),
          ),
          Positioned(
            bottom: 90,
            right: 8,
            child: FloatingActionButton(
              onPressed: (){
                pickImageFromGalery();
              },
              tooltip: 'Ambil gambar dari galeri',
              heroTag: "gallery_fab",
              child: const Icon(Icons.image),
            ),
          ),
             Positioned(
            bottom: 170,
            right: 8,
            child: FloatingActionButton(
              onPressed: (){
                _scaffoldKey.currentState?.openEndDrawer();
              },
              tooltip: 'Buka drawer',
              heroTag: "menu_fab",
              child: const Icon(Icons.menu),
            ),
          )
        ]
      ),
    );
  }
}