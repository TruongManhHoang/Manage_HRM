import 'package:admin_hrm/common/widgets/containers/rounded_container.dart';
import 'package:admin_hrm/data/model/contract/contract_model.dart';
import 'package:admin_hrm/data/model/personnel_management.dart';
import 'package:admin_hrm/di/locator.dart';
import 'package:admin_hrm/local/hive_storage.dart';
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
    final globalStorage = getIt<GlobalStorage>();

    final contract = contracts[index];
    final personalManagers = globalStorage.personalManagers!;

    // 🔍 Tìm user theo employeeId
    final personal = personalManagers.firstWhere(
      (p) => p.id == contract.employeeId,
    );

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
        Center(child: Text(personal.name)),
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
        Align(
          alignment: Alignment.center,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: TSizes.xs),
            decoration: BoxDecoration(
              color: THelperFunctions.getContractStatusColor(contract.status!)
                  .withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              contract.status!,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    fontSize: 12,
                    color: THelperFunctions.getContractStatusColor(
                        contract.status!),
                    fontWeight: FontWeight.w500,
                  ),
            ),
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
