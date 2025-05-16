// ignore_for_file: public_member_api_docs, sort_constructors_first
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
    final dateFormat = DateFormat('dd/MM/yyyy');
    if (index >= personnel.length) return null;
    final employee = personnel[index];

    return DataRow2(
      specificRowHeight: 100,
      cells: [
        DataCell(Text(
          employee.code!,
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
        DataCell(Text(employee.positionId.toString())),
        DataCell(Text(employee.date.toString())),
        DataCell(Text(dateFormat.format(employee.createdAt!))),
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
        )
            // OtherFunctions(
            //   collaborate: () {},
            //   delete: () => showDialog(
            //     context: context,
            //     builder: (dialogContext) => Builder(
            //       builder: (newContext) => AlertDialog(
            //         title: const Text('Xóa nhân viên'),
            //         content: const Text(
            //             'Bạn có chắc chắn muốn xóa nhân viên này không?'),
            //         actions: [
            //           TextButton(
            //             onPressed: () => Navigator.pop(dialogContext),
            //             child: const Text('Hủy'),
            //           ),
            //           TextButton(
            //             onPressed: () {
            //               if (employee.id == null) return;

            //               newContext
            //                   .read<PersionalBloc>()
            //                   .add(PersionalDeleteEvent(
            //                     employee.id!,
            //                   ));
            //               Navigator.pop(dialogContext);
            //             },
            //             child: const Text('Xóa'),
            //           ),
            //         ],
            //       ),
            //     ),
            //   ),
            //   edit: () {
            //     context.push(
            //       RouterName.updateEmployee,
            //       extra: employee,
            //     );
            //   },
            // ),
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
