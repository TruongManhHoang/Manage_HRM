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

class AddContract extends StatelessWidget {
  const AddContract({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController contractTypeController = TextEditingController();
    TextEditingController startDateController = TextEditingController();
    TextEditingController endDateController = TextEditingController();
    TextEditingController employeeController = TextEditingController();

    final List<String> contractType = [
      'Chính thức',
      'Thử việc',
    ];
    final List<String> employee = [
      'Nguyễn Văn A',
      'Nguyễn Văn B',
      'Nguyễn Văn C',
    ];
    // final List<String> departments = ['Phòng nhân sự', 'Phòng kế toán'];
    // final List<String> educationLevels = ['Cao đẳng', 'Đại học', 'Sau đại học'];

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
                            heading: 'Hợp đồng',
                            breadcrumbItems: [
                              RouterName.addContract,
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
                                              text: 'Nhân viên:',
                                              controller: employeeController),
                                          const Gap(TSizes.spaceBtwItems),
                                          TDropDownMenu(
                                              menus: contractType,
                                              controller:
                                                  contractTypeController,
                                              text: 'Loại hợp đồng'),
                                          const Gap(TSizes.spaceBtwItems),
                                          GestureDetector(
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                                startDateController.text =
                                                    formattedDate;
                                              }
                                            },
                                            child: AbsorbPointer(
                                              child: TTextFormField(
                                                textAlign: true,
                                                text: 'Ngày băt đầu',
                                                hint: 'Chọn ngày bắt đầu',
                                                controller: startDateController,
                                              ),
                                            ),
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          GestureDetector(
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                context: context,
                                                initialDate: DateTime.now(),
                                                firstDate: DateTime(1900),
                                                lastDate: DateTime.now(),
                                              );
                                              if (pickedDate != null) {
                                                String formattedDate =
                                                    "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
                                                startDateController.text =
                                                    formattedDate;
                                              }
                                            },
                                            child: AbsorbPointer(
                                              child: TTextFormField(
                                                textAlign: true,
                                                text: 'Ngày kết thúc',
                                                hint: 'Chọn ngày kết thúc',
                                                controller: endDateController,
                                              ),
                                            ),
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
                                                'Thêm hợp đồng',
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
