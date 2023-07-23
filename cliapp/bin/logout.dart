import 'package:cliapp/loginuser.dart' as logout;
import 'dart:io';

 Future<void> logoutt() async
 {
  print("ENTER YOUR USERNAME");
  String?username = stdin.readLineSync();
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final active = logout.activeuser(connectionString);
  await active.connect();
  bool usercheck=await active.checkuser('$username');
  if(usercheck==true)
  {
    active.delete('$username');
    print("user logged out successfully");
    await active.disconnect();


  }
  else{
    print("YOR ARE ALREADY LOGGED OUT");
    await active.disconnect();

  }
   

 }


