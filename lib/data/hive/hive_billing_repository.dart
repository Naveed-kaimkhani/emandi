import 'dart:convert';
import 'dart:io';

import 'package:e_mandi/domain/repositories/billing_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:e_mandi/utils/utils.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveBillingRepository extends BillingRepository {
  static const String _boxName = 'BillingBox';

  @override
  Future<void> addBill(List<ItemModel> items) async {
    final box = await Hive.openBox<Map>(_boxName);
    for (var item in items) {
      await box.add(item.toJson());
    }
    await box.close();
  }

  // Backup function to export data to local storage
  Future<void> backupBillings() async {
    try {
      final box = await Hive.openBox<ItemModel>(_boxName);
      final List<Map<String, dynamic>> billingsData =
          box.values.map((item) => item.toJson()).toList();

      final directory = await getApplicationDocumentsDirectory();
      final backupFile = File('${directory.path}/billing_backup.json');

      // Write data to a file in JSON format
      String jsonString = jsonEncode(billingsData);
      await backupFile.writeAsString(jsonString);

      await box.close();
      // print('Backup successful!');
      utils.toastMessage('Backup successful!');
    } catch (e) {
      // utils.toastMessage('Backup successful!');

      utils.toastMessage('erorr $e');

      // print('Error during backup: $e');
    }
  }

// Restore function to import data from the backup file
  Future<void> restoreBillings() async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final backupFile = File('${directory.path}/billing_backup.json');

      if (await backupFile.exists()) {
        // Read the JSON file and convert it to List of Map
        String jsonString = await backupFile.readAsString();
        List<dynamic> jsonList = jsonDecode(jsonString);

        final box = await Hive.openBox<ItemModel>(_boxName);

        // Clear the current Hive box before restoring data
        await box.clear();

        // Import the data back into Hive
        for (var jsonItem in jsonList) {
          ItemModel item = ItemModel.fromJson(jsonItem);
          await box.add(item);
        }

        await box.close();
        // print('Restore successful!');
      } else {
        print('Backup file not found!');
      }
    } catch (e) {
      print('Error during restore: $e');
    }
  }

  @override
  Future<List<ItemModel>> getAllBillings() async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    final billings = box.values.toList();
    await box.close();
    return billings;
  }

  @override
  Future<void> deleteBilling(int index) async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    await box.deleteAt(index);
    await box.close();
  }

  @override
  Future<void> updateBilling(int index, ItemModel billing) async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    await box.putAt(index, billing);
    await box.close();
  }
}
