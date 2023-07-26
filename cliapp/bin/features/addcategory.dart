import 'package:cliapp/repeats/serverdatabase.dart' as server;


import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/repeats/database.dart' as login; 
import 'package:cliapp/modals/server.dart' as server1;
import 'package:cliapp/modals/category.dart' as category1;
import 'login.dart' ;
Future<void> addcategory()async{
  String? username=getusername();
  final connectionString1 = 'mongodb://localhost:27017/server';
    final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
     print("PLEASE SELECT THE NAME OF SERVER IN WHICH YOU WANT TO ADD CHANNEL!");
      await db1.readServer();
    String?servertoadd = stdin.readLineSync();
  bool addingpermission=await db1.readRole(username,'$servertoadd');
  if(addingpermission){
    print("ENTER THE NAME OF CATEGORY U WANT TO ADD");
    String?categoryname = stdin.readLineSync();
    final connectionString1 = 'mongodb://localhost:27017/server';
    final cat=category1.category(categoryname,servertoadd,username,connectionString1);
    await cat.addcategory();

   

  }
  else{
    print("ONLY ADMIN AND CREATOR ARE ALLOWED TO ADD CHANNEL AND CHANNEL");
    await db1.disconnect();
  }

  


}
Future<void>modusers()async{
  String? username=getusername();
  final connectionString1 = 'mongodb://localhost:27017/server';
   final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
    print("ENTER THE NAME OF SERVER");
    String?servername = stdin.readLineSync();

    List<String>l =await db1.readmodusers(servername);
    
    print(l);


}
