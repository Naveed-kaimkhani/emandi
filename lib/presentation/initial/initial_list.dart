import 'package:e_mandi/utils/custom_loader.dart';
import 'package:flutter/material.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:e_mandi/domain/repositories/item_repository.dart';
import 'package:e_mandi/domain/entities/item_model.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class InitialList extends StatefulWidget {
  final ItemRepository itemRepository;
  const InitialList({super.key, required this.itemRepository});

  @override
  _InitialListState createState() => _InitialListState();
}

class _InitialListState extends State<InitialList> {
  late Future<List<ItemModel>> _billsFuture;

  @override
  void initState() {
    super.initState();
    _billsFuture = widget.itemRepository.getAllItems();
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
            return Center(child: CustomLoader());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text(AppLocalizations.of(context)!.noData));
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
                        label:
                            Text(AppLocalizations.of(context)!.itemContainer)),
                    DataColumn(
                        label: Text(AppLocalizations.of(context)!.itemCount)),
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
