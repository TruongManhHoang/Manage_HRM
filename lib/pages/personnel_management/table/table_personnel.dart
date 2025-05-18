// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_hrm/di/locator.dart';
import 'package:admin_hrm/local/hive_storage.dart';
import 'package:admin_hrm/utils/helpers/helper_functions.dart';
import 'package:admin_hrm/utils/popups/dialogs.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../data/model/personnel_management.dart';
import '../../../router/routers_name.dart';
import '../bloc/persional_bloc.dart';
import '../widgets/other_functions.dart';

class TableEmployeeRows extends DataTableSource {
  final BuildContext context;
  final List<PersionalManagement> personnel;

  TableEmployeeRows(this.context, this.personnel);

  @override
  DataRow? getRow(int index) {
    TextStyle baseStyle = Theme.of(context).textTheme.bodyLarge!.copyWith(
          color: TColors.dark,
          fontWeight: FontWeight.w500,
        );
    final globalStorage = getIt<GlobalStorage>();
    final personalManagers = globalStorage.positions!;
    final position = personalManagers.firstWhere(
      (p) => p.id == personnel[index].positionId,
    );
    final department = globalStorage.departments!
        .firstWhere((d) => d.id == personnel[index].departmentId);
    final dateFormat = DateFormat('dd/MM/yyyy');
    if (index >= personnel.length) return null;
    final employee = personnel[index];

    return DataRow2(
      specificRowHeight: 100,
      cells: [
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(
              '${index + 1}',
              style: baseStyle,
            ),
          ),
        )),
        DataCell(Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
            child: Text(employee.code!, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(employee.name, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(
              employee.gender,
              style: baseStyle,
            ),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(employee.dateOfBirth, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(employee.phone, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(employee.email, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(employee.address, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(position.name!, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(department.name!, style: baseStyle),
          ),
        )),
        DataCell(Padding(
          padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
          child: Center(
            child: Text(employee.date, style: baseStyle),
          ),
        )),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.xs,
              horizontal: TSizes.md,
            ),
            child: Text(
              employee.status.toString(),
              style: baseStyle.copyWith(
                color:
                    THelperFunctions.getContractStatusColor(employee.status!),
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
                  context.go(RouterName.updateEmployee, extra: employee);
                },
                icon: const Icon(Icons.edit),
                color: TColors.primary,
              ),
              const SizedBox(width: TSizes.xs),
              IconButton(
                onPressed: () {
                  _confirmDelete(context, employee);
                },
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
        )),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => personnel.length;

  @override
  int get selectedRowCount => 0;

  void _confirmDelete(
      BuildContext context, PersionalManagement personnelManagement) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xoá'),
        content: Text(
            'Bạn có chắc chắn muốn xoá nhân viên "${personnelManagement.name}" không?'),
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
                  .read<PersionalBloc>()
                  .add(PersionalDeleteEvent(personnelManagement.id!));
            },
          ),
        ],
      ),
    );
  }
}
