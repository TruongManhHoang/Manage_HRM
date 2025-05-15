import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import '../../../router/routers_name.dart';
import '../../contract/table/data_table_contract.dart';

class AttendancePageDesktop extends StatefulWidget {
  const AttendancePageDesktop({super.key});

  @override
  State<AttendancePageDesktop> createState() => _AttendancePageDesktopState();
}

class _AttendancePageDesktopState extends State<AttendancePageDesktop> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.grey[200],
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              const TBreadcrumsWithHeading(
                heading: 'Bảng chấm công',
                breadcrumbItems: [],
                rouderName: RouterName.contractPage,
              ),
              const Row(
                children: [
                  Text(
                    'Bảng chấm công',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.white,
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {
                              context.push(RouterName.addContract);
                            },
                            child: Text(
                              'Thêm hợp đồng',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                        const Gap(10),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Xuất danh sách hợp đồng',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                        const Gap(10),
                        TextButton(
                            style: TextButton.styleFrom(
                              backgroundColor: Colors.blue,
                            ),
                            onPressed: () {},
                            child: Text(
                              'Hiện hợp đồng đã ngừng hoạt động',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(color: Colors.white),
                            )),
                      ],
                    ),
                    const DataTableContract()
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
