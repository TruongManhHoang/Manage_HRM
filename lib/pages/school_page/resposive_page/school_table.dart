import 'package:admin_hrm/constants/sizes.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../../../common/widgets/containers/rounded_container.dart';
import '../table/data_table.dart';

class SchoolTablePage extends StatelessWidget {
  const SchoolTablePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TRoundedContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Recent Order',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    const Gap(TSizes.spaceBtwSections),
                    const SchoolTable()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
