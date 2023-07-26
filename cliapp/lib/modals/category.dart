import 'package:mongo_dart/mongo_dart.dart';

class category {
  String? categoryname;
  String? servername;
  String? username;
  Db? _db;

  category(this.categoryname, this.servername, this.username, connectionString) {
    _db = Db(connectionString);
  }

  Future<void> addcategory() async {
    await _db?.open();

    final collection = _db!.collection('servername');

    final document = await collection.findOne(where.eq('servername', servername));
    if (document == null) {
      print('Server not found.');
      await _db?.close();
      return;
    }

    // Fetch the 'catandch' data and explicitly cast it to the expected type
    Map<String, dynamic>? catandchData = document['catandch'];
    Map<String, List<String>> catandch = {};

    if (catandchData != null) {
      // Convert 'catandchData' to the expected type Map<String, List<String>>
      catandchData.forEach((key, value) {
        if (value is List<dynamic>) {
          catandch[key] = List<String>.from(value);
        }
      });
    }

    // Check if the category already exists in the map
    if (!catandch.containsKey(categoryname)) {
      catandch[categoryname!] = ['text']; // Initialize the list with 'text'
    }

    // Update the document with the updated 'catandch' map
    await collection.update(
      where.eq('servername', servername),
      modify.set('catandch', catandch),
    );

    await _db?.close();
  }
}
