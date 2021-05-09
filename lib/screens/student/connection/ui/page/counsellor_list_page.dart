import 'dart:developer';

import 'package:emc/auth/model/entity/emc_user.dart';
import 'package:emc/auth/model/view_model/auth_model.dart';
import 'package:emc/common_widget/emc_scaffold.dart';
import 'package:emc/common_widget/emc_shimmer.dart';
import 'package:emc/screens/student/connection/model/view_model/connection_model.dart';
import 'package:emc/screens/student/connection/ui/widgets/lecturer_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:provider/provider.dart';

class CounsellorListPageArgs {
  final ConnectionModel connectionModel;
  CounsellorListPageArgs({this.connectionModel});
}

class CounsellorListPage extends StatefulWidget {
  static const routeName = "/counsellorList";

  final CounsellorListPageArgs args;
  CounsellorListPage({this.args});

  @override
  _CounsellorListPageState createState() => _CounsellorListPageState();
}

class _CounsellorListPageState extends State<CounsellorListPage> {
  void _onConnect(EmcUser counsellor) async {
    await widget?.args?.connectionModel?.connectToCounsellor(counsellor)?.then(
      (success) {
        if (success) Navigator.pop(context, true);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return EmcScaffold(
      appBar: AppBar(
        title: Text("Select a Counsellor"),
      ),
      body: FutureBuilder(
        future: widget.args?.connectionModel?.getNonConnectedCounsellors(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            final bool dataReady = (snapshot.data != null && snapshot.data is List && snapshot.data.length > 0);
            log("dataReady => ${snapshot.data}");
            return dataReady
                ? ListView.separated(
                    separatorBuilder: (_, __) => SizedBox(height: 5),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, index) {
                      final EmcUser user = snapshot.data[index];
                      return LecturerItem(
                        imageUri: user?.profilePicture,
                        name: user?.name,
                        qualification: user?.qualification,
                        trailingWidget: TextButton(
                          child: Text(
                            "Connect",
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: BorderSide(color: Colors.black),
                              ),
                            ),
                          ),
                          onPressed: () => _onConnect(user),
                        ),
                      );
                    },
                  )
                : Center(
                    child: Text("No Counsellors Found"),
                  );
          }
          return EmcShimmerList();
        },
      ),
    );
  }
}
