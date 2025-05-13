import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/common/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:admin_hrm/common/widgets/layouts/headers/headers.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:admin_hrm/common/widgets/text_form/text_form_field.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/pages/login/resposive_page/login_view.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class AddEmployee extends StatelessWidget {
  const AddEmployee({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController fullNameController = TextEditingController();
    TextEditingController genderController = TextEditingController();
    TextEditingController positionController = TextEditingController();
    TextEditingController departmentController = TextEditingController();
    TextEditingController phoneController = TextEditingController();
    TextEditingController emailController = TextEditingController();
    TextEditingController addressController = TextEditingController();
    TextEditingController experienceController = TextEditingController();
    TextEditingController educationLevelController = TextEditingController();
    TextEditingController birthDateController = TextEditingController();

    final List<String> positions = ['Nhân viên', 'Quản lý', 'Trưởng phòng'];
    final List<String> departments = ['Phòng nhân sự', 'Phòng kế toán'];
    final List<String> educationLevels = ['Cao đẳng', 'Đại học', 'Sau đại học'];

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
                            heading: 'Nhân viên',
                            breadcrumbItems: [
                              RouterName.addEmployee,
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
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Tài khoản',
                                            hint: 'Nhập tên tài khoản',
                                            controller: usernameController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Mật khẩu',
                                            hint: 'Nhập mật khẩu',
                                            controller: passwordController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Mật khẩu nhập lại',
                                            hint: 'Nhập mật khẩu nhập lại',
                                            controller: passwordController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TDropDownMenu(
                                              menus: [
                                                'Nam',
                                                'Nữ',
                                              ],
                                              controller: genderController,
                                              text: 'Giới tính'),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Họ tên',
                                            hint: 'Nhập họ tên',
                                            controller: fullNameController,
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
                                                birthDateController.text =
                                                    formattedDate;
                                              }
                                            },
                                            child: AbsorbPointer(
                                              child: TTextFormField(
                                                textAlign: true,
                                                text: 'Ngày sinh',
                                                hint: 'Chọn ngày sinh',
                                                controller: birthDateController,
                                              ),
                                            ),
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TDropDownMenu(
                                              menus: positions,
                                              controller: positionController,
                                              text: 'Chức vụ'),
                                          const Gap(TSizes.spaceBtwItems),
                                          TDropDownMenu(
                                              menus: departments,
                                              controller: departmentController,
                                              text: 'Phòng ban'),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Địa chỉ',
                                            hint: 'Nhập địa chỉ',
                                            controller: addressController,
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
                                            text: 'Email',
                                            hint: 'Nhập email',
                                            controller: emailController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TTextFormField(
                                            textAlign: true,
                                            text: 'Kinh nghiệm',
                                            hint: 'Nhập kinh nghiệm',
                                            controller: experienceController,
                                          ),
                                          const Gap(TSizes.spaceBtwItems),
                                          TDropDownMenu(
                                              menus: educationLevels,
                                              controller:
                                                  educationLevelController,
                                              text: 'Trình độ'),
                                          const Gap(TSizes.spaceBtwSections),
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
                                                'Thêm nhân viên',
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
