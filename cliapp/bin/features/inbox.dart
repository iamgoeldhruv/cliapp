import 'package:cliapp/repeats/serverdatabase.dart' as server;

import 'package:cliapp/repeats/database.dart' as dbs;
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/repeats/database.dart' as login;
import 'package:cliapp/modals/server.dart' as server1;
import 'package:cliapp/modals/category.dart' as category1;
import 'package:cliapp/modals/channel.dart' as channel;
import 'package:cliapp/repeats/messagedatabase.dart' as msg;
import 'login.dart' ;
Future<void> inbox()async{
   String?username =getusername();
   final connectionString1 = 'mongodb://localhost:27017/server';
    final connectionString2 = 'mongodb://localhost:27017/Message';
      final db1 = msg.messageDatabase(connectionString2);
      await db1.connect();
      final db2 = server.serverdatabase(connectionString1);
       await db2.connect();
  print(" type personal WANT TO SEE YOUR INBOX OR type server  YOUR SERVERS INBOX");
    String?inboxtype = stdin.readLineSync();
    if(inboxtype=='personal'){
     await db1.readmessage(username);
     await db1.disconnect();

    }
    if(inboxtype=='server'){
      print("Enter the name of your server");

      List<String> l1=await db2.readServer();
      print(l1);
       
      String?servername = stdin.readLineSync();
      List<dynamic>permission=await db2.readUsers(servername);
      if(permission.contains(username))
      {
        await db2.readservermessage(servername);
        await db2.disconnect();
      }
      else{
        print("ONLY JOINED USERS CAN SEE MESSAGE");
        await db2.disconnect();

      }
    }
}