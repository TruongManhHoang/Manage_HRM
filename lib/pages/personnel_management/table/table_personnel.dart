// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import '../../../common/widgets/containers/rounded_container.dart';
import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../data/model/personnel_management.dart';
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
            delete: () {
              // TODO: define action
            },
            edit: () {
              // TODO: define action
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
