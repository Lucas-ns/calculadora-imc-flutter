import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  final Future<void> Function()? onProfileTap;

  const CustomDrawer({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          InkWell(
              onTap: () async {
                Navigator.pop(context);
                if (onProfileTap != null) {
                  await onProfileTap!();
                }
              },
              child: const ListTile(
                leading: Icon(Icons.person),
                title: Text('Perfil'),
              ))
        ],
      ),
    );
  }
}
