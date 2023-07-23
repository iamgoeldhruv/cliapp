import 'package:mongo_dart/mongo_dart.dart';
import 'dart:io';
class serverdatabase {
  Db ?_myserver;
 

  serverdatabase(String connectionString) {
    _myserver = Db(connectionString);
    

    
  }
  Db? get server => _myserver;
  Future<void> connect() async {
    await _myserver?.open();
    
  }
  Future<void> storeCredentials(String servername, String creator) async {
    final collection = _myserver?.collection('servername');
    
    final document = { 
      '_id': ObjectId(), 
      'servername': servername,
      'creator': creator,
      'joinedusers':[],
      'roles':{}
      
    };
    await collection?.insert(document);
  }
  Future<void> showserver() async{
    final servernameCollection = _myserver!.collection('servername');

  
  final List<String> serverNames = [];
  await for (var doc in servernameCollection.find()) {
    serverNames.add(doc['servername'] as String);
  }

 
  print(serverNames);

  }
  Future<void> joinserver(String?servername,String?username)async{
    final servernameCollection = _myserver!.collection('servername');
    final serverName = servername; 
    final userName = username;
     

     
    final updateResult = await servernameCollection.update(
    where.eq('servername', serverName),
   
    modify.addToSet('joinedusers', username),
    
    );
    print('U ARE SUCCESSFULLY ADDEDD TO SERVER');
   
  
  


    
    

  }
  Future<bool> checkcreator(String?username,String?servertojoin)async{
    final servernameCollection = _myserver!.collection('servername');
    final servername = servertojoin; 
    final userName = username;
    final server = await servernameCollection.findOne(where.eq('servername', servername));
    if (server == null) {
    return false;
  }
  
    if(server['creator']==username){
      return true;
    }
    else{
      return false;
    }
    


  }
  Future<void> printusers(servername) async{
    final servernameCollection = _myserver!.collection('servername');

  final serverName = servername;

  final server = await servernameCollection.findOne(where.eq('servername', serverName));

  if (server != null && server.containsKey('joinedusers')) {
    List<dynamic> joinedUsers = server['joinedusers'];

    print('Joined Users:');
    for (var user in joinedUsers) {
      print(user);
    }
  } else {
    print('Server not found or no joined users.');
  }
  }
   Future<void> disconnect() async {
    await _myserver?.close();
  }

}
