import 'dart:developer';
import 'dart:async';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/student/appointment/model/entity/appointment.dart';
import 'package:emc/screens/student/appointment/model/view_model/appointment_model.dart';
import 'package:emc/screens/student/appointment/ui/widgets/counsellor_list_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../../constant.dart';

class CounsellorListPageArgs {
  final AppointmentModel appointmentModel;
  CounsellorListPageArgs({this.appointmentModel});
}

class CounsellorListPage extends StatefulWidget {
  static const routeName = "/counsellorListPage";

  @override
  _CounsellorListPageState createState() => _CounsellorListPageState();
}

class _CounsellorListPageState extends State<CounsellorListPage> {
  String _criteria = "";
  Timer _debounce;

  void _onSearch(String criteria, AppointmentModel model) {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() => _criteria = criteria);
    });
  }

  @override
  void dispose() {
    super.dispose();
    _debounce?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentModel>(
      builder: (context, model, child) {
        List<Counsellor> counsellorList = model.getCounsellorsByCriteria(_criteria);
        return EmcScaffold(
          appBar: AppBar(
            title: Text("Select a counsellor"),
          ),
          body: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: EmcColors.grey,
                  ),
                  borderRadius: BorderRadius.circular(30),
                  color: Colors.white,
                ),
                margin: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
                child: Row(
                  children: [
                    Icon(Icons.search),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: "Search...",
                          isDense: true,
                        ),
                        onChanged: (criteria) => _onSearch(criteria, model),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: model.isLoading
                    ? EmcShimmerList()
                    : (counsellorList?.isNotEmpty ?? false)
                        ? ListView.separated(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(top: 10, left: 30, right: 30),
                            itemCount: counsellorList.length,
                            separatorBuilder: (_, __) => SizedBox(height: 15),
                            itemBuilder: (context, index) {
                              log("counsellorList[index] => ${counsellorList[index].toJson()}");
                              return CounsellorListItem(counsellor: counsellorList[index]);
                            },
                          )
                        : Center(
                            child: Text("No Connected Counsellor Found"),
                          ),
              ),
            ],
          ),
        );
      },
    );
  }
}
