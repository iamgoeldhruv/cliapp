import 'package:cliapp/repeats/serverdatabase.dart' as server;
import 'package:cliapp/modals/server.dart' as server2;

import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/repeats/database.dart' as login;
import 'login.dart' ;

Future<void> createserver() async{
  
  String username = getusername();
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = login.Database(connectionString);
  await db.connect();
  bool usercheck=await db.readActiveUser('$username');
  if(usercheck==true){
    await db.disconnect();
    print("ENTER THE NAME OF YOUR SERVER");
    String?serverName = stdin.readLineSync();
    final connectionString1 = 'mongodb://localhost:27017/server';
    final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
    bool checkservername=await db1.readServerName('$serverName');
    if(checkservername==true){
      print("SERVER ALREADY EXIST PLEASE TYPE SOME ANOTHER NAME");
    }
    else{ 
      final server1=server2.Server(serverName,connectionString1);
    await server1.createServer(username);
    await db1.disconnect();
    print("server created");}
   
    
   
    








  }
  else{
    print("PLEASE LOGIN FIRST");
    await db.disconnect();

  }
  
 

}

