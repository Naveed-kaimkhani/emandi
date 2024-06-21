import 'package:e_mandi/domain/repositories/billing_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:hive/hive.dart';

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
