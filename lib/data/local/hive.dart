import 'package:hive_flutter/hive_flutter.dart';

class HiveDatabase {
  HiveDatabase._();

  static final HiveDatabase _instance = HiveDatabase._();
  factory HiveDatabase() => _instance;

  static const String _loginBoxName = 'loginBox';
  static const String _instanceBoxName = 'instanceBox';

  static late Box _loginBox;
  static late Box _instanceBox;

  // Example keys
  static const String tokenKey = 'token';
  static const String userKey = 'user';
  static const String loginKey = 'login';

  // Initialize Hive
  static Future<void> init() async {
    try {
      await Hive.initFlutter();

      // You can register custom adapters if you have any custom objects
      // Hive.registerAdapter(UserAdapter()); // Uncomment and add your custom adapter for User
      // Hive.registerAdapter(TokenAdapter()); // Uncomment and add your custom adapter for Token

      _loginBox = await Hive.openBox(_loginBoxName);
      _instanceBox = await Hive.openBox(_instanceBoxName);

      print("Hive Initialized");
    } catch (e) {
      print('Error initializing Hive: $e');
    }
  }

  /// Store a value with key
  static Future<void> storeValue(String key, dynamic value) async {
    await _instanceBox.put(key, value);
    print('✅ Stored [$key]: $value');
  }

  /// Get a value by key
  static dynamic getValue(String key) {
    return _instanceBox.get(key);
  }

  /// Clear everything
  static Future<void> clearAll() async {
    await _instanceBox.clear();
    print('🧹 All data cleared from instanceBox');
  }

  // static Future<void> storeToken(String? token) async {
  //   await _tokenBox.put(tokenKey, token);
  //   print('Token stored');
  // }

  // static Future<void> storeUser(dynamic user) async {
  //   await _userBox.put(userKey, user);
  //   print('User data stored');
  // }

  // Store token (e.g., JWT)
  static Future<void> storelogin(bool? login) async {
    await _loginBox.put(loginKey, login);
    print('Login stored');
  }

  // Retrieve token
  static Future<bool?> getlogin() async {
    return _loginBox.get(loginKey);
  }

  // // Retrieve token
  // static Future<String?> getToken(String tokenKey) async {
  //   return _tokenBox.get(tokenKey);
  // }

  // // Retrieve user data
  // static Future<Map<String, dynamic>?> getUser() async {
  //   return _userBox.get(userKey);
  // }

  // // Clear the token (e.g., logout)
  // static Future<void> clearToken() async {
  //   await _tokenBox.delete(tokenKey);
  //   print('Token cleared');
  // }
}
