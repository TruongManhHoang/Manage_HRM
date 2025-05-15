/// The `AddAndEditRewardPage` class in Dart is a StatefulWidget that allows users to add or edit reward
/// information for employees, with form fields for employee details, reward type, date, reason, value,
/// approver, status, and document attachment.
import 'package:admin_hrm/common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import 'package:admin_hrm/common/widgets/layouts/headers/headers.dart';
import 'package:admin_hrm/common/widgets/layouts/sidebars/sidebar.dart';
import 'package:admin_hrm/common/widgets/text_form/text_form_field.dart';
import 'package:admin_hrm/constants/sizes.dart';
import 'package:admin_hrm/pages/reward/bloc/reward_bloc.dart';
import 'package:admin_hrm/pages/reward/bloc/reward_event.dart';
import 'package:admin_hrm/pages/reward/bloc/reward_state.dart';
import 'package:admin_hrm/router/routers_name.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../data/model/reward/reward_model.dart';

class AddAndEditRewardPage extends StatefulWidget {
  final RewardModel? reward;
  const AddAndEditRewardPage({super.key, this.reward});

  @override
  State<AddAndEditRewardPage> createState() => _AddAndEditRewardPageState();
}

class _AddAndEditRewardPageState extends State<AddAndEditRewardPage> {
  final _formKey = GlobalKey<FormState>();
  final employeeIdCtrl = TextEditingController();
  final employeeNameCtrl = TextEditingController();
  final reasonCtrl = TextEditingController();
  final rewardValueCtrl = TextEditingController();
  final approvedByCtrl = TextEditingController();
  final documentCtrl = TextEditingController();

  String rewardType = 'Tiền mặt';
  Timestamp rewardDate = Timestamp.now();
  String status = 'Chờ duyệt';

  final rewardTypes = ['Tiền mặt', 'Thưởng KPI', 'Hiện vật', 'Khác'];
  final statusOptions = ['Chờ duyệt', 'Đã duyệt', 'Từ chối'];

  @override
  void initState() {
    super.initState();
    if (widget.reward != null) {
      final r = widget.reward!;
      employeeIdCtrl.text = r.employeeId;
      employeeNameCtrl.text = r.employeeName;
      reasonCtrl.text = r.reason;
      rewardValueCtrl.text = r.rewardValue.toString();
      approvedByCtrl.text = r.approvedBy;
      documentCtrl.text = r.document ?? '';
      rewardType = r.rewardType;
      rewardDate = r.rewardDate;
      status = r.status;
    }
  }

  @override
  void dispose() {
    employeeIdCtrl.dispose();
    employeeNameCtrl.dispose();
    reasonCtrl.dispose();
    rewardValueCtrl.dispose();
    approvedByCtrl.dispose();
    documentCtrl.dispose();
    super.dispose();
  }

  Future<void> _pickRewardDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: rewardDate.toDate(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (date != null) {
      setState(() {
        rewardDate = Timestamp.fromDate(date);
      });
    }
  }

  void _submitForm() {
    if (!_formKey.currentState!.validate()) return;

    final reward = RewardModel(
      id: widget.reward?.id ?? '',
      employeeId: employeeIdCtrl.text,
      employeeName: employeeNameCtrl.text,
      rewardType: rewardType,
      rewardDate: rewardDate,
      reason: reasonCtrl.text,
      rewardValue: double.tryParse(rewardValueCtrl.text) ?? 0.0,
      approvedBy: approvedByCtrl.text,
      status: status,
      document: documentCtrl.text.isEmpty ? null : documentCtrl.text,
    );

    if (widget.reward != null) {
      context.read<RewardBloc>().add(UpdateReward(reward));
    } else {
      context.read<RewardBloc>().add(AddReward(reward));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<RewardBloc, RewardState>(
      listener: (context, state) {
        if (state is RewardSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(widget.reward != null
                  ? 'Cập nhật khen thưởng thành công'
                  : 'Thêm khen thưởng thành công'),
            ),
          );
          context.pop(true);
        } else if (state is RewardError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Lỗi: ${state.message}')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          body: Row(
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
                              TBreadcrumsWithHeading(
                                heading: widget.reward != null
                                    ? 'Cập nhật khen thưởng'
                                    : 'Thêm khen thưởng',
                                breadcrumbItems: [RouterName.addReward],
                              ),
                              Container(
                                width: 600,
                                padding:
                                    const EdgeInsets.all(TSizes.defaultSpace),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Form(
                                  key: _formKey,
                                  child: Column(
                                    children: [
                                      TTextFormField(
                                        controller: employeeIdCtrl,
                                        textAlign: true,
                                        text: 'Mã nhân viên',
                                        hint: 'Nhập mã nhân viên',
                                        validator: (val) =>
                                            val == null || val.isEmpty
                                                ? 'Không được để trống'
                                                : null,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: employeeNameCtrl,
                                        textAlign: true,
                                        text: 'Tên nhân viên',
                                        hint: 'Nhập tên nhân viên',
                                        validator: (val) =>
                                            val == null || val.isEmpty
                                                ? 'Không được để trống'
                                                : null,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      Row(
                                        children: [
                                          const Text('Loại khen thưởng'),
                                          const Spacer(),
                                          DropdownButton(
                                            value: rewardType,
                                            items: rewardTypes.map((s) {
                                              return DropdownMenuItem(
                                                value: s,
                                                child: Text(s),
                                              );
                                            }).toList(),
                                            onChanged: (value) {
                                              if (value != null) {
                                                setState(() {
                                                  rewardType = value;
                                                });
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      ListTile(
                                        title: Text(
                                            'Ngày thưởng: ${rewardDate.toDate().toLocal().toString().split(' ')[0]}'),
                                        trailing:
                                            const Icon(Icons.calendar_today),
                                        onTap: _pickRewardDate,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      DropdownButtonFormField(
                                        value: status,
                                        items: statusOptions.map((s) {
                                          return DropdownMenuItem(
                                            value: s,
                                            child: Text(s),
                                          );
                                        }).toList(),
                                        onChanged: (value) {
                                          if (value != null) {
                                            setState(() {
                                              status = value;
                                            });
                                          }
                                        },
                                        decoration: const InputDecoration(
                                            labelText: 'Trạng thái'),
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: reasonCtrl,
                                        textAlign: true,
                                        text: 'Lý do',
                                        hint: 'Nhập lý do',
                                        maxLines: 2,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: rewardValueCtrl,
                                        textAlign: true,
                                        text: 'Giá trị',
                                        hint: 'Nhập giá trị',
                                        validator: (val) => val == null ||
                                                double.tryParse(val) == null
                                            ? 'Nhập số hợp lệ'
                                            : null,
                                        keyboardType: TextInputType.number,
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: approvedByCtrl,
                                        textAlign: true,
                                        text: 'Người phê duyệt',
                                        hint: 'Nhập người phê duyệt',
                                      ),
                                      const Gap(TSizes.spaceBtwItems),
                                      TTextFormField(
                                        controller: documentCtrl,
                                        textAlign: true,
                                        text: 'Tài liệu đính kèm',
                                        hint: 'Link hoặc ghi chú',
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
                                        onPressed: _submitForm,
                                        child: Text(
                                          widget.reward != null
                                              ? 'Cập nhật khen thưởng'
                                              : 'Thêm khen thưởng',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(color: Colors.white),
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
              ),
            ],
          ),
        );
      },
    );
  }
}
