import 'package:cliapp/repeats/database.dart' as login;
import 'package:cliapp/repeats/serverdatabase.dart' as server;
import 'package:cliapp/modals/server.dart' as server1;
import 'package:cliapp/modals/user.dart' as user;
import "dart:io";
import 'login.dart' ;
Future<void>joinserver() async{
 
  String?username =getusername();
  final connectionString = 'mongodb://localhost:27017/cliproject';
  final db = login.Database(connectionString);
  await db.connect();
  bool usercheck=await db.readActiveUser('$username');
  if(usercheck==true){
    await db.disconnect();
    print("PLEASE SELECT THE NAME OF SERVER U WANT TO JOIN FROM THE LIST GIVEN BELOW!");
    final connectionString1 = 'mongodb://localhost:27017/server';
    final db1 = server.serverdatabase(connectionString1);

    await db1.connect();
    List<String> l1=await db1.readServer();
    
    String?servertojoin = stdin.readLineSync();
    if(l1.contains(servertojoin)){
        final server=server1.Server(servertojoin,connectionString1);
        await server.joinServer(username);
        await db1.disconnect();

    }
    else{
      print("SERVER DOES NOT EXIST");
    }

  

  }
  else{
    print("PLEASE LOGIN TO JOIN SERVER");
    await db.disconnect();
  }
}
