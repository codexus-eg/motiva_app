import 'package:connectivity_plus/connectivity_plus.dart';

// Service for checking network connectivity status.
class NetworkInfoService {
  final Connectivity _connectivity;

  NetworkInfoService([Connectivity? connectivity])
    : _connectivity = connectivity ?? Connectivity();

  // Check if the device is currently connected to the internet.
  Future<bool> get isConnected async {
    final results = await _connectivity.checkConnectivity();
    return results.any(_isConnected);
  }

  // Stream of connectivity changes.
  // Emits whenever the network connectivity state changes.
  Stream<List<ConnectivityResult>> get onConnectivityChanged {
    return _connectivity.onConnectivityChanged;
  }

  // Helper method to determine if a ConnectivityResult indicates connection.
  bool _isConnected(ConnectivityResult result) {
    return result == ConnectivityResult.wifi ||
        result == ConnectivityResult.mobile ||
        result == ConnectivityResult.ethernet ||
        result == ConnectivityResult.vpn;
  }
}
