import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/common/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:admin_hrm/common/widgets/layouts/headers/headers.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:admin_hrm/common/widgets/text_form/text_form_field.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddDepartmentPage extends StatelessWidget {
  const AddDepartmentPage({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController nameDepartmentController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController employeeIdController = TextEditingController();

    final List<String> employee = [
      '001',
      '002',
      '003',
    ];
    return Scaffold(
      body: Row(
        children: [
          Expanded(
            child: Sidebar(),
          ),
          Expanded(
            flex: 5,
            child: Column(
              children: [
                const Header(),
                Expanded(
                  child: Container(
                    height: MediaQuery.of(context).size.height,
                    color: Colors.grey[200],
                    padding: EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          const TBreadcrumsWithHeading(
                            heading: 'Phòng Ban',
                            breadcrumbItems: [
                              RouterName.addDepartment,
                            ],
                          ),
                          Container(
                              width: 600,
                              padding:
                                  const EdgeInsets.all(TSizes.defaultSpace),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                              ),
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  Form(
                                      key: GlobalKey<FormState>(),
                                      child: Column(
                                        children: [
                                          TDropDownMenu(
                                              menus: employee,
                                              text: 'Mã Nhân viên:',
                                              controller: employeeIdController),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Tên phòng ban',
                                            hint: 'Nhập tên phòng ban',
                                            controller:
                                                nameDepartmentController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Số điện thoại',
                                            hint: 'Nhập số điện thoại',
                                            controller: phoneController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Ngày địa chỉ',
                                            hint: 'Nhập ngày địa chỉ',
                                            controller: addressController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TextButton(
                                              style: TextButton.styleFrom(
                                                  backgroundColor: Colors.blue,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal:
                                                          TSizes.defaultSpace *
                                                              2,
                                                      vertical: 16)),
                                              onPressed: () {
                                                // Handle form submission
                                                if (GlobalKey<FormState>()
                                                    .currentState!
                                                    .validate()) {
                                                  // Process data
                                                  context
                                                      .go(RouterName.dashboard);
                                                }
                                              },
                                              child: Text(
                                                'Thêm phòng ban',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                        color: Colors.white),
                                              )),
                                        ],
                                      ))
                                ],
                              )),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
