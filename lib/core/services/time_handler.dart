import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

String handleTime(Timestamp time) {
  if(time == null)
    return "";
  DateTime newTime = time.toDate();
  final dateFormat = DateFormat('yMMMMd').add_jm();
  final dateTime = dateFormat.format(newTime);
  return (time != null) ? dateTime.toString() : "";

}