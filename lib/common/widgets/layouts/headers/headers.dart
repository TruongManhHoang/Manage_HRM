import 'package:admin_hrm/common/widgets/images/t_rounded_image.dart';
import 'package:admin_hrm/constants/colors.dart';
import 'package:admin_hrm/constants/device_utility.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/local/storage.dart';
import 'package:admin_hrm/utils/enum/enum.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';

class Header extends StatefulWidget implements PreferredSizeWidget {
  const Header({super.key, this.scaffoldKey});
  final GlobalKey<ScaffoldState>? scaffoldKey;

  @override
  State<Header> createState() => _HeaderState();

  @override
  Size get preferredSize =>
      Size.fromHeight(TDeviceUtils.getAppBarHeight() + 15);
}

class _HeaderState extends State<Header> {
  String? displayName = '---';
  String? email = '---';

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    final user = await StorageLocal.getUser();
    if (user != null) {
      setState(() {
        displayName = user.displayName;
        email = user.email;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(bottom: BorderSide(color: TColors.grey, width: 1))),
      padding: const EdgeInsets.symmetric(
          horizontal: TSizes.md, vertical: TSizes.sm),
      child: AppBar(
        leading: !TDeviceUtils.isDesktopScreen(context)
            ? IconButton(
                onPressed: () => widget.scaffoldKey?.currentState?.openDrawer(),
                icon: const Icon(Iconsax.menu))
            : null,
        title: TDeviceUtils.isDesktopScreen(context)
            ? SizedBox(
                width: 400,
                child: TextFormField(
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Iconsax.search_normal),
                    hintText: 'Search anything...',
                  ),
                ),
              )
            : null,
        actions: [
          //Search bar for mobile and tablet
          if (!TDeviceUtils.isDesktopScreen(context))
            IconButton(
                onPressed: () {}, icon: const Icon(Iconsax.search_normal)),
          //Notification icon
          IconButton(onPressed: () {}, icon: const Icon(Iconsax.notification)),
          const SizedBox(
            width: TSizes.spaceBtwItems / 2,
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TRoundedImage(
                width: 40,
                height: 40,
                padding: 2,
                imageType: ImageType.asset,
                image: 'assets/images/user.png',
              ),
              const SizedBox(
                width: TSizes.sm,
              ),
              if (!TDeviceUtils.isMobileScreen(context))
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      displayName ?? '',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    Text(
                      email ?? '',
                      style: Theme.of(context).textTheme.labelMedium,
                    )
                  ],
                )
            ],
          )
        ],
      ),
    );
  }
}
