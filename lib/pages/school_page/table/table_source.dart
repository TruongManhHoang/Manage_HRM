import 'package:admin_hrm/common/widgets/containers/rounded_container.dart';
import 'package:admin_hrm/constants/colors.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/utils/helpers/helper_functions.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../data/model/order_model.dart';

class SchoolOrderRows extends DataTableSource {
  final BuildContext context;
  SchoolOrderRows(this.context);
  @override
  DataRow? getRow(int index) {
    final order = OrderData.orders[index];
    return DataRow2(cells: [
      DataCell(Text(
        order.id,
        style: Theme.of(context)
            .textTheme
            .bodyLarge!
            .copyWith(color: TColors.primary),
      )),
      DataCell(Text(order.formattedOrderDate)),
      const DataCell(Text('5 item')),
      DataCell(TRoundedContainer(
        radius: TSizes.cardRadiusSm,
        padding: const EdgeInsets.symmetric(
            vertical: TSizes.xs, horizontal: TSizes.md),
        backgroundColor:
            THelperFunctions.getOrderStatusColor(order.status).withOpacity(0.1),
        child: Text(
          order.status.name.toString(),
          style: TextStyle(
              color: THelperFunctions.getOrderStatusColor(order.status)),
        ),
      )),
      DataCell(Text('\$ ${order.totalAmount.toStringAsFixed(2)}')),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => OrderData.orders.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
