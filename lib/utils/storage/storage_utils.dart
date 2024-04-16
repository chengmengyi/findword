import 'package:get_storage/get_storage.dart';

class StorageUtils{
  factory StorageUtils()=>_getInstance();
  static StorageUtils get instance => _getInstance();
  static StorageUtils? _instance;
  static StorageUtils _getInstance(){
    _instance??=StorageUtils._internal();
    return _instance!;
  }

  StorageUtils._internal();

  final GetStorage _getStorage=GetStorage();

  T? getValue<T>(String key){
    try{
      return _getStorage.read(key) as T;
    }catch(e){
      return null;
    }
  }

  writeValue(String key,dynamic value){
    _getStorage.write(key, value);
  }
}