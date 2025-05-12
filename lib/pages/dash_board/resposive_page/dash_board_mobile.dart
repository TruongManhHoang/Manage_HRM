import 'package:admin_hrm/constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../table/data_table.dart';
import '../widgets/dash_board_card.dart';
import '../widgets/order_status_graph.dart';
import '../widgets/weekly_sales.dart';

class DashBoardMobilePage extends StatelessWidget {
  const DashBoardMobilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Dashboard',
                  style: Theme.of(context).textTheme.headlineLarge),
              const SizedBox(height: TSizes.spaceBtwSections),

              //Cards
              const TDashboardCard(
                  title: 'Sales', subtitle: '\$365.6', stats: 25),
              const Gap(TSizes.spaceBtwItems),
              const TDashboardCard(
                  title: 'Total Revenue', subtitle: '\$365.6', stats: 25),
              const Gap(TSizes.spaceBtwItems),
              const TDashboardCard(
                  title: 'Total Expenses', subtitle: '\$365.6', stats: 25),
              const Gap(TSizes.spaceBtwItems),
              const TDashboardCard(
                  title: 'Total Profit', subtitle: '\$365.6', stats: 25),

              const Gap(TSizes.spaceBtwSections),

            ],
          ),
        ),
      ),
    );
  }
}
