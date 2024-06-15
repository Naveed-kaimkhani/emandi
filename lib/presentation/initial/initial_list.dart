import 'package:flutter/material.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/data/hive/item_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitialList extends StatefulWidget {
  const InitialList({super.key});

  @override
  _InitialListState createState() => _InitialListState();
}

class _InitialListState extends State<InitialList> {
  final ItemRepository _ItemRepository = ItemRepository();
  late Future<List<ItemModel>> _billsFuture;

  @override
  void initState() {
    super.initState();
    _billsFuture = _ItemRepository.getAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.initialItemList,
          style: const TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      backgroundColor: Styling.textfieldsColor,
      body: FutureBuilder<List<ItemModel>>(
        future: _billsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: const Text("No data"));
          } else {
            final bills = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: [
                    DataColumn(
                        label: Text(
                      AppLocalizations.of(context)!.name,
                    )),
                    DataColumn(
                      label: Text(AppLocalizations.of(context)!.itemName),
                    ),
                    DataColumn(
                        label: Text(AppLocalizations.of(context)!.itemContainer)),
                    DataColumn(label: Text(AppLocalizations.of(context)!.itemCount)),
                  ],
                  rows: bills.map((bill) {
                    return DataRow(
                      cells: [
                        DataCell(Text(bill.name)),
                        DataCell(Text(bill.selectedItem)),
                        
                        DataCell(Text(bill.selectedContainer)),
                        DataCell(Text(bill.itemCount.toString())),
                       
                      ],
                    );
                  }).toList(),
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
