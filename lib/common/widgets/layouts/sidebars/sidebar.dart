import 'package:admin_hrm/common/widgets/images/t_circular_image.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/menu/menu_item.dart';
import 'package:admin_hrm/constants/colors.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/pages/auth/bloc/auth_bloc.dart';
import 'package:admin_hrm/pages/auth/bloc/auth_event.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

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
                      'Danh sách',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall!
                          .apply(letterSpacingDelta: 1.2),
                    ),

                    // Menu items
                    const MenuItem(
                        icon: Iconsax.element_3,
                        title: 'Tổng quan',
                        router: RouterName.dashboard),
                    const MenuItem(
                        icon: Iconsax.profile,
                        title: 'Nhân viên',
                        router: RouterName.employeePage),
                    const MenuItem(
                        icon: Iconsax.building_3,
                        title: 'Phòng ban',
                        router: RouterName.departmentPage),
                    const MenuItem(
                        icon: Iconsax.document_text,
                        title: 'Hợp đồng',
                        router: RouterName.contractPage),
                    const MenuItem(
                        icon: Iconsax.medal,
                        title: 'Chức vụ',
                        router: RouterName.positionPage),
                    const MenuItem(
                        icon: Iconsax.gift1,
                        title: 'Khen thưởng',
                        router: RouterName.rewardPage),
                    const MenuItem(
                        icon: Iconsax.shield_slash,
                        title: 'Kỷ luật',
                        router: RouterName.disciplinaryPage),
                    const MenuItem(
                        icon: Iconsax.wallet,
                        title: 'Lương',
                        router: RouterName.salaryPage),
                    const MenuItem(
                        icon: Iconsax.user,
                        title: 'Tài khoản',
                        router: RouterName.accountPage),
                    const Gap(TSizes.spaceBtwSections),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Icon(Iconsax.logout_1),
                          const Gap(TSizes.sm),
                          GestureDetector(
                            onTap: () {
                              context.read<AuthBloc>().add(LogoutRequested());

                              context.go(RouterName.login);
                            },
                            child: const Text(
                              'Đăng xuất',
                              style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
