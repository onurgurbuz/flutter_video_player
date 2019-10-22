import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_video_player/about.dart';
import 'package:flutter_video_player/videos.dart';

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  getChild() {
    switch (_selectedIndex) {
      case 0:
        return Videos();
        break;
      case 1:
        return About();
        break;
      case 2:
        SystemNavigator.pop();
        break;
      default:
        return Home();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Video Playlist'),
      ),
      body: Center(
        child: getChild(),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.video_library),
            title: Text('Videos'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.help),
            title: Text('About'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.exit_to_app),
            title: Text('Exit'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }

  void print(String text) {
    print("$text clicked...");
  }
}
