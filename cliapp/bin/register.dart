// import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/database.dart' as dbs;
import 'dart:io';
void main(List<String> arguments) async{
  print("ENTER YOUR USERNAME");

  String?username = stdin.readLineSync();
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = dbs.Database(connectionString);
  await db.connect();
  bool usercheck=await db.checkuser('$username');
  if(usercheck==true)
  {
   print("USER ALREADY REGISTERED");
   await db.disconnect();


  }
  else{
   print("ENTER PASSWORD");
   String?pass = stdin.readLineSync();
   await db.storeCredentials('$username','$pass');
    await db.disconnect();
   

   



  }
  

  


}