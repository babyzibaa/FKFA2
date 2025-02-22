import 'package:get_storage/get_storage.dart';

class fkfaLocalStorage {

  late final GetStorage _storage;


  // Singleton Instance
  static fkfaLocalStorage? _instance;

  fkfaLocalStorage._internal();


  factory fkfaLocalStorage.instance() {

    _instance ??= fkfaLocalStorage._internal();
    return _instance!;
  }

  static Future<void> init(String bucketName) async {
    await GetStorage.init(bucketName);
    _instance = fkfaLocalStorage._internal();
    _instance!._storage = GetStorage(bucketName);
  }



  //Generic method to save data
  Future<void> saveData<ecom>(String key, ecom value) async {
    await _storage.write(key, value);
  }

  //Generic method to read data
  ecom? readData<ecom>(String key) {
    return _storage.read<ecom>(key);
  }

  //Generic method to remove data
  Future<void> removeData(String key) async {
    await _storage.remove(key);
  }

//Clear all data in storage
  Future<void> clearall() async {
    await _storage.erase();
  }
}

/// ****** Example ********* ///
// LocalStorage localStorage = LocalStorage();
//
// // Save Data
// localStorage.saveData('userName', 'JohnDoe');
//
// // Read Data
// String? userName = localStorage.readData<String>('userName');
// print('Username : $username'); // Output: Username: JohnDoe
//
// // Remove Data
// localStorage.removeData('username');
//
// // Clear All Data
// localStorage.clearAll();