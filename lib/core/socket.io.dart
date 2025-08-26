import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  static final SocketService _instance = SocketService._internal();
  factory SocketService() => _instance;
  SocketService._internal();

  late IO.Socket socket;

  final String baseUrl = "http://10.0.2.2:4000"; // Use LAN IP for real device

  void connect() {
    socket = IO.io(
      baseUrl,
      IO.OptionBuilder()
          .setTransports(['websocket'])
          .disableAutoConnect()
          .build(),
    );

    // ✅ Register listeners before connect
    socket.on("messageFromServer", (data) {
      print("📩 Message from server: $data");
    });

    socket.on("friendRequestReceived", (data) {
      print("📩 Friend request received: $data");
    });

    socket.onConnect((_) {
      print("✅ Connected to WebSocket server: $baseUrl");
    });

    socket.onDisconnect((_) => print("❌ Disconnected from server"));
    socket.onError((data) => print("⚠️ Socket error: $data"));

    // Connect
    socket.connect();
  }

  void sendMessage(String msg) {
    print("➡️ Sending message: $msg");
    socket.emit('message', msg);
  }

  void disconnect() {
    socket.disconnect();
  }
}
