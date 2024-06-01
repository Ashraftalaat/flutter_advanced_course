import 'package:flutter/material.dart';
import 'package:flutter_complete_project/features/home/ui/widgets/doctors_list_view_item.dart';

class DoctorsListView extends StatelessWidget {
  const DoctorsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 10,
        //shrinkWrap: true,
        itemBuilder: (context, index) {
          return const DoctorsListViewItem();
        },
      ),
    );
  }
}
