import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/common/widgets/drop_down_menu/drop_down_menu.dart';
import 'package:admin_hrm/common/widgets/layouts/headers/headers.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:admin_hrm/common/widgets/text_form/text_form_field.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../../data/model/personnel_management.dart';
import '../../../service/personnel_service.dart';
import '../bloc/personnel_bloc.dart';
import '../bloc/personnel_state.dart';

class AddEmployeeForm extends StatelessWidget {
  const AddEmployeeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final fullNameController = TextEditingController();
    final genderController = TextEditingController();
    final positionController = TextEditingController();
    final departmentController = TextEditingController();
    final phoneController = TextEditingController();
    final emailController = TextEditingController();
    final addressController = TextEditingController();
    final experienceController = TextEditingController();
    final educationLevelController = TextEditingController();
    final birthDateController = TextEditingController();

    final positions = ['Nhân viên', 'Quản lý', 'Trưởng phòng'];
    final departments = ['Phòng nhân sự', 'Phòng kế toán'];
    final educationLevels = ['Cao đẳng', 'Đại học', 'Sau đại học'];

    return Scaffold(
      body: BlocConsumer<PersonelCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Thêm thành viên thành công.",
                )));
            Navigator.pop(context);
          } else if (state is AddEmployeeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Lỗi ! Thêm thành viên không thành công.",
                    style: TextStyle(color: Colors.white))));
            Navigator.pop(context);
          }
        },
        builder: (context, state) {
          return Row(
            children: [
              const Expanded(child: Sidebar()),
              Expanded(
                flex: 5,
                child: Column(
                  children: [
                    const Header(),
                    Expanded(
                      child: Container(
                        color: Colors.grey[200],
                        padding: const EdgeInsets.all(16.0),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              const TBreadcrumsWithHeading(
                                heading: 'Nhân viên',
                                breadcrumbItems: [RouterName.addEmployee],
                              ),
                              const Gap(20),
                              Container(
                                width: 600,
                                padding:
                                    const EdgeInsets.all(TSizes.defaultSpace),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Form(
                                  key: GlobalKey<FormState>(),
                                  child: Column(
                                    children: [
                                      TTextFormField(
                                        textAlign: true,
                                        text: 'Họ tên',
                                        hint: 'Nhập họ tên',
                                        controller: fullNameController,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TDropDownMenu(
                                        menus: const ['Nam', 'Nữ'],
                                        controller: genderController,
                                        text: 'Giới tính',
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
                                            birthDateController.text =
                                                "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
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
                                        text: 'Chức vụ',
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TDropDownMenu(
                                        menus: departments,
                                        controller: departmentController,
                                        text: 'Phòng ban',
                                      ),
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
                                        controller: educationLevelController,
                                        text: 'Trình độ',
                                      ),
                                      const Gap(TSizes.spaceBtwSections),
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          backgroundColor: Colors.blue,
                                          padding: const EdgeInsets.symmetric(
                                            horizontal: TSizes.defaultSpace * 2,
                                            vertical: 16,
                                          ),
                                        ),
                                        onPressed: state is AddEmployeeLoading
                                            ? null
                                            : () {
                                                final newEmployee =
                                                    PersonnelManagement(
                                                  id: "${DateTime.now().millisecondsSinceEpoch}",
                                                  name: fullNameController.text,
                                                  dateOfBirth:
                                                      birthDateController.text,
                                                  gender: genderController.text,
                                                  position:
                                                      positionController.text,
                                                  department:
                                                      departmentController.text,
                                                  address:
                                                      addressController.text,
                                                  phone: phoneController.text,
                                                  email: emailController.text,
                                                  experience:
                                                      experienceController.text,
                                                  date:
                                                      "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                                                );
                                                context
                                                    .read<PersonelCubit>()
                                                    .addEmployee(
                                                        newEmployee, context);

                                                // context
                                                //     .read<PersonelCubit>()
                                                //     .getEmployee();
                                              },
                                        child: state is AddEmployeeLoading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white)
                                            : Text(
                                                'Thêm nhân viên',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyMedium!
                                                    .copyWith(
                                                      color: Colors.white,
                                                    ),
                                              ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
