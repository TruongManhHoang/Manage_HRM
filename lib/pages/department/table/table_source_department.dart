import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/data/model/department/department_model.dart';
import 'package:admin_hrm/pages/department/bloc/department_bloc.dart';
import 'package:admin_hrm/pages/department/bloc/department_event.dart';
import 'package:admin_hrm/router/app_routers.dart';
import 'package:admin_hrm/router/routers_name.dart';

import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../constants/colors.dart';

import '../../../utils/helpers/helper_functions.dart';

class DepartmentTableRows extends DataTableSource {
  final BuildContext context;
  final List<DepartmentModel> departments;

  DepartmentTableRows(this.context, this.departments);

  @override
  DataRow? getRow(int index) {
    final department = departments[index];

    TextStyle baseStyle = Theme.of(context)
        .textTheme
        .bodyMedium!
        .copyWith(color: TColors.dark, fontSize: 12);

    TextStyle highlightStyle = baseStyle.copyWith(
      color: TColors.primary,
      fontWeight: FontWeight.w600,
    );

    return DataRow2(cells: [
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child:
            Center(child: Text(department.code ?? '-', style: highlightStyle)),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Center(child: Text(department.name, style: highlightStyle)),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Center(
            child: Text(department.managerName ?? '-', style: baseStyle)),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Center(
            child: Text(department.description ?? '-', style: baseStyle)),
      )),
      DataCell(
        Align(
          alignment: Alignment.center,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 6, vertical: TSizes.xs),
            decoration: BoxDecoration(
              color:
                  THelperFunctions.getDepartmentStatusColor(department.status)
                      .withOpacity(0.1),
              borderRadius: BorderRadius.circular(6),
            ),
            child: Text(
              department.status,
              style: baseStyle.copyWith(
                fontSize: 12,
                color: THelperFunctions.getDepartmentStatusColor(
                    department.status),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ),
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Center(
            child: Text(department.employeeCount.toString(), style: baseStyle)),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Center(child: Text(department.email ?? '-', style: baseStyle)),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Center(
            child: Text(department.phoneNumber ?? '-', style: baseStyle)),
      )),
      DataCell(Padding(
        padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                context.go(
                  RouterName.editDepartment,
                  extra: department,
                );
              },
              icon: const Icon(Icons.edit),
              color: TColors.primary,
            ),
            const SizedBox(width: TSizes.xs),
            IconButton(
              onPressed: () {
                _confirmDelete(context, department);
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
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => departments.length;

  @override
  int get selectedRowCount => 0;

  void _confirmDelete(BuildContext context, DepartmentModel department) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xoá'),
        content: Text(
            'Bạn có chắc chắn muốn xoá phòng ban "${department.name}" không?'),
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
                  .read<DepartmentBloc>()
                  .add(DeleteDepartment(department.id!));
            },
          ),
        ],
      ),
    );
  }
}
