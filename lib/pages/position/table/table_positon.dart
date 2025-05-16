import 'package:admin_hrm/data/model/position/position_model.dart';
import 'package:admin_hrm/pages/position/bloc/position_bloc.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';
import '../../../utils/helpers/helper_functions.dart';

class TablePositionRows extends DataTableSource {
  final BuildContext context;
  TablePositionRows({required this.context, required this.positions});
  List<PositionModel> positions;
  @override
  DataRow? getRow(int index) {
    final position = positions[index];
    return DataRow2(cells: [
      DataCell(Center(
        child: Text(
          position.code!,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: TColors.primary),
        ),
      )),
      DataCell(
        Center(child: Text(position.positionType!)),
      ),
      DataCell(
        Center(child: Text(position.name!)),
      ),
      DataCell(
        Center(child: Text('${position.positionSalary}')),
      ),
      DataCell(
        Center(child: Text('${position.description}')),
      ),
      DataCell(
        Center(
          child: Text(
            THelperFunctions.getFormattedDate(position.createdAt!),
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ),
      DataCell(
        Center(
          child: Text(
            THelperFunctions.getFormattedDate(position.updatedAt!),
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
                context.go(RouterName.editPosition, extra: position);
              },
              icon: const Icon(Icons.edit),
              color: TColors.primary,
            ),
            const SizedBox(width: TSizes.xs),
            IconButton(
              onPressed: () {
                _confirmDelete(context, position);
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
  int get rowCount => positions.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;

  void _confirmDelete(BuildContext context, PositionModel positionModel) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xoá'),
        content: Text(
            'Bạn có chắc chắn muốn xoá phòng ban "${positionModel.name}" không?'),
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
                  .read<PositionBloc>()
                  .add(DeletePosition(positionModel.id!));
            },
          ),
        ],
      ),
    );
  }
}
