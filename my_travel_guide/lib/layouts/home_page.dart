import 'package:firebase_admob/firebase_admob.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_travel_guide/components/home_page_grid.dart';
import 'package:my_travel_guide/components/image_slideshow.dart';
import 'package:my_travel_guide/layouts/settings_page.dart';


main() {
  runApp(HomePage());
}

const String testDevice = '';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  BannerAd _bannerAd;

  static final MobileAdTargetingInfo mobileAdTargetingInfo = new MobileAdTargetingInfo(
    keywords: <String>['travel', 'holidays'],
    childDirected: false,
  );

  @override
  void initState() {
    // TODO: implement initState
    FirebaseAdMob.instance
        .initialize(appId: "ca-app-pub-4366992646548791~2487384199");
    _bannerAd = createBannerAd()
      ..load()
      ..show();
    super.initState();
  }


  @override
  void dispose() {
    // TODO: implement dispose
    hideAdBanner();
    super.dispose();
  }

  void hideAdBanner() {
    print("hidng");
    Future.delayed(const Duration(milliseconds: 500), () {
      _bannerAd?.dispose();
      _bannerAd= null;

    });
  }

  BannerAd createBannerAd() {
    return new BannerAd(
        adUnitId: BannerAd.testAdUnitId,
        size: AdSize.banner,
        targetingInfo: mobileAdTargetingInfo,
        listener: (MobileAdEvent event) {
          print(event);
        });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(45.0),
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0.0,
            actions: <Widget>[
              IconButton(
                icon: Icon(Icons.settings),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SettingsScreen()));
                },
              )
            ],
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.grey),
          )),
      body: new ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(left: 10.0, bottom: 5.0),
            child: Text(
              "Top Destinations",
              style: TextStyle(
                  fontSize: 23.0,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  fontFamily: "Pompiere"),
            ),
          ),
          ImageSlideshow(),
          SizedBox(
            height: 5.0,
          ),
          Container(
            height: 450.0,
            width: double.infinity,
            child: PageView(
              children: <Widget>[
                RowsAndColumns(context: context, bannerAd: _bannerAd,),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

