import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../../../common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import '../../../common/widgets/drop_down_menu/drop_down_menu.dart';
import '../../../common/widgets/layouts/headers/headers.dart';
import '../../../common/widgets/layouts/sidebars/sidebar.dart';
import '../../../common/widgets/text_form/text_form_field.dart';
import '../../../constants/sizes.dart';
import '../../../data/model/personnel_management.dart';
import '../../../router/routers_name.dart';
import '../bloc/personnel_bloc.dart';
import '../bloc/personnel_state.dart';

// ignore: must_be_immutable
class UpdatePersonnel extends StatefulWidget {
  PersonnelManagement employee;
  UpdatePersonnel({super.key, required this.employee});

  @override
  State<UpdatePersonnel> createState() => _UpdatePersonnelState();
}

class _UpdatePersonnelState extends State<UpdatePersonnel> {
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
  @override
  void initState() {
    fullNameController.text = widget.employee.name;
    genderController.text = widget.employee.gender;
    positionController.text = widget.employee.position.toString();
    departmentController.text = widget.employee.department.toString();
    phoneController.text = widget.employee.phone;
    emailController.text = widget.employee.email;
    addressController.text = widget.employee.address;
    experienceController.text = widget.employee.experience;
    educationLevelController.text = widget.employee.experience.toString();
    birthDateController.text = widget.employee.dateOfBirth;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<PersonelCubit, AddEmployeeState>(
        listener: (context, state) {
          if (state is AddEmployeeSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.green,
                content: Text(
                  "Cập nhật thành viên thành công.",
                )));
            Navigator.pop(context);
          } else if (state is AddEmployeeFailure) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                backgroundColor: Colors.red,
                content: Text("Lỗi ! Cập nhập thành viên không thành công.",
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
                                heading: 'Cập nhật nhân viên',
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
                                        onPressed: state
                                                is UpdateEmployeeLoading
                                            ? null
                                            : () {
                                                final updateEmployee =
                                                    PersonnelManagement(
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
                                                    .updateEmployee(
                                                      widget.employee.id ?? '',
                                                      updateEmployee,
                                                    );

                                                // context
                                                //     .read<PersonelCubit>()
                                                //     .getEmployee();
                                              },
                                        child: state is UpdateEmployeeLoading
                                            ? const CircularProgressIndicator(
                                                color: Colors.white)
                                            : Text(
                                                'Cập nhật',
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
