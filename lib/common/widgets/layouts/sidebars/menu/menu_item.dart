import 'package:admin_hrm/common/widgets/layouts/sidebars/bloc/sidebar_bloc.dart';
import 'package:admin_hrm/constants/colors.dart';
import 'package:admin_hrm/constants/device_utility.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

// class MenuItem extends StatelessWidget {
//   const MenuItem({super.key, required this.icon, required this.title, required this.router});
//
//   final IconData icon;
//   final String title;
//   final String router;
//
//   @override
//   Widget build(BuildContext context) {
//     final bloc = context.watch<SideBarBloc>();
//     final state = bloc.state;
//     final isActive = state.activeItem == router;
//     final isHover = state.hoverItem == router;
//     return InkWell(
//       onTap: () {
//         // context.read<SideBarBloc>().add(MenuOnTapEvent(menuItem: router));
//         if(!isActive) {
//          bloc.add(ChangeActiveItemEvent(route: router));
//
//           debugPrint('Navigating to: $router');
//           if(TDeviceUtils.isMobileScreen(context)){
//             Navigator.of(context).pop();
//           }
//
//
//           context.pushNamed(router);
//         }
//       },
//       onHover: (value) {
//         // context.read<SideBarBloc>().add(ChangeHoverItemEvent(hoverItem: value ? router : ''));
//         if(value) {
//           bloc.add(ChangeHoverItemEvent(route: router));
//         } else {
//           if(state.hoverItem == router) {
//             bloc.add(const ChangeHoverItemEvent(route: ''));
//           }
//         }
//       },
//       child:  Padding(
//         padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
//         child: Container(
//           decoration: BoxDecoration(
//             color: isActive || isHover ? TColors.primary : Colors.transparent,
//             borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
//           ),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(left: TSizes.lg,
//                     top: TSizes.md,
//                     bottom: TSizes.md,
//                     right: TSizes.md),
//                 child: isActive ? Icon(
//                   icon,
//                   color: TColors.white,
//                 )
//                     : Icon(
//                   icon,
//                   color: isHover ? TColors.white : TColors.darkGrey,
//                 ),
//               ),
//               if(isHover || isActive)
//                 Flexible(child: Text(title, style:Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),))
//               else
//                 Flexible(child: Text(title, style:Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.darkGrey),))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.router});

  final IconData icon;
  final String title;
  final String router;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SideBarBloc, SideBarState>(
      builder: (context, state) {
        final bloc = context.read<SideBarBloc>();
        return InkWell(
          onTap: () {
            context
                .read<SideBarBloc>()
                .add(MenuOnTapEvent(route: router, context: context));
          },
          onHover: (hovering) => hovering
              ? context
                  .read<SideBarBloc>()
                  .add(ChangeHoverItemEvent(route: router))
              : context
                  .read<SideBarBloc>()
                  .add(const ChangeHoverItemEvent(route: '')),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: TSizes.xs),
            child: Container(
              decoration: BoxDecoration(
                color: bloc.isHovering(router) || bloc.isActive(router)
                    ? TColors.primary
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(TSizes.cardRadiusMd),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: TSizes.lg,
                        top: TSizes.md,
                        bottom: TSizes.md,
                        right: TSizes.md),
                    child: bloc.isActive(router)
                        ? Icon(
                            icon,
                            color: TColors.white,
                          )
                        : Icon(
                            icon,
                            color: bloc.isHovering(router)
                                ? TColors.white
                                : TColors.darkGrey,
                          ),
                  ),
                  if (bloc.isHovering(router) || bloc.isActive(router))
                    Flexible(
                        child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.white),
                    ))
                  else
                    Flexible(
                        child: Text(
                      title,
                      style: Theme.of(context)
                          .textTheme
                          .bodyMedium!
                          .apply(color: TColors.darkGrey),
                    ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
