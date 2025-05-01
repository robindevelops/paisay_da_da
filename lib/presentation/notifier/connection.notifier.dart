import 'dart:async';
import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:paisay_da_da/core/themes/log.dart';

class ConnectionNotifier extends ChangeNotifier {
  final Connectivity _connectivity = Connectivity();

  bool _isOnline = true;
  bool get isOnline => _isOnline;

  ConnectivityResult _connectivityResult = ConnectivityResult.none;
  ConnectivityResult get connectivityResult => _connectivityResult;

  Timer? _timer;
  int checkInterval = 5; // Interval in seconds
  int _retrySeconds = 0;
  int get retrySeconds => _retrySeconds;

  ConnectionNotifier() {
    startMonitoring();
  }

  /// Start monitoring internet connection
  Future<void> startMonitoring() async {
    await initConnectivity();

    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      Log.d("Connectivity Changed: $result");

      if (result == ConnectivityResult.none) {
        _isOnline = false;
        _startTimer();
      } else {
        if (!_isOnline) {
          _updateConnectionStatus().then((isConnected) {
            _isOnline = isConnected;
            if (_isOnline) {
              _stopTimer();
            }
            _connectivityResult = result;
            notifyListeners();
          });
          return;
        }
        if (_isOnline) {
          _stopTimer();
        }
      }

      _connectivityResult = result;
      notifyListeners();
    } as void Function(List<ConnectivityResult> event)?);
  }

  /// Initial connectivity check
  Future<void> initConnectivity() async {
    try {
      List<ConnectivityResult> status = await _connectivity.checkConnectivity();
      _isOnline =
          status != ConnectivityResult.none && await _updateConnectionStatus();
      _connectivityResult = status as ConnectivityResult;

      Log.d("Initial Connectivity Result: $status");

      if (!_isOnline) {
        _startTimer();
      }

      notifyListeners();
    } catch (e) {
      Log.e("Init Connectivity Error: $e");
    }
  }

  /// Check internet by pinging Google
  Future<bool> _updateConnectionStatus() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      final hasConnection =
          result.isNotEmpty && result[0].rawAddress.isNotEmpty;

      Log.i('Internet lookup result: $result, Connected: $hasConnection');

      return hasConnection;
    } on SocketException catch (e) {
      Log.e("Socket Exception: $e");
      return false;
    }
  }

  /// Manual connectivity check with retry
  Future<void> _checkInternetConnectivity() async {
    final previousStatus = _isOnline;
    _isOnline = await _updateConnectionStatus();

    if (previousStatus != _isOnline) {
      notifyListeners();
    }

    if (_isOnline) {
      _stopTimer();
    }
  }

  /// Start periodic retry timer
  void _startTimer() {
    _retrySeconds = 0;
    _timer ??= Timer.periodic(Duration(seconds: checkInterval), (timer) {
      _retrySeconds++;
      _checkInternetConnectivity();
      notifyListeners();
    });
  }

  /// Stop the retry timer
  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
    _retrySeconds = 0;
    notifyListeners();
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
}
