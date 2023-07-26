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
  
  Future <bool> readServerName(servername)async {
    final servernameCollection = _myserver!.collection('servername');

  
  final List<String> serverNames = [];
  await for (var doc in servernameCollection.find()) {
    serverNames.add(doc['servername'] as String);
  }
  if(serverNames.contains(servername)){
    return true;
  }
  else{
    return false;
  }

  }
  Future<List<String>> readServer() async{
    final servernameCollection = _myserver!.collection('servername');

  
  final List<String> serverNames = [];
  await for (var doc in servernameCollection.find()) {
    serverNames.add(doc['servername'] as String);
  }

 
  print(serverNames);
  return serverNames;

  }
  Future<void>readservermessage(servername) async{
      await _myserver?.open();
    final collection = _myserver?.collection('servername');
     final document = await collection!.findOne(where.eq('servername',servername));
     if(document!=null && document.containsKey('messages')){
      print(document['messages']);
     }

    
  }
  
  Future<bool> readCreator(String?username,String?servertojoin)async{
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
  Future<List<String>> readmodusers(server)async{
    await _myserver?.open();
     final servernameCollection = _myserver!.collection('servername');
     final document = await servernameCollection.findOne(where.eq('servername', server));
      List<String>l=[];
      if(document!=null && document.containsKey('roles')){
        Map<String, dynamic> roles=document['roles'];
       
        roles.forEach((username, role) {
        if (role == 'mod') {
        l.add(username);
        }});
        
          

        
     

  }
  
  return l;
  await _myserver?.close();
  }
  Future<List<dynamic>> readUsers(servername) async{
    final servernameCollection = _myserver!.collection('servername');

  final serverName = servername;

  final server = await servernameCollection.findOne(where.eq('servername', serverName));
  List<dynamic>l=[];

  if (server != null && server.containsKey('joinedusers')) {
    List<dynamic> joinedUsers = server['joinedusers'];

    print('Joined Users:');
    for (var user in joinedUsers) {
      l.add(user);
    }
  } else {
    print('Server not found or no joined users.');
  }
  print(l);
  return l;
  }
  Future<List<dynamic>> readChannel(servername) async{
    final servernameCollection = _myserver!.collection('servername');

  final serverName = servername;

  final server = await servernameCollection.findOne(where.eq('servername', serverName));
  List<dynamic>l=[];

  if (server != null && server.containsKey('channel')) {
    List<dynamic> joinedUsers = server['channel'];

    
    for (var user in joinedUsers) {
      l.add(user);
    }
  } else {
    print('Server not found or no joined users.');
  }
  // print(l);
  return l;
  }
  Future<bool>readRole(String username,String servername) async{
    final Collection = _myserver!.collection('servername');
     final document = await Collection.findOne(where.eq('servername', servername));
     if (document != null && document.containsKey('creator')) {
      if(document['creator']==username){
        return true;
      }
     }
      if(document!=null && document.containsKey('roles')){
        Map<String, dynamic> roles=document['roles'];
        if(roles[username]=='admin'){
          return true;
        }
      
      }
      
       return false;

      
     
     






  }
  Future<List<String>> readCategory(servername) async{
    final servernameCollection = _myserver!.collection('servername');

  final serverDocument = await servernameCollection.findOne(where.eq('servername', servername));
  
  
  if (serverDocument != null) {
    // Extract categories from the catandch map
    Map<String, dynamic> catandchMap = serverDocument['catandch'];
    List<String> categories = catandchMap.keys.toList();

    
    return categories;
  } else {
    print('Servername not found in the database.');
    await _myserver!.close();
    return [];
  }
  



  }
  Future<List<String>> readchannelfromcategory( servername,  categoryname) async {
  final servernameCollection = _myserver!.collection('servername');

  final serverDocument = await servernameCollection.findOne(where.eq('servername', servername));
  if (serverDocument != null) {
    Map<String, dynamic> catandchMap = serverDocument['catandch'];
   List<String> channelsInCategory = (catandchMap[categoryname] as List<dynamic>).cast<String>();
    return channelsInCategory;
  }

  // If servername is not found or no channels in the specified category, return an empty list.
  return [];
}


   Future<void> disconnect() async {
    await _myserver?.close();
  }

}
