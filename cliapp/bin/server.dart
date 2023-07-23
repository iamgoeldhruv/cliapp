import 'package:cliapp/serverdatabase.dart' as server;


import 'dart:io';
import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/loginuser.dart' as login;
import 'package:cliapp/server.dart' as server1;
Future<void> addrole()async{
  print("ENTER YOUR USERNAME");
      String?username = stdin.readLineSync();
      final connectionString = 'mongodb://localhost:27017/cliproject';
    final db = login.activeuser(connectionString);
    await db.connect();
    bool usercheck=await db.checkuser('$username');
    if(usercheck==true){
    await db.disconnect();
    print("PLEASE SELECT THE NAME OF SERVER IN WHICH YOU WANT TO ADD ROLES!");
    final connectionString1 = 'mongodb://localhost:27017/server';
    final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
    await db1.showserver();
    String?servertoadd = stdin.readLineSync();
    bool checkcreator=await db1.checkcreator('$username','$servertoadd');
    if(checkcreator==true){
      print("ENTER THE USERNAME OF USER U WANT TO ASSIGN ROLE");
      await db1.printusers(servertoadd);
      while(true){
        print("ENTER THE USERNAME OF USER U WANT TO ASSIGN ROLE ELSE PRESS exit TO STOPP ASSIGNNING ROLE");
         String?usertoaddrole = stdin.readLineSync();
         if(usertoaddrole=='exit'){
           await db1.disconnect();
          break;
          
         }
         else{
          final server=server1.Server('$servertoadd',connectionString1);
          print("ENTER THE ROLE U WANT TO ASSIGN");
          String?role = await stdin.readLineSync();
          await server.addRole('$usertoaddrole','$role');


         }



      }

      
      

    }
    else{
      print("ONLY CREATOR OF SERVER CAN ADD ROLES YOU ARE NOT ALLOWED TO ADD ROLES");
       await db1.disconnect();
      
      


    }



  }
  else{
    print("PLEASE LOGIN FIRST");
    
  }
}
