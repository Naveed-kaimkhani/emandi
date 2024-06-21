import 'package:e_mandi/domain/entities/ledger_model.dart';

abstract class LedgerRepository {
 
  Future<void> addLedger(LedgerModel ledger);
  Future<void> addLedgers(List<LedgerModel> ledgers);
  Future<List<LedgerModel>> getAllLedgers();
  Future<void> deleteLedger(int index);
  Future<void> updateLedger(int index, LedgerModel ledger);
}