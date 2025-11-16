import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../data/models/user_model.dart';

class AuthController{
  static UserModel? userModel;
  static String? accessToken;

  static const String _userKey = 'user-data';
  static const String _tokenKey = 'token';

  static Future<void> saveUserData(UserModel model, String token)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userKey, jsonEncode(model.toJson()));
    await sharedPreferences.setString(_tokenKey,token);
    userModel = model;
    accessToken = token;
  }

  static Future<void> updateUserData(UserModel model)async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString(_userKey, jsonEncode(model.toJson()));
    userModel = model;
  }

  static Future<void> getUserData()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    userModel = UserModel.fromJson(jsonDecode(sharedPreferences.getString(_userKey)!)
    );
    accessToken = sharedPreferences.getString(_tokenKey);
  }

  static Future<bool> isUserloggedIn() async{
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(_tokenKey);
    if(token != null){
      await getUserData();
      return true;
    }else{
      return false;
    }

  }

  static Future<void> clearData()async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
    accessToken = null;
    userModel = null;
  }

}