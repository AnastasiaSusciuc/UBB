import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:web_socket_channel/io.dart';

import '../models/my_entity.dart';
import '../repo/entity_repo.dart';

class Utils {

  static bool wsConnected = false;
  static late IOWebSocketChannel ws;

  static Future<bool> get checkInternetConnection async {

    try {
      final result = await InternetAddress.lookup('example.com');

      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {

        if (wsConnected == false) {
          connectWS();
          wsConnected = true;
        }

        MyEntityRepo.hasInternet = true;
        while (MyEntityRepo.addQueue.isNotEmpty) {
          var copy = MyEntityRepo.addQueue.first;
          MyEntityRepo().addMyEntity(copy).then(
              (_) =>
                  MyEntityRepo().updateMyEntityId(copy));
          MyEntityRepo.addQueue.removeFirst();
        }
        return true;
      }
      MyEntityRepo.hasInternet = false;
      return false;
    } on SocketException catch (_) {
      MyEntityRepo.hasInternet = false;
      return false;
    }
  }

  static void connectWS() {
    print("WS connected");
    ws = IOWebSocketChannel.connect(
      Uri.parse('ws://10.0.2.2:8080'),
    );

    ws.stream.listen((event) {
      print(event);
      var entity = MyEntity.fromJson(json.decode(event.toString()));
      print(entity);
      print("i have arrived");
      showSimpleNotification(
        Text("new recipe!\n recipe has title ${entity.name!} \n and these are the details ${entity.description!} \n you need these ingredients ${entity.ingredients!}"),
        background: Colors.orangeAccent,
      );
    });
  }
}
