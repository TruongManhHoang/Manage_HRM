import 'package:admin_hrm/common/widgets/containers/rounded_container.dart';
import 'package:admin_hrm/pages/dash_board/widgets/order_status_graph.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../table/data_table.dart';
import '../widgets/dash_board_card.dart';
import '../../../constants/sizes.dart';

class DashBoardTable extends StatelessWidget {
  const DashBoardTable({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Dashboard', style: Theme.of(context).textTheme.headlineLarge),
            const SizedBox(height: TSizes.spaceBtwSections),

            //Cards
            const Row(
              children: [
                Expanded(
                    child: TDashboardCard(
                        title: 'Sales', subtitle: '\$365.6', stats: 25)),
                Gap(TSizes.spaceBtwItems),
                Expanded(
                    child: TDashboardCard(
                        title: 'Total Revenue',
                        subtitle: '\$365.6',
                        stats: 25)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
