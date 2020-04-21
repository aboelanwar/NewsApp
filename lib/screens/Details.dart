import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mynews/Utils.dart';
import 'package:mynews/models/Articles.dart';
class Details extends StatefulWidget {
  Articles _article;
  Details(this._article);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    double _height,_wigth;
    _height=MediaQuery.of(context).size.height;
    _wigth=MediaQuery.of(context).size.width;
   return Scaffold(
     backgroundColor: Colors.black,
      appBar: AppBar(backgroundColor: Colors.black,elevation: 0.0,),
      body:Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(topLeft: Radius.circular(50.0),topRight: Radius.circular(50.0)),
          color: Colors.white,
        ),
        height: _height,
        child: ListView(
          children: <Widget>[
          Container(
            padding: EdgeInsets.only(right: 25.0),
            height:_height*0.25,
            //color: Colors.red,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top:20.0),
                  child: Text('اخبار حصرية',style: TextStyle(
                    color: Colors.redAccent
                  ),),
                ),
                Flexible(
                  flex: 2,
                  child: Text(widget._article.title,textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold
                  ),),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child:Text(Utils.date(widget._article.publishAt)),
                ),
              ],
            ),
          ),
          Container(
            height:_height*0.4,
           // color: Colors.yellow,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(widget._article.image),
                fit: BoxFit.fill
              )
            ),
          ),
          Container(
            padding: EdgeInsets.only(top: 20.0,bottom: 20.0,right:30.0,left:40.0),
           // color: Colors.grey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
           children: <Widget>[
             Text('كتب : محمد',),
             Text(widget._article.description,textAlign: TextAlign.right,style: TextStyle(
               color: Colors.grey,
               fontSize:18.0,
             ),),
           ],
            ),
          ),

          ],
        ),
      ),
    );  }
}
