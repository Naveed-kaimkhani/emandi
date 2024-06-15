import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:hive/hive.dart';

class BillingRepository {
  static const String _boxName = 'BillingBox';


  // Future<void> addBill(ItemModel item) async {
  //   final box = await Hive.openBox<Map>(_boxName);
  //   await box.add(item.toJson());
  //   await box.close();
  //   print('bill added');
  // }
  
   Future<void> addBill(List<ItemModel> items) async {
    final box = await Hive.openBox<Map>(_boxName);
    for (var item in items) {
      await box.add(item.toJson());
    }
    await box.close();
    print('bills added');
  }

  Future<List<ItemModel>> getAllBillings() async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    final billings = box.values.toList();
    await box.close();
    return billings;
  }

  Future<void> deleteBilling(int index) async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    await box.deleteAt(index);
    await box.close();
  }

  Future<void> updateBilling(int index, ItemModel billing) async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    await box.putAt(index, billing);
    await box.close();
  }
}
