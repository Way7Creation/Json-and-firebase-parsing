import 'package:eclipse/screen/User/userlist.dart';
import 'package:eclipse/screen/albums/albumsall.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  int _selectedIndex = 0;
  final List<Widget> _widgetOptions =<Widget>[
    const UsersList(),
    const AlbumsUserAll(),
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Eclipse Digital Studio'),
      ),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(items:
      const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Users',
        ),
        BottomNavigationBarItem(
        icon: Icon(Icons.photo_album),
          label: 'Albums',
        ),
      ],
        currentIndex: _selectedIndex,
        onTap: _onItemTap,
      ),
    );
  }
}
