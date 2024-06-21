
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:hive/hive.dart';

abstract class ItemRepository {

  Future<void> addItem(ItemModel item);
  Future<List<ItemModel>> getAllItems();
  Future<void> deleteItem(int index);
  Future<void> updateItem(int index, ItemModel item);
}

