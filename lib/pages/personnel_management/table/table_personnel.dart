// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:admin_hrm/utils/popups/dialogs.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../data/model/personnel_management.dart';
import '../../../router/routers_name.dart';
import '../bloc/personnel_bloc.dart';
import '../widgets/other_functions.dart';

class TableEmployeeRows extends DataTableSource {
  final BuildContext context;
  final List<PersonnelManagement> personnel;

  TableEmployeeRows(this.context, this.personnel);

  @override
  DataRow? getRow(int index) {
    if (index >= personnel.length) return null;
    final employee = personnel[index];

    return DataRow2(
      specificRowHeight: 100,
      cells: [
        DataCell(Text(
          employee.id.toString(),
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.primary),
        )),
        DataCell(Text(
          employee.name,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.textPrimary),
        )),
        DataCell(Text(
          employee.gender,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.primary),
        )),
        DataCell(Text(
          employee.phone,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.textPrimary),
        )),
        DataCell(Text(employee.position.toString())),
        DataCell(Text(employee.date.toString())),
        DataCell(
          TRoundedContainer(
            radius: TSizes.cardRadiusSm,
            padding: const EdgeInsets.symmetric(
              vertical: TSizes.xs,
              horizontal: TSizes.md,
            ),
            child: Text(
              employee.status.toString(),
            ),
          ),
        ),
        DataCell(
          OtherFunctions(
            collaborate: () {
              // TODO: define action
            },
            delete: () => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Xóa nhân viên'),
                content: const Text(
                    'Bạn có chắc chắn muốn xóa nhân viên này không?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Hủy'),
                  ),
                  TextButton(
                    onPressed: () {
                      if (employee.id == null) {
                        return;
                      }
                      context.read<PersonelCubit>().deleteEmployee(
                            employee.id ?? '',
                            context,
                          );
                      Navigator.pop(context);
                    },
                    child: const Text('Xóa'),
                  ),
                ],
              ),
            ),
            edit: () {
              context.push(
                RouterName.updateEmployee,
                extra: employee,
              );
            },
          ),
        ),
      ],
    );
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => personnel.length;

  @override
  int get selectedRowCount => 0;
}
