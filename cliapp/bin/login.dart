
import 'package:cliapp/database.dart' as dbs;
import 'package:cliapp/loginuser.dart' as login;
import 'dart:io';

void main(List<String> arguments) async{
  
  print("WELCOME TO LOGIN PAGE");
  print("ENTER YOUR USERNAME");
  String?username = stdin.readLineSync();
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = dbs.Database(connectionString);
  await db.connect();
  bool usercheck=await db.checkuser('$username');
  if(usercheck==true)
  {
    while(true)
    {
      print("ENTER PASSWORD");
      String?pass = stdin.readLineSync();
      bool checkpassword=await db.checkpassword('$username','$pass');
      if(checkpassword==true)
      {

        
        await db.disconnect();
        final connectionString = 'mongodb://localhost:27017/cliproject';
        final active = login.activeuser(connectionString);
        await active.connect();
        bool checkactiveuser=await active.checkuser('$username');
        if(checkactiveuser==true)
        {
          print("U ARE ALREADY LOGGED IN");
          await active.disconnect();
          break;
          
        }
        else{
          await active.storeCredentials('$username','$pass');
          await active.disconnect();
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
