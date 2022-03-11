import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nagib_pay/extensions/bluetooth_constants.dart';
import 'package:nagib_pay/models/trash_report.dart';
import 'package:quick_blue/quick_blue.dart';

class StaffRepository {
  String? arduinoId;

  Future<void> connectBluetooth(
    void Function(String, String, Uint8List)? onCharacteristicChange,
    void Function(String deviceId, BlueConnectionState state)
        onConnectionChange,
  ) async {
    // flutterReactiveBle.scanForDevices(withServices: [], scanMode: ScanMode.balanced).listen((device) {
    //   //code for handling results
    //   if (device.id == arduinoUUID) {
    //
    //   }
    // }, onError: () {
    //   //code for handling error
    // });

    QuickBlue.startScan();
    BlueScanResult arduino = await QuickBlue.scanResultStream
        .firstWhere((res) => res.deviceId == arduinoUUID);
    print(arduino.deviceId);
    QuickBlue.stopScan();
    QuickBlue.connect(arduino.deviceId);
    arduinoId = arduino.deviceId;
    QuickBlue.discoverServices(arduinoId!);
    QuickBlue.setValueHandler(onCharacteristicChange);
    QuickBlue.setConnectionHandler(onConnectionChange);
  }

  Future<void> checkServo() async {
    print("ARDUINO ID");
    print(arduinoId);
    await QuickBlue.writeValue(arduinoId!, serviceUUID, characteristicUUID,
        Uint8List.fromList('s'.codeUnits), BleOutputProperty.withoutResponse);
  }

  Future<void> sendReport(TrashReport trashReport) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    CollectionReference reports = firestore.collection('reports');

    await reports.add(trashReport.copyWith(date: DateTime.now()).toJson());
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
