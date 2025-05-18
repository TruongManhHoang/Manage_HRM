import 'package:admin_hrm/pages/reward/bloc/reward_bloc.dart';
import 'package:admin_hrm/pages/reward/bloc/reward_event.dart';
import 'package:admin_hrm/pages/reward/bloc/reward_state.dart';
import 'package:admin_hrm/pages/reward/table/table_source_reward.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../common/widgets/data_table/paginated_data_table.dart';
import '../../../constants/sizes.dart';

class DataTableReward extends StatefulWidget {
  const DataTableReward({super.key});

  @override
  State<DataTableReward> createState() => _DataTableRewardState();
}

class _DataTableRewardState extends State<DataTableReward> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // BlocProvider.of<RewardBloc>(context).add(LoadRewards());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RewardBloc, RewardState>(
      builder: (context, state) {
        if (state is RewardLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RewardLoaded) {
          return TPaginatedDataTable(
            minWidth: 700,
            tableHeight: 500,
            dataRowHeight: TSizes.xl * 1.45,
            columns: const [
              DataColumn2(
                label: Center(
                  child: Text(
                    'Mã khen thưởng',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataColumn2(
                label: Center(
                  child: Text(
                    'Nhân viên',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataColumn2(
                label: Center(
                  child: Text(
                    'Loại khen thưởng',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataColumn2(
                label: Center(
                  child: Text(
                    'Lý do',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataColumn2(
                label: Center(
                  child: Text(
                    'Giá trị',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataColumn2(
                label: Center(
                  child: Text(
                    'Người phê duyệt',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              DataColumn2(
                label: Center(
                  child: Text(
                    'Trạng thái',
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
            source: RewardTableRows(
              context,
              state.rewards,
            ),
          );
        } else if (state is RewardError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else {
          return const Center(child: Text('No data available'));
        }
      },
    );
  }
}
