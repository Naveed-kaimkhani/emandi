import 'package:e_mandi/domain/repositories/item_repository.dart';
import 'package:e_mandi/main.dart';
import 'package:e_mandi/presentation/billing/create_bill_for_user.dart';
import 'package:e_mandi/utils/custom_loader.dart';
import 'package:e_mandi/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';
import 'package:e_mandi/style/styling.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:e_mandi/domain/entities/item_model.dart';

class CreateBillFromInitialList extends StatefulWidget {
  final ItemRepository itemRepository;
  const CreateBillFromInitialList({super.key, required this.itemRepository});

  @override
  _CreateBillFromInitialListState createState() =>
      _CreateBillFromInitialListState();
}

class _CreateBillFromInitialListState extends State<CreateBillFromInitialList> {
  late Future<List<ItemModel>> _itemsFuture;

  @override
  void initState() {
    super.initState();
    _itemsFuture = widget.itemRepository.getAllItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Styling.primaryColor,
        centerTitle: true,
        title: Text(
          AppLocalizations.of(context)!.createFromInitialList,
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder<List<ItemModel>>(
          future: _itemsFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CustomLoader());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text(AppLocalizations.of(context)!.noData));
            } else {
              final items = snapshot.data!;
              return LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minWidth: constraints.maxWidth),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: DataTable(
                          columnSpacing: 20.0,
                          columns: [
                            const DataColumn(
                              label: Text(
                                '#',
                                style: TextStyle(
                                    fontSize:
                                        24.0), // Adjust column header size
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                AppLocalizations.of(context)!.name,
                                style: const TextStyle(
                                    fontSize:
                                        24.0), // Adjust column header size
                              ),
                            ),
                          ],
                          rows: List<DataRow>.generate(
                            items.length,
                            (index) => DataRow(
                              cells: [
                                DataCell(
                                  Text(
                                    '${index + 1}', // Row number
                                    style: const TextStyle(
                                        fontSize:
                                            24.0), // Adjust cell text size
                                  ),
                                ),
                                DataCell(
                                  InkWell(
                                    child: Text(
                                      items[index].name, // Display the username
                                      style: const TextStyle(
                                          fontSize:
                                              24.0), // Adjust cell text size
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                CreateBillForAUser(
                                                  billingRepository: getIt(),
                                                  name: items[index].name,
                                                )),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          dataRowHeight:
                              80, // Height of each row to add spacing
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
