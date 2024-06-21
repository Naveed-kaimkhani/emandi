import 'package:e_mandi/domain/repositories/item_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:hive/hive.dart';

class HiveItemRepository extends ItemRepository{
  static const String _boxName = 'ItemsBox';

  @override
  Future<void> addItem(ItemModel item) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.add(item.toJson());
    await box.close();
    // print('Item added');
    
  }

  @override
  Future<List<ItemModel>> getAllItems() async {
    final box = await Hive.openBox<Map>(_boxName);
    final items = box.values
        .map((map) => ItemModel.fromJson(Map<String, dynamic>.from(map)))
        .toList();
    await box.close();
    return items;
  }

  @override
  Future<void> deleteItem(int index) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.deleteAt(index);
    await box.close();
  }

  @override
  Future<void> updateItem(int index, ItemModel item) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.putAt(index, item.toJson());
    await box.close();
  }
}