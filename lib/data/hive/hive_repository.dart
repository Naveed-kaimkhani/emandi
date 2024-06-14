import 'package:e_mandi/domain/entities/bill_model.dart';
import 'package:hive/hive.dart';

class ItemRepository {
  static const String _boxName = 'ItemsBox';

  Future<void> addItem(ItemModel item) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.add(item.toJson());
    await box.close();
    print('Item added');
  }

  Future<List<ItemModel>> getAllItems() async {
    final box = await Hive.openBox<Map>(_boxName);
    final items = box.values
        .map((map) => ItemModel.fromJson(Map<String, dynamic>.from(map)))
        .toList();
    await box.close();
    return items;
  }

  Future<void> deleteItem(int index) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.deleteAt(index);
    await box.close();
  }

  Future<void> updateItem(int index, ItemModel item) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.putAt(index, item.toJson());
    await box.close();
  }
}
