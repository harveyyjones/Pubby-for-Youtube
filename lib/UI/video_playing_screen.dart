import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/home_screen.dart';
import 'package:pubby_for_youtube/UI/notifications_screen.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../business_logic/firestore_database_service.dart';

class VideoPlayingScreen extends StatefulWidget {
  VideoPlayingScreen({super.key, required this.videoUrl});
  String videoUrl;

  @override
  State<VideoPlayingScreen> createState() => _VideoPlayingScreenState();
}

bool isVideoPlaying = false;

class _VideoPlayingScreenState extends State<VideoPlayingScreen>
    with WidgetsBindingObserver {
  late YoutubePlayerController _youtubePlayerController;
  bool _isPlayerReady = false;
  bool? isUserListening;
  FirestoreDatabaseService _service = FirestoreDatabaseService();

  late YoutubeMetaData _videoMetaData;
  // @override
  // void deactivate() {
  //   _youtubePlayerController.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    _service.updateIsUserListening(false, widget.videoUrl);
    WidgetsBinding.instance.removeObserver(this);
    print("Videodan çıkıldı");
    _youtubePlayerController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _videoMetaData = const YoutubeMetaData();
    final videoID = YoutubePlayer.convertUrlToId(widget.videoUrl);

    _youtubePlayerController = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
            hideThumbnail: true,
            //  hideControls: false,
            controlsVisibleAtStart: true,
            autoPlay: true,
            showLiveFullscreenButton: true))
      ..addListener(listener);

    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  void listener() async {
    int index = 0;
    await _service.updateIsUserListening(
        _youtubePlayerController.value.isPlaying, widget.videoUrl);
    print(" Video oynatılıyor mu? ${_youtubePlayerController.value.isPlaying}");
    // print(" Player state: ${_youtubePlayerController.value.playerState}");
    if (_youtubePlayerController.value.playerState == PlayerState.ended) {
      await _service.updateIsUserListening(false, widget.videoUrl);
    }
    _videoMetaData = _youtubePlayerController.metadata;
    _service.getUserDatasToMatch(
        widget.videoUrl, _youtubePlayerController.value.isPlaying);
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // App'ten direkt olarak çıkış yaptığımızda aşağıdaki kod çalışır.
    print("Life cycle state: $state");
    if (state == AppLifecycleState.paused) {
      _service.updateIsUserListening(false, widget.videoUrl);
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: YoutubePlayerBuilder(
          player: YoutubePlayer(
            onReady: () {
              print("Video açıldı.");
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
            return Scaffold(

                // appBar: AppBar(
                //   backgroundColor: Colors.white,
                //   leading: IconButton(
                //     color: Colors.black,
                //     icon: Icon(Icons.arrow_back_ios_new),
                //     onPressed: () => Navigator.of(context).pushAndRemoveUntil(
                //         CupertinoPageRoute(
                //           builder: (context) => HomeScreen(),
                //         ),
                //         (route) => false),
                //   ),
                // ),
                backgroundColor: Color.fromARGB(255, 243, 248, 255),
                body: Column(
                  children: [
                    player,
                    SizedBox(
                      height: screenHeight / 37,
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: screenWidth / 50),
                      child: Text(
                        _isPlayerReady ? _videoMetaData.title : "",
                        softWrap: true,
                        style: TextStyle(
                            height: 1,
                            fontSize: 40.sp,
                            fontFamily: fontFamilyJavanese,
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    SizedBox(
                      height: screenHeight / 66,
                    ),
                    Text(
                      _isPlayerReady
                          ? _youtubePlayerController.metadata.author
                          : "",
                      softWrap: true,
                      style: TextStyle(
                          height: 1,
                          fontSize: 40.sp,
                          fontFamily: fontFamilyJavanese,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: screenHeight / 20,
                    ),
                    Expanded(
                      child: Container(
                        color: Color.fromARGB(255, 243, 248, 255),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Text(
                              "Your Matches!",
                              style: TextStyle(
                                  fontFamily: fontFamilyJavanese,
                                  fontSize: 48.sp,
                                  fontWeight: FontWeight.w500,
                                  color: Color.fromARGB(255, 121, 117, 117)),
                            ),
                            SizedBox(
                              height: screenHeight / 444,
                            ),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left: screenWidth / 22,
                                    right: screenWidth / 22,
                                    bottom: screenHeight / 55),
                                child: Container(
                                    //TODO: Burayı azaltmak için karttaki elemanları ufalt.
                                    padding: EdgeInsets.all(15),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(14),
                                        boxShadow: const [
                                          BoxShadow(
                                              blurRadius: 5,
                                              offset: Offset(2, 2),
                                              color: Color.fromARGB(
                                                  112, 158, 158, 158))
                                        ]),
                                    child: StreamBuilder(
                                        builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        return ListView.separated(
                                            itemBuilder: (context, index) =>
                                                MatchItem(),
                                            separatorBuilder:
                                                (context, index) => SizedBox(
                                                      height: screenHeight / 33,
                                                    ),
                                            itemCount: 33);
                                      } else {
                                        return Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: screenWidth,
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 50),
                                              child: Text(
                                                "There is no anyone watching it yet.",
                                                style: TextStyle(
                                                    height: 1.5,
                                                    fontFamily:
                                                        fontFamilyJavanese,
                                                    fontSize: 48.sp,
                                                    fontWeight: FontWeight.w500,
                                                    color: Color.fromARGB(
                                                        255, 121, 117, 117)),
                                              ),
                                            ),
                                          ],
                                        );
                                      }
                                    })),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ));
          },
        ),
      ),
    );
  }
}

class MatchItem extends StatefulWidget {
  MatchItem({Key? key}) : super(key: key);

  @override
  State<MatchItem> createState() => _MatchItemState();
}

class _MatchItemState extends State<MatchItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
          color: Colors.grey.shade400,
          offset: Offset(1, 2),
          blurRadius: 1,
          blurStyle: BlurStyle.outer,
        ),
      ], borderRadius: BorderRadius.circular(22), color: Colors.white),
      height: screenHeight / 7,
      child: Row(
        children: [
          SizedBox(
            width: screenWidth / 22,
          ),
          CircleAvatar(
            maxRadius: screenWidth / 15,
            minRadius: 20,
            backgroundImage: AssetImage("assetss/teacherman.jpg"),
          ),
          SizedBox(
            width: screenWidth / 55,
          ),
          Column(
            children: [
              SizedBox(
                height: screenHeight / 55,
              ),
              Container(
                width: screenWidth / 1.7,
                height: screenHeight / 10,
                color: Colors.white,
                child: Text(
                  softWrap: true,
                  "Jack Mallon ile aynı anda \"Azer bülbül - sigarayı bıraktım\" dinlediniz",
                  style: TextStyle(
                      fontSize: 30.sp, fontFamily: "Javanese", height: 1.2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
