// import 'package:mongo_dart/mongo_dart.dart';
import 'package:cliapp/database.dart' as dbs;
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
  bool usercheck=await db.checkuser('$username');
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
   await db.storeCredentials('$username',digest.toString());
   print("YOUR REGISTRATION HAS BEEN SUCCESSFULLY DONE");
    await db.disconnect();
   

   



  }

  

  


}