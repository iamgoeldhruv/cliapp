import 'package:cliapp/repeats/serverdatabase.dart' as server;

import 'package:cliapp/repeats/database.dart' as dbs;
import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/repeats/database.dart' as login;
import 'package:cliapp/modals/server.dart' as server1;
import 'package:cliapp/modals/category.dart' as category1;
import 'package:cliapp/modals/channel.dart' as channel;
import 'package:cliapp/modals/message.dart' as msg;
import 'login.dart' ;
Future<void> message() async{
  print("WELCOME TO MESSANGER:");
  print("ENTER USER TO MESSAGE TO ANY USER OR ENTER SERVER TO MESSAGE TO SERVER :");
  String?wheretomsg = stdin.readLineSync();
  String? username=  getusername();
  final connectionString1 = 'mongodb://localhost:27017/server';
   final connectionString2 = 'mongodb://localhost:27017/Message';
    final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
  if(wheretomsg=="user"){
    print("ENTER THE USERNAME OF USER TO WHOM YOU WANT TO SENF MESSAGE");
    String?usertomsg = stdin.readLineSync();
    final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = dbs.Database(connectionString);
  await db.connect();
  bool usercheck=await db.readuser(usertomsg!);
  await db.disconnect();
  if(usercheck==true){
    print("ENTER THE MESSAEGE YOU WANTTO SEND");
    String?message = stdin.readLineSync();

    final m1= msg.Message(username,connectionString2,message);
    await m1.dm(usertomsg);
}
  else{
    print("USER DOES NOT EXIST");
    await db1.disconnect();

  }
}
  else if(wheretomsg=="server"){
    print("ENTER THE NAME OF SERVER WHERE YOU WANT TO SEBD MESSAGE");
    List<String> l5=await db1.readServer();
    String?servertomessage = stdin.readLineSync();
    if(l5.contains(servertomessage)){
      print("ENTER THE NAME OF CATEGORY WHERE YOU WANT TO SEND MESSAGE");{
        List<String>l6=await db1.readCategory(servertomessage);
        print(l6);
        String?categorytomessage = stdin.readLineSync();
        if(l6.contains(categorytomessage)){
          print("SELECT CHANNEL FROM CAREGORY");
          List<String>l7=await db1.readchannelfromcategory(servertomessage,categorytomessage);
          print(l7);
           String?channeltomessage = stdin.readLineSync();
          if(l7.contains(channeltomessage)){
            if(channeltomessage=='text' || channeltomessage=='announcement'){
              print("ENTER YOUR MESSAGE");
              String?message = stdin.readLineSync();

              final m1= msg.Message(username,connectionString1,message);

               m1.msgServer(servertomessage,categorytomessage,channeltomessage);
            }
            else{
              bool check=await db1.readRole(username,servertomessage!);
              if(check){
                print("ENTER YOUR MESSAGE");
                String?message = stdin.readLineSync();
                final m1= msg.Message(username,connectionString1,message);

                m1.msgServer(servertomessage,categorytomessage,channeltomessage);}
              else{
                print("ONLY CREATOR AND ADMIN ARE ALOWED TO MESSAGE ON THIS CHANNEL");
                 await db1.disconnect();}  }
           
          }else{
            print("NO SUCH CHANNEL EXIST");
            await db1.disconnect();

          }
         }
         else{
          print("NO SUCH CATEGORY EXIST");
          await db1.disconnect();

         }}}
    else{
      print("SERVER DOES NOT EXIST");
       await db1.disconnect();
    }}
 
  else{
    print("INVALID COMMAND");
    await db1.disconnect();
  }
}
