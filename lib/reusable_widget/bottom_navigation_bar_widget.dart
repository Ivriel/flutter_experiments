import 'package:experiments/screens/pages/image_picker_page.dart';
import 'package:experiments/screens/pages/location_getter_page.dart';
import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatefulWidget {
  const BottomNavigationBarWidget({super.key});

  @override
  State<BottomNavigationBarWidget> createState() => _BottomNavigationBarWidgetState();
}

class _BottomNavigationBarWidgetState extends State<BottomNavigationBarWidget> {
   int index = 0;

   List<Widget> showPages  = [
      const LocationGetterPage(),
      const ImagePickerPage(),
   ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: showPages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        selectedItemColor: Colors.blue,
        type: BottomNavigationBarType.fixed,
        onTap: (value){
          setState(() {
            index = value;
          });
        },
        items:const [
           BottomNavigationBarItem(
            icon:  Icon(Icons.map),
            label: 'Location'
          ),
          BottomNavigationBarItem(
            icon:  Icon(Icons.image),
            label: 'Image'
          )
        ]
      ),
    );
  }
}