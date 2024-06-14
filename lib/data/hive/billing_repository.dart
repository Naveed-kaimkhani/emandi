import 'package:e_mandi/domain/entities/bill_model.dart';
import 'package:hive/hive.dart';

class BillingRepository {
  static const String _boxName = 'BillingBox';

  Future<void> addBilling(ItemModel billing) async {
    final box = await Hive.openBox<ItemModel>(_boxName);
    await box.add(billing);
    await box.close();
    print('Billing added');
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
