import 'package:flutter/material.dart';

import 'internet.dart';

class DrawerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // ignore: non_constant_identifier_names
      onHorizontalDragEnd: (DragEndDetails) {
        print('tapped');
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.lightBlueAccent, Colors.green],
            begin: Alignment.centerLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: ListView(
            children: <Widget>[
              UserAccountsDrawerHeader(
                  onDetailsPressed: () {
                    print('pressed');
                  },
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                  ),
                  accountName:
                      Text('HARIHARAN K', style: TextStyle(fontSize: 14)),
                  accountEmail: Text('hariharankhariharan561@gmail.com',
                      style: TextStyle(fontSize: 12))),
              MenuList(
                title: 'Orders',
                iconName: Icons.border_color,
              ),
              MenuList(
                title: 'Address',
                iconName: Icons.bookmark,
              ),
              MenuList(
                title: 'Notification',
                iconName: Icons.notifications,
              ),
              MenuList(
                title: 'Help',
                iconName: Icons.help,
              ),
              MenuList(
                title: 'About',
                iconName: Icons.account_box,
              ),
              MenuList(
                title: 'Rate Us',
                iconName: Icons.star_half,
              ),
              MenuList(
                title: 'Log Out',
                iconName: Icons.exit_to_app,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MenuList extends StatelessWidget {
  final String title;
  final IconData iconName;

  const MenuList({
    @required this.title,
    @required this.iconName,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.push(
            (context), MaterialPageRoute(builder: (context) => HomePage()));
      },
      leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white24,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Icon(
            iconName,
            color: Colors.white,
          )),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
