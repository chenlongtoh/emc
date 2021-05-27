import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/student/appointment/model/entity/appointment.dart';
import 'package:emc/screens/student/appointment/model/view_model/appointment_model.dart';
import 'package:emc/screens/student/appointment/ui/widgets/accepted_appointment_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

enum AppointmentTabType {
  accepted,
  pending,
  declined,
}

class AppointmentTab extends StatefulWidget {
  AppointmentTabType appointmentTabType;

  AppointmentTab.accepted() {
    appointmentTabType = AppointmentTabType.accepted;
  }

  AppointmentTab.pending() {
    appointmentTabType = AppointmentTabType.pending;
  }

  AppointmentTab.declined() {
    appointmentTabType = AppointmentTabType.declined;
  }

  @override
  _AppointmentTabState createState() => _AppointmentTabState();
}

class _AppointmentTabState extends State<AppointmentTab> {
  RefreshController _refreshController;

  void _onRefresh(AppointmentModel model) async {
    model.init();
    setState(() {});
    _refreshController.refreshCompleted();
  }

  @override
  void initState() {
    super.initState();
    _refreshController = new RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AppointmentModel>(
      builder: (context, model, child) {
        List<Appointment> appointmentList = widget.appointmentTabType == AppointmentTabType.accepted
            ? model.acceptedAppointment
            : widget.appointmentTabType == AppointmentTabType.pending
                ? model.pendingAppointment
                : model.declinedAppointment;
        return SmartRefresher(
          controller: _refreshController,
          onRefresh: () async => _onRefresh(model),
          enablePullDown: true,
          child: model.isLoading
              ? EmcShimmerList()
              : (appointmentList?.isEmpty ?? true)
                  ? Center(
                      child: Text(
                        widget.appointmentTabType == AppointmentTabType.accepted
                            ? "No Accepted Appointment Found"
                            : widget.appointmentTabType == AppointmentTabType.pending
                                ? "No Pending Appointment Found"
                                : "No Declined Appointment Found",
                      ),
                    )
                  : ListView.separated(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      itemCount: appointmentList.length,
                      separatorBuilder: (_, __) => SizedBox(height: 5),
                      itemBuilder: (context, index) => AcceptedItem(
                        appointment: appointmentList[index],
                      ),
                    ),
        );
      },
    );
  }
}
