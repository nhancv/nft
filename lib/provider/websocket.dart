import 'package:socket_io_client/socket_io_client.dart' as IO;

typedef void OnMessageCallback(String tag, dynamic msg);
typedef void OnCloseCallback(int code, String reason);
typedef void OnOpenCallback();

const CLIENT_ID_EVENT = 'client-id-event';
const JOIN_ROOM_EVENT = 'join-room-event';

class SimpleWebSocket {
  String url;
  IO.Socket socket;
  OnOpenCallback onOpen;
  OnMessageCallback onMessage;
  OnCloseCallback onClose;

  SimpleWebSocket(this.url);

  connect() async {
    try {
      socket = IO.io(url, <String, dynamic>{
        'transports': ['websocket']
      });
      // Dart client
      socket.on('connect', (_) {
        print('connected');
        onOpen();
      });
      socket.on(CLIENT_ID_EVENT, (data) {
        onMessage(CLIENT_ID_EVENT, data);
      });
      socket.on(JOIN_ROOM_EVENT, (data) {
        onMessage(JOIN_ROOM_EVENT, data);
      });
      socket.on('exception', (e) => print('Exception: $e'));
      socket.on('connect_error', (e) => print('Connect error: $e'));
      socket.on('disconnect', (e) {
        print('disconnect');
        onClose(0, e);
      });
      socket.on('fromServer', (_) => print(_));
    } catch (e) {
      this.onClose(500, e.toString());
    }
  }

  send(event, data) {
    if (socket != null) {
      socket.emit(event, data);
      print('send: $event - $data');
    }
  }

  close() {
    if (socket != null) socket.close();
  }
}
