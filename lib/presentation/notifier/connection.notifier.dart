import 'dart:async';
import 'package:flutter/material.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class ConnectionNotifier extends ChangeNotifier {
  bool _hasConnection = true;
  bool get hasConnection => _hasConnection;

  late StreamSubscription _subscription;

  ConnectionNotifier() {
    _subscription = Connectivity().onConnectivityChanged.listen(
        _updateStatus as void Function(List<ConnectivityResult> event)?);
    _initConnectivity();
  }

  Future<void> _initConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _updateStatus(result as ConnectivityResult);
  }

  void _updateStatus(ConnectivityResult result) {
    _hasConnection = result != ConnectivityResult.none;
    notifyListeners();
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
