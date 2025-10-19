import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class ApiProvider extends GetxService {
  final http.Client _http = http.Client();
  Uri? _uriServer;

  Uri get uriServer {
    if (_uriServer == null) {
      throw Exception('The led server is not set !');
    }

    return _uriServer!;
  }

  String? get uriServerString {
    return _uriServer?.toString();
  }

  set uriServer(String? server) {
    _uriServer = (server == null || server.isEmpty ? null : Uri.parse(server));
  }

  bool isServerIdentical(String server) {
    return server == (_uriServer == null ? '' : _uriServer.toString());
  }

  Future<void> increaseBrightness() async {
    await submitVal('b', '+');
  }

  Future<void> decreaseBrightness() async {
    await submitVal('b', '-');
  }

  Future<void> changeBrightness(int value) async {
    await submitVal('b', value.toString());
  }

  Future<void> increaseSpeed() async {
    await submitVal('s', '+');
  }

  Future<void> decreaseSpeed() async {
    await submitVal('s', '-');
  }

  Future<void> changeSpeed(int value) async {
    await submitVal('s', value.toString());
  }

  Future<void> autoCyclePlay() async {
    await submitVal('a', '+');
  }

  Future<void> autoCycleStop() async {
    await submitVal('a', '-');
  }

  Future<void> changeColor(Color color) async {
    final val = color.red * 65536 + color.green * 256 + color.blue;

    await submitVal('c', val.toString());
  }

  Future<void> changeMode(int mode) async {
    await submitVal('m', mode.toString());
  }

  Future<List<String>> listModes() async {
    final response = await _http.get(uriServer.replace(path: '/modes'));

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(response.body);
    }

    final modes = response.body
        .replaceAll("<li><a href='#'>", "")
        .split("</a></li>");

    modes.removeLast();

    return modes;
  }

  Future<void> submitVal(String name, String val) async {
    // queryParameters is not useable as the value "+"" is encoded as it should be
    // but WS2812FX does not decode the value.

    // final Map<String, String> queryParameters = HashMap();
    // queryParameters[name] = val;

    final uri = uriServer.replace(
      path: '/set',
      //queryParameters: queryParameters,
      query: "$name=$val",
    );

    final response = await _http.get(uri);

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw http.ClientException(response.body);
    }
  }
}
