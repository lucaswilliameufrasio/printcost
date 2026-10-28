import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:printcost/data/printer/mqtt_transport.dart';

class FakeCert implements X509Certificate {
  FakeCert(this.der);
  @override
  final Uint8List der;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class FakeTransport implements MqttTransport {
  FakeTransport({this.fail, this.cert});
  final TransportFailure? fail;
  final X509Certificate? cert;
  final messagesCtrl = StreamController<MqttMessageData>.broadcast();
  final dropCtrl = StreamController<void>.broadcast();
  final subscribed = <String>[];
  final published = <(String, String)>[];
  String? password;
  String? username;
  int? port;

  @override
  Future<void> connect({
    required String host,
    required int port,
    required String username,
    required String password,
    required String clientId,
    required bool Function(X509Certificate cert) onBadCertificate,
  }) async {
    this.port = port;
    this.username = username;
    this.password = password;
    if (cert != null && !onBadCertificate(cert!)) {
      throw const TransportException(TransportFailure.tls, 'bad cert');
    }
    if (fail != null) throw TransportException(fail!);
  }

  /// Report sent automatically when the app asks for `pushall`.
  String? autoReport;

  void emit(String topic, String payload) => messagesCtrl.add((
    topic: topic,
    payload: Uint8List.fromList(utf8.encode(payload)),
  ));

  @override
  void subscribe(String topic) => subscribed.add(topic);
  @override
  void publish(String topic, String payload) {
    published.add((topic, payload));
    final report = autoReport;
    if (report != null && payload.contains('pushall')) {
      emit(topic.replaceFirst('/request', '/report'), report);
    }
  }

  @override
  Stream<MqttMessageData> get messages => messagesCtrl.stream;
  @override
  Stream<void> get disconnected => dropCtrl.stream;
  @override
  Future<void> disconnect() async {
    await messagesCtrl.close();
    await dropCtrl.close();
  }
}
