import 'package:e_mandi/domain/repositories/ledger_repository.dart';
import 'package:e_mandi/domain/entities/ledger_model.dart';
import 'package:hive/hive.dart';

class HiveLedgerRepository extends LedgerRepository {
    static const String _boxName = 'LedgerBox';

  @override
  Future<void> addLedger(LedgerModel ledger) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.add(ledger.toJson());
    await box.close();
  }

  @override
  Future<void> addLedgers(List<LedgerModel> ledgers) async {
    final box = await Hive.openBox<Map>(_boxName);
    for (var ledger in ledgers) {
      await box.add(ledger.toJson());
    }
    await box.close();
  }

  @override
  Future<List<LedgerModel>> getAllLedgers() async {
    final box = await Hive.openBox<Map>(_boxName);
    final items = box.values
        .map((map) => LedgerModel.fromJson(Map<String, dynamic>.from(map)))
        .toList();
    await box.close();
    return items;
  }

  @override
  Future<void> deleteLedger(int index) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.deleteAt(index);
    await box.close();
  }

  @override
  Future<void> updateLedger(int index, LedgerModel ledger) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.putAt(index, ledger.toJson());
    await box.close();
  }
}
