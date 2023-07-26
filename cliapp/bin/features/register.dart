// import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/repeats/database.dart' as dbs;
import 'package:cliapp/repeats/messagedatabase.dart' as dbs1;
import 'package:cliapp/modals/user.dart' as users;
import 'dart:io';
import 'package:args/args.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
Future<void> register() async{
  stdout.write('ENTER YOUR USERNAME ');
  final username = await stdin.readLineSync();
  
  
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = dbs.Database(connectionString);
  await db.connect();
   

  bool usercheck=await db.readuser('$username');
  if(usercheck==true)
  {
   print("USER ALREADY REGISTERED");
   await db.disconnect();


  }
  else{
   stdout.write('ENTER YOUR PASSWORD ');
   final pass = await stdin.readLineSync();
   var bytes=utf8.encode(pass!);
   var digest=sha256.convert(bytes);
   final user1=users.user(username,connectionString,digest.toString());
   await user1.register();
   print("YOUR REGISTRATION HAS BEEN SUCCESSFULLY DONE");
    await db.disconnect();
    final connectionString1 = 'mongodb://localhost:27017/Message';
   final db1 = dbs1.messageDatabase(connectionString1);
   await db1.connect();
   await  db1.writeuser(username);
   await db1.disconnect();
   

   



  }

  

  


}