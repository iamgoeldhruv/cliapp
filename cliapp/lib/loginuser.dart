import 'package:mongo_dart/mongo_dart.dart';
class activeuser{
  Db ?_active;
  activeuser(String connectionString) {
    _active = Db(connectionString);
    
  }
  Future<void> connect() async {
    await _active?.open();
    
  }
  Future<void> storeCredentials(String username, String password) async {
    final collection = _active?.collection('activeuser');
    final document = {
      '_id': ObjectId(), // Generate ObjectId for _id field
      'username': username,
      'password': password,
    };
    await collection?.insert(document);
  }
  Future<bool> checkuser(String username) async
  {
    final collection = _active!.collection('activeuser');
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
  Future<void> delete(String? username) async{
    final activeUserCollection = _active!.collection('activeuser');

  final usernameToDelete = username;

  await activeUserCollection.deleteOne(where.eq('username', usernameToDelete));
  
  }
  Future<void> disconnect() async {
    await _active?.close();
  }
}