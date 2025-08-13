import 'package:experiments/screens/pages/location_getter_page.dart';
import 'package:experiments/screens/pages/image_picker_page.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({super.key});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {

  Widget buildHeader(BuildContext context) => Material(
    color: Colors.blue.shade700,
    child: InkWell(
      onTap: (){},
      child: SizedBox(
        width: double.infinity,
        child: Container(
          padding: EdgeInsets.only(
            top: 24 + MediaQuery.of(context).padding.top,
            bottom: 24
          ),
          child: const FlutterLogo(),
        ),
      ),
    ),
  );

  Widget buildMenuItems(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16, // vertcal spacing 
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Location Getter"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const LocationGetterPage()));
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: const Text("Image Picker"),
          onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> const ImagePickerPage()));
          },
        ),
         ListTile(
          leading: const Icon(Icons.workspaces_outline),
          title: const Text("Workflow"),
          onTap: (){},
        ),
         ListTile(
          leading: const Icon(Icons.update),
          title: const Text("Updates"),
          onTap: (){},
        ),
        const Divider(color: Colors.black54),
         ListTile(
          leading: const Icon(Icons.account_tree_outlined),
          title: const Text("Plugins"),
          onTap: (){},
        ),
         ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text("Notifications"),
          onTap: (){},
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            buildHeader(context),
            buildMenuItems(context)
          ],
        ),
      ),
      
    );
  }
}