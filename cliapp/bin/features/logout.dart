import 'package:cliapp/repeats/database.dart' as logout;
import 'dart:io';
import 'login.dart' ;

 Future<void> logoutt() async
 {
  
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = logout.Database(connectionString);
  await db.connect();
  String username=getusername();
  
  bool usercheck=await db.readActiveUser(username);
  if(usercheck==true)
  {
    db.delete('$username');
    print("user logged out successfully");
    await db.disconnect();


  }
  else{
    print("YOR ARE ALREADY LOGGED OUT");
    await db.disconnect();

  }
   

 }


