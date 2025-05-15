import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../common/widgets/breadcrumb/t_breadcrums_with_heading.dart';
import '../../../router/routers_name.dart';
import '../../contract/table/data_table_contract.dart';

class AttendancePageTable extends StatefulWidget {
  const AttendancePageTable({super.key});

  @override
  State<AttendancePageTable> createState() => _AttendancePageTableState();
}

class _AttendancePageTableState extends State<AttendancePageTable> {
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
                heading: 'Hợp đồng',
                breadcrumbItems: [],
                rouderName: RouterName.contractPage,
              ),
              const Row(
                children: [
                  Text(
                    'Hợp đồng',
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
    ));  }
}