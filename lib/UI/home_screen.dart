import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pubby_for_youtube/UI%20Helpers/bottom_bar.dart';
import 'package:pubby_for_youtube/UI%20Helpers/constants.dart';
import 'package:pubby_for_youtube/UI/video_playing_screen.dart';
import 'package:youtube_api/youtube_api.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

String? thingToSearch = "";
late ValueNotifier _notifier;

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState([this.query = "dualipa"]);
  String? query;
  static String key = "AIzaSyC-aR0Fc2Xt-upNb1X6bEIxPdvAq_ug1EI";

  YoutubeAPI youtube = YoutubeAPI(
    key,
    type: "video",
    maxResults: 40,
  );
  List<YouTubeVideo> videoResult = [];

  Future<void> callAPI(query) async {
    print("CallApi() metodu tetiklendi.");
    // String query = "";
    videoResult = await youtube.search(query,
        order: 'relevance',
        videoDuration: 'any',
        regionCode: "TR",
        type: "video");
    videoResult = await youtube.nextPage();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    print("İnitstate() tetiklendi");
    _notifier = ValueNotifier(thingToSearch);
    super.initState();
    callAPI("emienm");
    print('hello');
  }

  @override
  Widget build(BuildContext context) {
    _notifier.addListener(() {
      print("addListener() tetiklendi");
      setState(() {
        callAPI(_notifier.value);
      });
    });
    return Scaffold(
      bottomNavigationBar: BottomBar(selectedIndex: 0),
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              
              // method to show the search bar
              showSearch(
                  context: context,
                  // delegate to customize the search bar
                  delegate: CustomSearchDelegate());
            },
            icon: const Icon(Icons.search),
          )
        ],
        title: Text('Youtube API'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: videoResult.map<Widget>(listItem).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget listItem(YouTubeVideo video) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => VideoPlayingScreen(videoUrl: video.url),
        ));
      },
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Container(
                  width: screenWidth / 2,
                  height: screenHeight / 4.5,
                  // color: Colors.black,
                  child: Image.network(
                    video.thumbnail.high.url ?? '',
                  ),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      video.title,
                      softWrap: true,
                      style: TextStyle(
                          fontSize: 26.sp,
                          fontFamily: fontFamilyCambria,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: screenHeight / 99,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 3.0,
                      ),
                      child: Text(
                        video.channelTitle,
                        softWrap: true,
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: fontFamilyCambria,
                            fontSize: 22.sp),
                      ),
                    ),
                    Text(
                      video.duration.toString(),
                      softWrap: true,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
// Demo list to show querying
  List<String> searchTerms = [
    // "Apple",
    // "Banana",
    // "Mango",
    // "Pear",
    // "Watermelons",
    // "Blueberries",
    // "Pineapples",
    // "Strawberries"
  ];

// first overwrite to
// clear the search text
  @override
  List<Widget>? buildActions(BuildContext context) {
    _HomeScreenState _homeScreenState = _HomeScreenState(query);
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: Icon(Icons.clear),
      ),
      IconButton(
          onPressed: () {
            print(query);
            _notifier.value = query;
            _HomeScreenState(query);
            _homeScreenState.callAPI(query);
            Navigator.of(context).pop();
          },
          icon: Icon(Icons.search))
    ];
  }

// second overwrite to pop out of search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: Icon(Icons.arrow_back),
    );
  }

// third overwrite to show query result
  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }

// last overwrite to show the
// querying process at the runtime
  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var fruit in searchTerms) {
      if (fruit.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(fruit);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return ListTile(
          title: Text(result),
        );
      },
    );
  }
}
