import 'package:flutter/material.dart';

class DrawerScreen extends StatefulWidget {
  const DrawerScreen({super.key});

  @override
  State<DrawerScreen> createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {

  Widget buildHeader(BuildContext context) => Container(
    padding: EdgeInsets.only(
      top: MediaQuery.of(context).padding.top + 20,
      bottom: 20,
    ),
    child: Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundColor: Colors.blue.shade100,
          child: Icon(
            Icons.person,
            size: 40,
            color: Colors.blue.shade700,
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          "User Profile",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const Text(
          "user@example.com",
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey,
          ),
        ),
      ],
    ),
  );

  Widget buildMenuItems(BuildContext context) => Padding(
    padding: const EdgeInsets.all(24),
    child: Wrap(
      runSpacing: 16, // vertcal spacing 
      children: [
        ListTile(
          leading: const Icon(Icons.home_outlined),
          title: const Text("Home"),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: const Icon(Icons.favorite_border),
          title: const Text("Favourites"),
          onTap: (){
            Navigator.pop(context);
          },
        ),
         ListTile(
          leading: const Icon(Icons.workspaces_outline),
          title: const Text("Workflow"),
          onTap: (){
            Navigator.pop(context);
          },
        ),
         ListTile(
          leading: const Icon(Icons.update),
          title: const Text("Updates"),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        const Divider(color: Colors.black54),
         ListTile(
          leading: const Icon(Icons.account_tree_outlined),
          title: const Text("Plugins"),
          onTap: (){
            Navigator.pop(context);
          },
        ),
         ListTile(
          leading: const Icon(Icons.notifications),
          title: const Text("Notifications"),
          onTap: (){
            Navigator.pop(context);
          },
        ),
        const SizedBox(height: 20),
        ListTile(
          leading: const Icon(Icons.logout, color: Colors.red),
          title: const Text("Logout", style: TextStyle(color: Colors.red)),
          onTap: (){
            Navigator.pop(context);
          },
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