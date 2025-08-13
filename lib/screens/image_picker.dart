import 'dart:io';
import 'package:experiments/screens/drawer.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerScreen extends StatefulWidget {
  const ImagePickerScreen({super.key});

  @override
  State<ImagePickerScreen> createState() => _ImagePickerScreenState();
}

class _ImagePickerScreenState extends State<ImagePickerScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>(); //PENTING. ini global key buat kontrol drawer ( buka dari app bar tapi end drawer widgetnya ada di page lain karena itu custom)
  String _latitude = "";
  String _longitude = "";

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    pickImageFromCamera();
  }

  File? _image;
  final _picker = ImagePicker();
  
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

 Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {

      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {

        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {

      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _latitude = position.latitude.toString();
      _longitude = position.longitude.toString();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: const DrawerScreen(),
      appBar: AppBar(
        centerTitle: true,
        actions:  [
          const Icon(Icons.search),
          IconButton(
            onPressed: ()=> _scaffoldKey.currentState?.openEndDrawer(), 
            icon: const Icon(Icons.menu)
          )
        ],
        automaticallyImplyLeading: false,
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
            child: const Text("test")
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
          Text("Latitude $_latitude"),
          Text("Longitude $_longitude"),
          ElevatedButton(
            onPressed: _getCurrentLocation, 
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
              child: const Icon(Icons.image),
            ),
          )
        ]
      ),
    );
  }
}