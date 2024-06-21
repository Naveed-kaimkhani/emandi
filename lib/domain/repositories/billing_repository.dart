import 'package:e_mandi/domain/entities/item_model.dart';

abstract class BillingRepository {
  Future<void> addBill(List<ItemModel> items);

  Future<List<ItemModel>> getAllBillings();
  Future<void> deleteBilling(int index);

  Future<void> updateBilling(int index, ItemModel billing);
}