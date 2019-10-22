import 'dart:developer';

import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class Videos extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _VideosState();
  }
}

class _VideosState extends State<Videos> {
  List playList = [
    "https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4",
    "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4",
    "https://www.sample-videos.com/video123/mp4/240/big_buck_bunny_240p_1mb.mp4",
    "https://file-examples.com/wp-content/uploads/2017/04/file_example_MP4_480_1_5MG.mp4",
    "http://techslides.com/demos/sample-videos/small.mp4"
  ];

  TargetPlatform platform;
  VideoPlayerController videoPlayerController;
  ChewieController chewieController;
  int selectedIndex;
  bool isPlaying = false, isEndPlaying = false;
  List<Color> listItemColor = new List<Color>();

  @override
  void initState() {
    super.initState();
    videoPlayerController = VideoPlayerController.network(playList[0]);
    selectedIndex = 0;
    videoPlayerController.addListener(_videoListener);
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: true,
      looping: false,
      // Try playing around with some of these other options:
      // showControls: true,
      // materialProgressColors: ChewieProgressColors(
      //   playedColor: Colors.red,
      //   handleColor: Colors.blue,
      //   backgroundColor: Colors.grey,
      //   bufferedColor: Colors.lightGreen,
      // ),
      // placeholder: Container(
      //   color: Colors.grey,
      // ),
      // autoInitialize: true,
    );
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          _playView(),
          Expanded(
            child: _listView(),
          )
        ],
      ),
    );
  }

  // list area
  Widget _listView() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < 5; i++) {
      listItemColor.add(Colors.white);
      list.add(_tile(
          '${i + 1} . Video ', 'This is Video ${i + 1}', Icons.theaters, i));
    }
    return ListView(
      children: list,
    );
  }

  Container _tile(
          String _title, String _subtitle, IconData _icon, int _index) =>
      Container(
        decoration: BoxDecoration(
          color: listItemColor[_index],
        ),
        child: ListTile(
          title: Text(
            _title,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
            ),
          ),
          subtitle: Text(_subtitle),
          leading: Icon(
            _icon,
            color: Colors.blue[500],
          ),
          onTap: () => _onTappedTile(_index),
        ),
      );

  // play view area
  Widget _playView() {
    chewieController.play();
    return Chewie(controller: chewieController);
  }

  void _onTappedTile(int _index) async {
    if (!isEndPlaying) {
      listItemColor[selectedIndex] = Colors.white;
    }

    isPlaying = true;
    isEndPlaying = false;
    log("Video playing from " + playList[_index]);
    selectedIndex = _index;
    setState(() {
      listItemColor[selectedIndex] = Colors.red;
    });
    videoPlayerController = VideoPlayerController.network(playList[_index]);
    setState(() {
      chewieController.dispose();
      videoPlayerController.pause();
      videoPlayerController.seekTo(Duration(seconds: 0));
      chewieController = ChewieController(
        videoPlayerController: videoPlayerController,
        aspectRatio: 3 / 2,
        autoPlay: true,
        looping: false,
      );
    });
  }

  void _videoListener() {
    if (videoPlayerController.value.position ==
        videoPlayerController.value.duration) {
      print('video ended');
      isEndPlaying = true;
      isPlaying = false;
      setState(() {
        listItemColor[selectedIndex] = Colors.grey;
      });
    }
  }
}
