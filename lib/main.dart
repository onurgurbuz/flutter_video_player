import 'package:flutter/material.dart';
import 'package:flutter_video_player/about.dart';
import 'package:flutter_video_player/home.dart';
import 'package:flutter_video_player/videos.dart';

void main() => runApp(
      MaterialApp(
        initialRoute: "/",
        routes: {
          "/": (context) => Home(),
          "/videos": (context) => Videos(),
          "/about": (context) => About(),
        },
      ),
    );
