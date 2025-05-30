import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tata/data/babyServices.dart';
import 'package:tata/data/userServices.dart';
import 'package:tata/extensions/translation_extension.dart';
import 'package:tata/presentation/components/theme.dart';

class BabyLanding extends StatefulWidget {
  const BabyLanding({super.key});

  @override
  State<BabyLanding> createState() => _BabyLandingState();
}

class _BabyLandingState extends State<BabyLanding> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserServices.fetchFullUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text(context.tr("error-message")));
          } else {
            final user = snapshot.data;
            return Container(
              padding: EdgeInsets.all(8),
              color: clr(0),
              child: ListView(children: [
                Container(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  decoration: BoxDecoration(
                      color: clr(3),
                      borderRadius: BorderRadius.circular(50),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 4,
                            offset: Offset(0, 2))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("${context.tr("child-name")}: ${user!['name']}"),
                      Text(
                          "${context.tr("age-range")}: ${BabyServices.getDateRange(user['baby']['date_range'])} ${context.tr("months")}")
                    ],
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                FutureBuilder(
                    future: BabyServices.getLastFollowUp(user['baby']['id']),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container();
                      } else {
                        return Column(
                          children: [
                            Row(children: [
                              Expanded(
                                child: Container(
                                  padding: EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: clr(1),
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.black12,
                                          blurRadius: 4,
                                          offset: Offset(0, 2))
                                    ],
                                  ),
                                  child: snapshot.data?['follow_up_date'] !=
                                          null
                                      ? Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(context.tr("last-followup"),
                                                style:
                                                    TextStyle(color: clr(0))),
                                            Text(
                                                "${context.tr("day")}: ${snapshot.data!['follow_up_date']}",
                                                style:
                                                    TextStyle(color: clr(0))),
                                            Text(
                                                "${context.tr("following-after")}: ${BabyServices.daysRemaining(snapshot.data!['follow_up_date'])} ${context.tr("day")}",
                                                style: TextStyle(color: clr(0)))
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                              Text(
                                                context
                                                    .tr("start-first-followup"),
                                                style: TextStyle(color: clr(0)),
                                              )
                                            ]),
                                ),
                              ),
                            ]),
                            SizedBox(
                              height: 8,
                            ),
                            Row(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: InkWell(
                                      child: Container(
                                        padding: EdgeInsets.all(16),
                                        decoration: BoxDecoration(
                                            color: clr(2),
                                            borderRadius:
                                                BorderRadius.circular(25),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors.black12,
                                                  blurRadius: 4,
                                                  offset: Offset(0, 2))
                                            ]),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Icon(Iconsax.calendar_tick5,
                                                  size: 32, color: clr(0)),
                                              SizedBox(height: 12),
                                              Text(
                                                  context
                                                      .tr("periodic-followup"),
                                                  style: TextStyle(
                                                      color: clr(0),
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.bold))
                                            ]),
                                      ),
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, "periodicFollowUp");
                                      }),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            snapshot.data?['healthy'] != null
                                ? Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                              color: clr(1),
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.black12,
                                                    blurRadius: 4,
                                                    offset: Offset(0, 2))
                                              ]),
                                          child: Column(
                                            children: [
                                              Text(
                                                "${context.tr("health-status")}: ${snapshot.data!['healthy'] ? context.tr("healthy") : context.tr("not-healthy")}",
                                                style: TextStyle(
                                                    color: clr(0),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                context.tr("need-examination"),
                                                style: TextStyle(
                                                    color: clr(0),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              ),
                                              Text(
                                                snapshot.data!['healthy']
                                                    ? context.tr("no")
                                                    : context.tr("yes"),
                                                style: TextStyle(
                                                    color: clr(0),
                                                    fontWeight:
                                                        FontWeight.w600),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  )
                                : Container(),
                          ],
                        );
                      }
                    }),
                SizedBox(
                  height: 8,
                ),
                // FutureBuilder(
                //   future: BabyServices.getNextAppointment(),
                //   builder: (context, snapshot) {
                //     if (snapshot.connectionState == ConnectionState.waiting) {
                //       return CircularProgressIndicator();
                //     } else if (snapshot.hasError) {
                //       return Container();
                //     } else {
                //       return Row(
                //         children: [
                //           Expanded(
                //             child: InkWell(
                //                 child: Container(
                //                     padding: EdgeInsets.all(16),
                //                     decoration: BoxDecoration(
                //                         color: clr(1),
                //                         borderRadius: BorderRadius.circular(25),
                //                         boxShadow: [
                //                           BoxShadow(
                //                               color: Colors.black12,
                //                               blurRadius: 4,
                //                               offset: Offset(0, 2))
                //                         ]),
                //                     child: Column(
                //                         mainAxisAlignment:
                //                             MainAxisAlignment.center,
                //                         children: [
                //                           Icon(
                //                             Iconsax.hospital5,
                //                             size: 48,
                //                             color: clr(0),
                //                           ),
                //                           SizedBox(height: 12),
                //                           Text(
                //                               snapshot.data == null
                //                                   ? "حجز في مستشفى"
                //                                   : "الحجز القادم",
                //                               style: TextStyle(
                //                                   color: clr(0),
                //                                   fontSize: 16,
                //                                   fontWeight: FontWeight.bold))
                //                         ])),
                //                 onTap: () {
                //                   Navigator.pushNamed(
                //                       context,
                //                       snapshot.data == null
                //                           ? "offlineDoctorBooking"
                //                           : "nextAppointment",
                //                       arguments: snapshot.data);
                //                 }),
                //           )
                //         ],
                //       );
                //     }
                //   },
                // ),
              ]),
            );
          }
        });
  }
}
