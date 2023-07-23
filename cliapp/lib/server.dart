import 'package:mongo_dart/mongo_dart.dart';
import 'serverdatabase.dart';
import 'dart:io';

class Server extends serverdatabase {
  String? servername;
 
  


  Server(String servername, String connectionString) : super(connectionString) {
    this.servername = servername;
   
    
  }

  Future<void> addRole(String username ,String role) async {
    final user = username;
    
    await connect();
   
    final collection =server!.collection('servername');

   final document = await collection.findOne(where.eq('servername', servername));
    
     if (document == null) {
      print('Server not found.');
      await disconnect();
      return;
    }
     
       Map<String, String> roles = Map<String, String>.from(document['roles'] ?? {});
   
      // Add the username and role to the map.
      roles[username] = role;

      // Update the document with the new `roles` field.
      await collection.update(
        where.eq('servername', servername),
        modify.set('roles', roles),
      );
    
  
     await disconnect();

  }
}
