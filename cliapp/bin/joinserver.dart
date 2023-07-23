import 'package:cliapp/loginuser.dart' as login;
import 'package:cliapp/serverdatabase.dart' as server;
import "dart:io";
Future<void>joinserver() async{
  print("WANT TO JOIN SERVER ENTER YOUR USERNAME");
  String?username = stdin.readLineSync();
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = login.activeuser(connectionString);
  await db.connect();
  bool usercheck=await db.checkuser('$username');
  if(usercheck==true){
    await db.disconnect();
    print("PLEASE SELECT THE NAME OF SERVER U WANT TO JOIN FROM THE LIST GIVEN BELOW!");
    final connectionString1 = 'mongodb://localhost:27017/server';
    final db1 = server.serverdatabase(connectionString1);
    await db1.connect();
    await db1.showserver();
    String?servertojoin = stdin.readLineSync();
    await db1.joinserver(servertojoin,username);
    await db1.disconnect();

  }
  else{
    print("PLEASE LOGIN TO JOIN SERVER");
    await db.disconnect();
  }
}
