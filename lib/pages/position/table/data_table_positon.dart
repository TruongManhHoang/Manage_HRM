import 'package:admin_hrm/pages/contract/table/table_contract.dart';
import 'package:admin_hrm/pages/position/table/table_positon.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

import '../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../constants/sizes.dart';

class DataTablePositon extends StatelessWidget {
  const DataTablePositon({super.key});

  @override
  Widget build(BuildContext context) {
    return TPaginatedDataTable(
        minWidth: 700,
        tableHeight: 500,
        dataRowHeight: TSizes.xl * 1.2,
        columns: const [
          DataColumn2(label: Text('Order Id')),
          DataColumn2(label: Text(' Date')),
          DataColumn2(label: Text('Items')),
          DataColumn2(label: Text('Status')),
          DataColumn2(label: Text('Total')),
          DataColumn2(label: Text('Action')),
        ],
        source: TablePositionRows(context));
  }
}
