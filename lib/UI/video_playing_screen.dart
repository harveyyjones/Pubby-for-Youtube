import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayingScreen extends StatefulWidget {
  String videoUrl;
  VideoPlayingScreen({super.key, required this.videoUrl});

  @override
  State<VideoPlayingScreen> createState() => _VideoPlayingScreenState();
}

class _VideoPlayingScreenState extends State<VideoPlayingScreen> {
  late YoutubePlayerController _youtubePlayerController;

  bool _isPlayerReady = false;

  // @override
  // void deactivate() {
  //   _youtubePlayerController.pause();
  //   super.deactivate();
  // }

  // @override
  // void dispose() {
  //   _youtubePlayerController.dispose();
  //   super.dispose();
  // }

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.videoUrl);

    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(

            //  hideControls: false,
            // controlsVisibleAtStart: true,
            autoPlay: true,
            showLiveFullscreenButton: true));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            onReady: () {
              _isPlayerReady = true;
              if (mounted) {
                setState(() {});
              }
            },
            controller: _youtubePlayerController,
            showVideoProgressIndicator: true,
            bottomActions: [
              FullScreenButton(),
              CurrentPosition(controller: _youtubePlayerController),
              Expanded(
                  child: ProgressBar(
                controller: _youtubePlayerController,
              )),
            ],
          ),
          builder: (context, player) {
            _youtubePlayerController.addListener(
              () {
                if (mounted) {
                  setState(() {});
                }
              },
            );
            return Scaffold(
                backgroundColor: Colors.white,
                body: Column(
                  children: [
                    player,
                    SizedBox(
                      height: screenHeight / 166,
                    ),
                    Padding(
                      padding: EdgeInsets.all(33),
                      child: Text(
                        _isPlayerReady
                            ? _youtubePlayerController.metadata.title
                            : "",
                        softWrap: true,
                        style: TextStyle(
                            fontSize: 40.sp,
                            fontFamily: fontFamilyCambria,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    Text(
                      _isPlayerReady
                          ? _youtubePlayerController.metadata.author
                          : "",
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 40.sp,
                          fontFamily: fontFamilyCambria,
                          fontWeight: FontWeight.w600),
                    ),
                  ],
                ));
          },
        ),
      ),
    );
  }
}
