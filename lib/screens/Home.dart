import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mynews/Utils.dart';
import 'package:mynews/endpoints/Api.dart';
import 'package:mynews/models/Articles.dart';
import 'package:mynews/models/HomeTitle.dart';
import 'package:mynews/screens/Details.dart';
import 'package:mynews/screens/News.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Api _api;
  List<HomeTitle> listTitle = [];
  List<Articles> dataList = [];
  bool _isLoad = true;
  int _currentIndex;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _api = Api();
    listTitle.add(HomeTitle("All","الرئيسية"));
    listTitle.add(HomeTitle("health","الصحة"));
    listTitle.add(HomeTitle("sports","الرياضة"));
    listTitle.add(HomeTitle("business","الأعمال"));
    listTitle.add(HomeTitle("science","العلوم"));
    listTitle.add(HomeTitle("technology","التكنولوجيا"));
    listTitle.add(HomeTitle("entertainment","أخرى"));

    _api.getArticles(null).then((result) {
      dataList.addAll(result);
    }).whenComplete((){
      setState(() {
        _isLoad=false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return (_isLoad)?_loading():Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0.0,
        centerTitle: true,
        title: Text(
          'Grand News',
          style: TextStyle(fontSize: 24.0),
        ),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              // color: Colors.white,
              decoration: BoxDecoration(
                //borderRadius: BorderRadius.vertical(top: Radius.circular(50.0)),
                  color: Colors.black),
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    child: Container(
                      // color: Colors.green,
                      height: MediaQuery.of(context).size.height * 0.1,
                      width: MediaQuery.of(context).size.width,
                      child: ListView.builder(
                        itemBuilder: (context, position) {
                          List<Articles> datalist = [];
                          return InkWell(
                            onTap: () async {
                              List<Articles> dataList = [];
                              await _api
                                  .getArticles(listTitle[position].titleEn)
                                  .then((result) {
                                datalist.addAll(result);
                              }).whenComplete(() {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                      return News(datalist);
                                    }));
                              });
                            },
                            child: Center(
                                child: Padding(
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 25.0),
                                  child: Text(
                                    listTitle[position].titleAr,
                                    style: (listTitle[position].titleEn == "All")
                                        ? TextStyle(
                                        color: Colors.white,
                                        fontSize:22.0,
                                        fontWeight: FontWeight.w500)
                                        : TextStyle(
                                        color: Colors.grey, fontSize: 20.0),
                                  ),
                                )),
                          );
                        },
                        itemCount: listTitle.length,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  Column(
                    children: <Widget>[
                      Container(
                        // color: Colors.green,
                          height: MediaQuery.of(context).size.height * 0.4,
                          width: MediaQuery.of(context).size.width,
                          child: CarouselSlider(
                            options: CarouselOptions(
                                height:
                                MediaQuery.of(context).size.height * 0.4,
                                initialPage: 0,
                                autoPlayInterval: Duration(seconds: 10),
                                autoPlay: true,
                                reverse: false,
                                enlargeCenterPage: true,
                                onPageChanged: (index, s) {
                                  setState(() {
                                    _currentIndex = index;
                                  });
                                  print(_currentIndex);
                                }),
                            items: _sliderList(dataList),
                          )),
                      Container(
                        padding:
                        EdgeInsets.only(top: 60.0, left: 20.0, right: 20.0),
                        height: MediaQuery.of(context).size.height * 0.48,
                        // color: Colors.red,
                        child: SingleChildScrollView(
                          child: Column(
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.symmetric(horizontal:15.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) {
                                              return News(dataList);
                                            }));
                                      },
                                      child: Text(
                                        'المزيد',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ),
                                    Text(
                                      'أخر الأخبار',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18.0),
                                    ),

                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0,
                              ),
                              lastesNewsItems(dataList[18]),
                              lastesNewsItems(dataList[19]),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  List<Widget> _sliderList(List<Articles> articles) {
    List<Widget> list = [];
    for (int x = 0; x < 5; x++) {
      list.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return Details(articles[x]);
              }));
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  image: DecorationImage(
                      image: NetworkImage(articles[x].image),
                      fit: BoxFit.fill)),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: <Color>[Colors.black12, Colors.black54],
                      ),
                      borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(40.0),
                          bottomRight: Radius.circular(40.0))),
                  child: ListTile(
                    title: Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: Text(
                        'الرياضة',
                        textAlign: TextAlign.end,
                        style: TextStyle(
                          color: Colors.lightBlueAccent,
                        ),
                      ),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(right: 10.0, left: 10.0),
                      child: Text(
                        articles[x].title.toString().replaceRange(
                            articles[x].title.toString().indexOf("-"),
                            articles[x].title.toString().length,
                            ""),
                        textAlign: TextAlign.start,
                        textDirection: TextDirection.rtl,
                        style: TextStyle(
                          fontSize: 13.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    }
    return list;
  }

  Widget lastesNewsItems(Articles article) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0),
      child: InkWell(
        onTap: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Details(article);
          }));
        },
        child: Row(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage.assetNetwork(fadeInDuration: Duration(milliseconds:100),placeholder:'assets/images/loader.png', image: article.image, height: 130,
                width: MediaQuery.of(context).size.width * 0.3,fit: BoxFit.fill,),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 5.0),
              width: MediaQuery.of(context).size.width * 0.55,
              height:130,
              // color: Colors.red,
              child: Column(

                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Text(
                    article.title.toString().replaceRange(
                        article.title.toString().indexOf("-"),
                        article.title.toString().length,
                        ""),
                    textAlign: TextAlign.right,
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 15.0),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        article.title.toString().substring(
                            article.title.toString().indexOf("-") +1),
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 10.0
                        ),
                      ),
                      Row(
                        children: <Widget>[
                          Text(
                            Utils.date(article.publishAt),
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 13.0
                            ),
                          ),
                          SizedBox(width: 3.0),
                          Icon(
                            Icons.access_time,
                            size: 13.0,
                            color: Colors.grey,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loading() {
    return Container(
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
