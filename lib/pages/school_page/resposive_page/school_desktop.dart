import 'package:admin_hrm/common/widgets/containers/rounded_container.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/pages/school_page/resposive_page/school_table.dart';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

import '../table/data_table.dart';

class SchoolDesktopPage extends StatelessWidget {
  const SchoolDesktopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
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
                  const SchoolTable(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
