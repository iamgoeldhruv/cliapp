
import 'package:cliapp/repeats/database.dart' as dbs;
// import 'package:cliapp/loginuser.dart' as login;
import 'package:cliapp/modals/user.dart' as users;
import 'package:cliapp/repeats/messagedatabase.dart' as dbs2;
import 'dart:io';
import 'package:args/args.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';
String?username;
var digest;

 Future <void> loginn() async{
  
  print("WELCOME TO LOGIN PAGE");
  stdout.write('ENTER YOUR USERNAME ');
  username = await stdin.readLineSync();

 
 
  
  
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = dbs.Database(connectionString);
  await db.connect();
  bool usercheck=await db.readuser('$username');
  if(usercheck==true)
  {
    while(true)
    {
      print("ENTER PASSWORD");
      String?pass = stdin.readLineSync();
      var bytes=utf8.encode(pass!);
      var digest=sha256.convert(bytes);
      bool checkpassword=await db.readpassword('$username',digest.toString());
      if(checkpassword==true)
      {

        
        await db.disconnect();
        final connectionString = 'mongodb://localhost:27017/cliproject';
        final loginuser = users.user(username,connectionString,digest.toString());

        await db.connect();
        bool checkactiveuser=await db.readActiveUser('$username');
        if(checkactiveuser==true)
        {
          print("U ARE ALREADY LOGGED IN");
          await db.disconnect();
          break;
          
        }
        else{
          final activeuser=users.user(username,connectionString,digest.toString());
          await activeuser.login('$username','$pass');
          await db.disconnect();
          print("LOGIN SUCCESSFULL");


          break;
        }
      }
      else{
        print("WRONG PASSWORD!TRY AGAIN");
        continue;
      }




    }
  }
  else{
    print("USER DOES NOT EXIST!");
    await db.disconnect();
    
  }








}
String getusername(){
  return '$username';

}
String getPass(){
  return digest.toString()  ;

}

