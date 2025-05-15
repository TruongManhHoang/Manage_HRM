import 'package:admin_hrm/data/model/contract/contract_model.dart';
import 'package:admin_hrm/pages/contract/bloc/contract_bloc.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TableContractRows extends DataTableSource {
  final BuildContext context;
  TableContractRows({required this.context, required this.contracts});
  List<ContractModel> contracts;

  @override
  DataRow? getRow(int index) {
    final contract = contracts[index];
    return DataRow2(cells: [
      DataCell(Center(
        child: Text(
          contract.contractCode!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.primary),
        ),
      )),
      DataCell(
        Center(child: Text(contract.employeeId!)),
      ),
      DataCell(
        Center(child: Text(contract.contractType!)),
      ),
      DataCell(
        Center(child: Text(NumberFormat('#,###').format(contract.salary))),
      ),
      DataCell(
        Center(child: Text(contract.description)),
      ),
      DataCell(
        Center(
          child: Text(
            THelperFunctions.getFormattedDate(contract.startDate!),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            THelperFunctions.getFormattedDate(contract.endDate!),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            THelperFunctions.getFormattedDate(contract.createdAt!),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            THelperFunctions.getFormattedDate(contract.updatedAt!),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      DataCell(Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.go(RouterName.editContract, extra: contract);
              },
              icon: const Icon(Icons.edit),
              color: TColors.primary,
            ),
            const SizedBox(width: TSizes.xs),
            IconButton(
              onPressed: () {
                _confirmDelete(context, contract);
              },
              icon: const Icon(Icons.delete),
              color: Colors.red,
            ),
          ],
        ),
      ))
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;

  @override
  // TODO: implement rowCount
  int get rowCount => contracts.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

  void _confirmDelete(BuildContext context, ContractModel contractModel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xoá'),
        content: Text(
            'Bạn có chắc chắn muốn xoá hợp đồng "${contractModel.contractCode}" không?'),
        actions: [
          TextButton(
            child: const Text('Huỷ'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          TextButton(
            child: const Text('Xoá', style: TextStyle(color: Colors.red)),
            onPressed: () {
              Navigator.of(ctx).pop();
              context
                  .read<ContractBloc>()
                  .add(DeleteContract(contractModel.id!));
            },
          ),
        ],
      ),
    );
  }
}
