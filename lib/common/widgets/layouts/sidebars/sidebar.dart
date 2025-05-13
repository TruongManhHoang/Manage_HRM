import 'package:admin_hrm/common/widgets/images/t_circular_image.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:admin_hrm/constants/colors.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/pages/dash_board/dash_board.dart';
import 'package:admin_hrm/pages/dash_board/hello.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:iconsax/iconsax.dart';

import 'custom_sidebar.dart';

class Sidebar extends StatelessWidget {
  const Sidebar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      shape: const BeveledRectangleBorder(),
      child: Container(
        decoration: const BoxDecoration(
          color: TColors.white,
          border: Border(right: BorderSide(color: TColors.grey, width: 1)),
        ),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const TCircularImage(
                width: 100,
                height: 100,
                image: 'assets/images/user.png',
                backgroundColor: Colors.transparent,
              ),
              const Gap(TSizes.spaceBtwSections),
              Padding(
                padding: const EdgeInsets.all(TSizes.md),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Menu',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),

                    // Menu items
                    const MenuItem(
                        icon: Iconsax.music_dashboard,
                        title: 'DashBoard',
                        router: RouterName.dashboard),
                    const MenuItem(
                        icon: Iconsax.home3,
                        title: 'Department',
                        router: RouterName.departmentPage),
                    const MenuItem(
                        icon: Iconsax.home1,
                        title: 'Employee',
                        router: RouterName.employeePage),
                    const MenuItem(
                        icon: Iconsax.home_1,
                        title: 'Contract',
                        router: RouterName.contractPage),
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
