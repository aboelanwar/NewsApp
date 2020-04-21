import 'package:flutter/material.dart';

class Utils{
 static String date(String date) {
    // return TimeOfDay.now().;
    String time1 =
    date.substring(date.indexOf('T') + 1, date.indexOf('Z') -6);
    int time=int.parse(time1);

    print("amr "+(TimeOfDay.now().hour-time).toString());
    return " مند "+((TimeOfDay.now().hour-time)-2).toString()+" ساعات";
 //  return date;
  }
}