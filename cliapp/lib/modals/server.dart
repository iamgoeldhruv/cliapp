import 'package:mongo_dart/mongo_dart.dart';

import 'dart:io';

class Server{
  String? servername;
  Db? _myserver;
 
  


  Server( servername, connectionString) {
    this.servername = servername;
    _myserver=Db(connectionString);
  }
   
    
  
  Future<void> createServer( String creator) async {
    await _myserver?.open();

    final collection = _myserver?.collection('servername');
    
    final document = { 
      '_id': ObjectId(), 
      'servername': servername,
      'creator': creator,
      'joinedusers':[],
      'roles':{},
      'catandch':{},
      'channel':[],
      'messages':{}
      
    };
    await collection?.insert(document);
    await _myserver?.close();
  }
  Future<void> joinServer(String?username)async{
    await _myserver?.open();

    final servernameCollection = _myserver!.collection('servername');
    final serverName = servername; 
    final userName = username;
     

     
    final updateResult = await servernameCollection.update(
    where.eq('servername', serverName),
   
    modify.addToSet('joinedusers', username),
    
    );
    print('U ARE SUCCESSFULLY ADDEDD TO SERVER');
    await _myserver?.close();

   
  
  


    
    

  }

  Future<void> addRole(String username ,String role) async {
    final user = username;
    
    await _myserver?.open();
   
    final collection =_myserver!.collection('servername');

   final document = await collection.findOne(where.eq('servername', servername));
    
     if (document == null) {
      print('Server not found.');
      await _myserver?.close();
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
    
  
     await _myserver?.close();

  }
}
    
