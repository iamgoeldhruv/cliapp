import 'package:mongo_dart/mongo_dart.dart';

class Database {
  Db ?_db;

  Database(String connectionString) {
    _db = Db(connectionString);
    
  }

  Future<void> connect() async {
    await _db?.open();
    
  }
  Future<bool> checkuser(String username) async
  {
    final collection = _db!.collection('userdata');
    final usernameToCheck = username;
     final query = where.eq('username', usernameToCheck);
    final result = await collection.findOne(query);
   
    if (result != null) {
    return true;
    }
    else{
      return false;
    }
  }
  Future<bool> checkpassword(String username,String password) async
  {
    final collection = _db!.collection('userdata');
    
     final query = where.eq('username', username);
    final result = await collection.findOne(query);
   
   if(result != null && result['password'] != null && result['password'] == password) 
   {
    return true;
   }
   else{
    return false;
   }
    
  }
  Future<void> storeCredentials(String username, String password) async {
    final collection = _db?.collection('userdata');
    final document = {
      '_id': ObjectId(), // Generate ObjectId for _id field
      'username': username,
      'password': password,
    };
    await collection?.insert(document);
  }


  

  Future<void> disconnect() async {
    await _db?.close();
  }
}
