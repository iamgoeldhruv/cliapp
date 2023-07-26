import 'package:cliapp/repeats/serverdatabase.dart' as server;


import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/repeats/database.dart' as login;
import 'package:cliapp/modals/server.dart' as server1;
import 'package:cliapp/modals/category.dart' as category1;
import 'package:cliapp/modals/channel.dart' as channel;
import 'login.dart' ;
Future<void> addChannel() async{
  String? username='dhruv';
  final connectionString1 = 'mongodb://localhost:27017/server';
    final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
    print("ENTER THE NAME OF SERVER WHERE YOU WANT TO ADD CHANNEL");
    List<String>l=await db1.readServer();
     String?servertoadd = stdin.readLineSync();
     
     if(l.contains(servertoadd)){
      print("TYPE category TO ADD CHANNEL IN A CATEGORY OR TYPE channel TO CREATE INDEPENDENT CHANNEL");
    String?whereToAdd = stdin.readLineSync();
    if(whereToAdd=='channel'){
       bool checkcreator=await db1.readRole('$username','$servertoadd');
       if(checkcreator){
        print("ENTER THE NAME OF CHANNEL");
         String?channeltoadd = stdin.readLineSync();
         final c1=channel.Channel(servertoadd,channeltoadd,connectionString1);
          List<dynamic>l1=await db1.readChannel(servertoadd);
          if(l1.contains(channeltoadd)){
            print("CHANNEL ALREADY EXIST");
            await db1.disconnect();

          }
          else{
            await c1.addIndependentChannel();
            
            await db1.disconnect();
          }

        

       }else{
        print("ONLY CREATOR AND ADMIN USERS ARE ALLOWED TO ADD ROLE");
        await db1.disconnect();
       }



    }
    else if(whereToAdd=='category'){
       
      print("PLEASE SELECT THE CATEGORY IN WHICH YOU WANT TO ADD CHANNEL");

      List<String>l3=await db1.readCategory(servertoadd);
      print(l3);
       String?categorytoadd = stdin.readLineSync();
       if(l3.contains(categorytoadd)){
        print("ENTER THE NAME OF CHANNEL YOU WANT TO ADD");
         String?channeltoadd1 = stdin.readLineSync();
         final c1=channel.Channel(servertoadd,channeltoadd1,connectionString1);
         List<String>l3=await db1.readchannelfromcategory(servertoadd,categorytoadd);
         if(l3.contains(channeltoadd1)){
          print("CHANNEL ALREADY EXIST");
          await db1.disconnect();
         }
         else{
          await c1.addChannelInCategory(categorytoadd);
          await db1.disconnect();
         }

       }else{
        print("NO SUCH CATEGORY EXIST");
        await db1.disconnect();
       }


    }
    else{
      print("INVALID");
      await db1.disconnect();

    }

     }
     else{
      print("SERVER DO NOT EXIST");
      await db1.disconnect();

     }

    
    }
    