import 'package:cliapp/server.dart' as server;
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/loginuser.dart' as login;

void main(List<String> arguments) async{
  print("ENTER YOUR USERNAME");
  String?username = stdin.readLineSync();
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = login.activeuser(connectionString);
  await db.connect();
  bool usercheck=await db.checkuser('$username');
  if(usercheck==true){
    await db.disconnect();
    print("ENTER THE NAME OF YOUR SERVER");
    String?servername = stdin.readLineSync();
    final connectionString1 = 'mongodb://localhost:27017/server';
    final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
    await db1.storeCredentials('$servername','$username');
    await db1.disconnect();
    print("server created");
    
   
    








  }
  else{
    print("PLEASE LOGIN FIRST");
    await db.disconnect();

  }
  
 

}

