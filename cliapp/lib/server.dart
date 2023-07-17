import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';
class serverdatabase {
  Db ?_server;

  serverdatabase(String connectionString) {
    _server = Db(connectionString);
    

    
  }
  Future<void> connect() async {
    await _server?.open();
    
  }
  Future<void> storeCredentials(String servername, String creator) async {
    final collection = _server?.collection('servername');
    final document = {
      '_id': ObjectId(), 
      'servername': servername,
      'creator': creator,
      'joinedusers':[],
    };
    await collection?.insert(document);
  }
  Future<void> showserver() async{
    final servernameCollection = _server!.collection('servername');

  
  final List<String> serverNames = [];
  await for (var doc in servernameCollection.find()) {
    serverNames.add(doc['servername'] as String);
  }

 
  print(serverNames);

  }
  Future<void> joinserver(String?servername,String?username)async{
    final servernameCollection = _server!.collection('servername');
    final serverName = servername; 
    final userName = username;
     

     
    final updateResult = await servernameCollection.update(
    where.eq('servername', serverName),
   
    modify.addToSet('joinedusers', username),
    
    );
    print('U ARE SUCCESSFULLY ADDEDD TO SERVER');
    if (updateResult['nModified'] == 1) {
    print('Username added to the server');
  } else {
    print('Username already exists in the joinedusers array.');
  }


    
    

  }
   Future<void> disconnect() async {
    await _server?.close();
  }

}