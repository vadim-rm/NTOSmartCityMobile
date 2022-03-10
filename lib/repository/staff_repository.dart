import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:nagib_pay/models/history_action.dart';
import 'package:nagib_pay/types/sensors_types.dart';
import 'package:nagib_pay/types/trash_types.dart';

String uuid = "0000ffe0-0000-1000-8000-00805f9b34fb";
String writeUuid = "0000ffe1-0000-1000-8000-00805f9b34fb";

class StaffRepository {
  Future<bool> connectBluetooth() async {
    bool isConnected = false;
    await FlutterBlue.instance.stopScan();
    await FlutterBlue.instance.startScan(timeout: const Duration(seconds: 2));

    var subscription = await FlutterBlue.instance.scanResults.listen(
      (results) async {
        for (ScanResult r in results) {
          // TODO: Change MAC Address
          print(r.device.name.toString()); // MacBook Pro — Даник
          if (r.device.name == "MacBook Pro — Даник") {
            print("C");
            await r.device.connect();
            List<BluetoothService> services = await r.device.discoverServices();
            services.forEach((service) async {
              var characteristics = service.characteristics;
              for (BluetoothCharacteristic c in characteristics) {
                List<int> value = await c.read();
                print(value);
              }
            });
            isConnected = true;
            break;
          }
        }
      },
    );
    print('kek');
    subscription.cancel();
    return isConnected;
  }

  Future<void> checkServo() async {
    List<BluetoothDevice> devices = await FlutterBlue.instance.connectedDevices;
    BluetoothDevice arduino =
        devices.firstWhere((device) => device.id.toString() == "");

    BluetoothCharacteristic? targetCharacteristic;

    var services = await arduino.discoverServices();
    services.forEach(
      (service) {
        if (service.uuid.toString() == uuid) {
          service.characteristics.forEach((characteristic) {
            if (characteristic.uuid.toString() == writeUuid) {
              targetCharacteristic = characteristic;

              print("Ready ${arduino.name}");
            }
          });
        }
      },
    );

    if (targetCharacteristic == null) return;

    List<int> bytes = utf8.encode("s"); // s = servo

    await targetCharacteristic!.write(bytes, withoutResponse: false);
  }

  Future<void> sendReport(
      Map<SensorType, Map<TrashType, bool>> sensorsStatus) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference reports = firestore.collection('reports');

    Map<String, Map<String, bool>> firebaseReports = {};
    sensorsStatus.forEach((sensorType, trashStatus) {
      print(sensorType);
      trashStatus.forEach((trashType, isOk) {
        firebaseReports[sensorType.getString()] = {
          ...?firebaseReports[sensorType.getString()],
          trashType.getString(): isOk
        };
      });
    });
    await reports.add(firebaseReports);
    // HistoryAction action = HistoryAction(
    // action: balance > user.balance ? "balance_increase" : "buy",
    // amount: (user.balance - balance).abs(),
    // date: DateTime.now().toUtc(),
    // type: "user",
    // userId: user.id!);
    //
    // await history.add(action.toJson());
  }
}
