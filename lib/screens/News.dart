import 'package:flutter/material.dart';
import 'package:mynews/Utils.dart';
import 'package:mynews/models/Articles.dart';
import 'package:mynews/screens/Details.dart';

class News extends StatefulWidget {
  List<Articles> dataList;

  News(this.dataList);

  @override
  _NewsState createState() => _NewsState();
}

class _NewsState extends State<News> {

  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery
        .of(context)
        .size
        .height;
    double _width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text('Latest News'),
        centerTitle: true,
      ),
      body: Container(
        padding: EdgeInsets.all(10.0),
        height: _height,
        width: _width,
        child: ListView.builder(
          itemBuilder: (context, position) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Details(widget.dataList[position]);
                  }));
                  ;
                },
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: FadeInImage.assetNetwork(fadeInDuration: Duration(milliseconds:100),placeholder:'assets/images/loader.png', image: widget.dataList[position].image, height: 130,
                        width: MediaQuery.of(context).size.width * 0.3,fit: BoxFit.fill,),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      width: MediaQuery
                          .of(context)
                          .size
                          .width * 0.6,
                      height: 130,
                      // color: Colors.red,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              widget.dataList[position].title
                                  .toString()
                                  .replaceRange(
                                  widget.dataList[position].title
                                      .toString()
                                      .indexOf("-"),
                                  widget.dataList[position].title
                                      .toString()
                                      .length,
                                  ""),
                              textAlign: TextAlign.right,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.0),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Expanded(
                                child: Text(
                                  widget.dataList[position].title
                                      .toString()
                                      .substring(widget.dataList[position].title
                                      .toString()
                                      .indexOf("-") +
                                      1),
                                  style: TextStyle(
                                    color: Colors.grey,
                                  ),
                                ),
                              ),
                              Row(
                                children: <Widget>[
                                  Text(
                                    Utils.date(widget.dataList[position].publishAt),
                                    style: TextStyle(
                                      color: Colors.grey,
                                    ),
                                  ),
                                  SizedBox(width: 3.0),
                                  Icon(
                                    Icons.access_time,
                                    size: 20.0,
                                    color: Colors.grey,
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          itemCount: widget.dataList.length,
        ),
      ),
    );
  }


}
