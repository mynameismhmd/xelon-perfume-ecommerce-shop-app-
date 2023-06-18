import 'package:flutter/material.dart';

class NotificationsPage extends StatefulWidget {
  final bool isRegistered;

  const NotificationsPage({super.key, required this.isRegistered});

  @override
  _NotificationsPageState createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  bool hasNewNotification = false;

  @override
  void initState() {
    super.initState();

    if (widget.isRegistered && !hasNewNotification) {
      setState(() {
        hasNewNotification = true;
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
      ),
      body: hasNewNotification
          ? const Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.notifications),
            ),
            title: Text('You are registered successfully'),

          ),

        ],
      )
          : const Center(
        child: Text('No new notifications'),
      ),
    );
  }
}
