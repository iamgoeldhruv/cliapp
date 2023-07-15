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
  Future<void> disconnect() async {
    await _active?.close();
  }
}