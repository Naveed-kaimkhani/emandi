import 'package:e_mandi/domain/entities/ledger_model.dart';
import 'package:hive/hive.dart';

class LedgerRepository {
  static const String _boxName = 'LedgerBox';

  Future<void> addLedger(LedgerModel ledger) async {
    final box = await Hive.openBox<Map>(_boxName);
    await box.add(ledger.toJson());
    await box.close();
    print('ledger added');
  }

  Future<void> addLedgers(List<LedgerModel> ledgers) async {
    final box = await Hive.openBox<Map>(_boxName);
    for (var ledger in ledgers) {
      await box.add(ledger.toJson());
    }
    await box.close();
    print('ledgers added');
  }

  Future<List<LedgerModel>> getAllLedgers() async {
    final box = await Hive.openBox<LedgerModel>(_boxName);
    final ledgers = box.values.toList();
    await box.close();
    return ledgers;
  }

  Future<void> deleteLedger(int index) async {
    final box = await Hive.openBox<LedgerModel>(_boxName);
    await box.deleteAt(index);
    await box.close();
  }

  Future<void> updateLedger(int index, LedgerModel ledger) async {
    final box = await Hive.openBox<LedgerModel>(_boxName);
    await box.putAt(index, ledger);
    await box.close();
  }
}
