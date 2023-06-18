import 'package:flutter/material.dart';

class arNotificationsPage extends StatefulWidget {
  final bool isRegistered;

  const arNotificationsPage({super.key, required this.isRegistered});

  @override
  _arNotificationsPageState createState() => _arNotificationsPageState();
}

class _arNotificationsPageState extends State<arNotificationsPage> {
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
        title: const Text('الاشعارات',style: TextStyle(fontFamily: 'nz'),),
      ),
      body: hasNewNotification
          ? const Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.blueGrey,
              child: Icon(Icons.notifications),
            ),
            title: Text('تم تسجيل دخولك بنجاح',style: TextStyle(fontFamily: 'nz'),),

          ),

        ],
      )
          : const Center(
        child: Text('لا اشعارات جديدة',style: TextStyle(fontFamily: 'nz'),),
      ),
    );
  }
}
