import 'package:flutter/material.dart';
import 'package:job_application/modals/employeeInfo.dart';
import 'package:job_application/modals/user_profile.dart';
import 'package:job_application/services/database_service.dart';
import 'package:provider/provider.dart';

class Wallet extends StatefulWidget {
  @override
  _WalletState createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    //var CardNo = UserProfile.cardNo.substring(UserProfile.cardNo.length - 4);
    final user = Provider.of<User>(context);
    return Material(
      child: Container(
        color: Colors.black87,
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        child: Stack(
          children: <Widget>[
            //Container for top data
            Container(
              margin: EdgeInsets.symmetric(
                horizontal: 32,
                vertical: 30,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: <Widget>[
                  //     Text(
                  //       "\$2589.90",
                  //       style: TextStyle(
                  //         color: Colors.white,
                  //         fontSize: 36,
                  //         fontWeight: FontWeight.w700,
                  //       ),
                  //     ),
                  //     Container(
                  //       child: Row(
                  //         children: <Widget>[
                  //           Icon(
                  //             Icons.notifications,
                  //             color: Colors.lightBlue[100],
                  //           ),
                  //           SizedBox(
                  //             width: 16,
                  //           ),
                  //           CircleAvatar(
                  //             radius: 25,
                  //             backgroundColor: Colors.white,
                  //             child: ClipOval(
                  //               child: Image.network(
                  //                 UserProfile.imgUrl,
                  //                 fit: BoxFit.contain,
                  //               ),
                  //             ),
                  //           )
                  //         ],
                  //       ),
                  //     )
                  //   ],
                  // ),
                  // Text(
                  //   "Available Balance",
                  //   style: TextStyle(
                  //     fontWeight: FontWeight.w700,
                  //     fontSize: 16,
                  //     color: Colors.blue[100],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: 24,
                  // ),
                  StreamBuilder<UserProfile>(
                    stream: DatabaseService(uId: user.uId).getUserStream(),
                    builder: (ctx, snapshot){
                      if(snapshot.hasData) {
                        UserProfile userProfile = snapshot.data;
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(10),
                            ),
                            color: Color.fromRGBO(35, 60, 103, 1),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  CircleAvatar(
                                    radius: 16,
                                    backgroundColor: Color.fromRGBO(
                                      50,
                                      172,
                                      121,
                                      1,
                                    ),
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 24,
                                    ),
                                  ),
                                  Text(
                                    "VISA",
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Text(
                                "**** **** **** ${userProfile.cardNo.substring(userProfile.cardNo.length - 4)}",
                                style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 2.0,
                                ),
                              ),
                              SizedBox(
                                height: 32,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        "CARD HOLDER",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue[100],
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      Text(
                                        userProfile.name,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        "EXPIRES",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue[100],
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      Text(
                                        userProfile.expiry,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .start,
                                    children: <Widget>[
                                      Text(
                                        "CVV",
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.blue[100],
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                      Text(
                                        userProfile.cVV,
                                        style: TextStyle(
                                          fontSize: 16,
                                          color: Colors.grey[100],
                                          fontWeight: FontWeight.w700,
                                          letterSpacing: 2.0,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      }else{
                        return Center(
                          child: CircularProgressIndicator(backgroundColor: Colors.black87,),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),

            //draggable sheet
            // DraggableScrollableSheet(
            //   builder: (context, scrollController) {
            //     return Container(
            //       decoration: BoxDecoration(
            //         color: Color.fromRGBO(243, 245, 248, 1),
            //         borderRadius: BorderRadius.only(
            //           topLeft: Radius.circular(40),
            //           topRight: Radius.circular(40),
            //         ),
            //       ),
            //       child: SingleChildScrollView(
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             SizedBox(
            //               height: 24,
            //             ),
            //             Container(
            //               child: Row(
            //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //                 children: <Widget>[
            //                   Text(
            //                     "Recent Payments",
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.w900,
            //                       fontSize: 24,
            //                       color: Colors.black,
            //                     ),
            //                   ),
            //                   Text(
            //                     "See all",
            //                     style: TextStyle(
            //                       fontWeight: FontWeight.w700,
            //                       fontSize: 16,
            //                       color: Colors.grey[800],
            //                     ),
            //                   )
            //                 ],
            //               ),
            //               padding: EdgeInsets.symmetric(horizontal: 32),
            //             ),
            //             SizedBox(
            //               height: 24,
            //             ),
            //
            //             //Container for buttons
            //             Container(
            //               padding: EdgeInsets.symmetric(horizontal: 32),
            //               child: Row(
            //                 children: <Widget>[
            //                   Container(
            //                     child: Text(
            //                       "All",
            //                       style: TextStyle(
            //                         fontWeight: FontWeight.w700,
            //                         fontSize: 14,
            //                         color: Colors.grey[900],
            //                       ),
            //                     ),
            //                     decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       borderRadius: BorderRadius.all(
            //                         Radius.circular(20),
            //                       ),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.grey[200],
            //                           blurRadius: 10.0,
            //                           spreadRadius: 4.5,
            //                         )
            //                       ],
            //                     ),
            //                     padding: EdgeInsets.symmetric(
            //                       horizontal: 20,
            //                       vertical: 10,
            //                     ),
            //                   ),
            //                   SizedBox(
            //                     width: 16,
            //                   ),
            //                   Container(
            //                     child: Row(
            //                       children: <Widget>[
            //                         CircleAvatar(
            //                           radius: 8,
            //                           backgroundColor: Colors.green,
            //                         ),
            //                         SizedBox(
            //                           width: 8,
            //                         ),
            //                         Text(
            //                           "Income",
            //                           style: TextStyle(
            //                             fontWeight: FontWeight.w700,
            //                             fontSize: 14,
            //                             color: Colors.grey[900],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                     decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       borderRadius: BorderRadius.all(
            //                         Radius.circular(20),
            //                       ),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.grey[200],
            //                           blurRadius: 10.0,
            //                           spreadRadius: 4.5,
            //                         )
            //                       ],
            //                     ),
            //                     padding: EdgeInsets.symmetric(
            //                       horizontal: 20,
            //                       vertical: 10,
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ),
            //
            //             SizedBox(
            //               height: 16,
            //             ),
            //             //Container List view for expenses and incomes
            //             Container(
            //               child: Text(
            //                 "TODAY",
            //                 style: TextStyle(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w700,
            //                   color: Colors.grey[500],
            //                 ),
            //               ),
            //               padding: EdgeInsets.symmetric(
            //                 horizontal: 32,
            //               ),
            //             ),
            //
            //             SizedBox(
            //               height: 16,
            //             ),
            //
            //             ListView.builder(
            //               itemBuilder: (context, index) {
            //                 return Container(
            //                   margin: EdgeInsets.symmetric(horizontal: 32),
            //                   padding: EdgeInsets.all(16),
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.all(
            //                       Radius.circular(20),
            //                     ),
            //                   ),
            //                   child: Row(
            //                     children: <Widget>[
            //                       Container(
            //                         decoration: BoxDecoration(
            //                           color: Colors.grey[100],
            //                           borderRadius: BorderRadius.all(
            //                             Radius.circular(18),
            //                           ),
            //                         ),
            //                         child: Icon(
            //                           Icons.date_range,
            //                           color: Colors.lightBlue[900],
            //                         ),
            //                         padding: EdgeInsets.all(12),
            //                       ),
            //                       SizedBox(
            //                         width: 16,
            //                       ),
            //                       Expanded(
            //                         child: Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: <Widget>[
            //                             Text(
            //                               "Payment",
            //                               style: TextStyle(
            //                                 fontSize: 18,
            //                                 fontWeight: FontWeight.w700,
            //                                 color: Colors.grey[900],
            //                               ),
            //                             ),
            //                             Text(
            //                               "Order Completed",
            //                               style: TextStyle(
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.w700,
            //                                 color: Colors.grey[500],
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.end,
            //                         children: <Widget>[
            //                           Text(
            //                             "+\$500.5",
            //                             style: TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.w700,
            //                               color: Colors.lightGreen,
            //                             ),
            //                           ),
            //                           Text(
            //                             "26 Jan",
            //                             style: TextStyle(
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.w700,
            //                               color: Colors.grey[500],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //               shrinkWrap: true,
            //               itemCount: 2,
            //               padding: EdgeInsets.all(0),
            //               controller: ScrollController(
            //                 keepScrollOffset: false,
            //               ),
            //             ),
            //
            //             //now expense
            //             SizedBox(
            //               height: 16,
            //             ),
            //
            //             Container(
            //               child: Text(
            //                 "YESTERDAY",
            //                 style: TextStyle(
            //                   fontSize: 15,
            //                   fontWeight: FontWeight.w700,
            //                   color: Colors.grey[500],
            //                 ),
            //               ),
            //               padding: EdgeInsets.symmetric(
            //                 horizontal: 32,
            //               ),
            //             ),
            //
            //             SizedBox(
            //               height: 16,
            //             ),
            //
            //             ListView.builder(
            //               itemBuilder: (context, index) {
            //                 return Container(
            //                   margin: EdgeInsets.symmetric(horizontal: 32),
            //                   padding: EdgeInsets.all(16),
            //                   decoration: BoxDecoration(
            //                     color: Colors.white,
            //                     borderRadius: BorderRadius.all(
            //                       Radius.circular(20),
            //                     ),
            //                   ),
            //                   child: Row(
            //                     children: <Widget>[
            //                       Container(
            //                         decoration: BoxDecoration(
            //                           color: Colors.grey[100],
            //                           borderRadius: BorderRadius.all(
            //                             Radius.circular(18),
            //                           ),
            //                         ),
            //                         child: Icon(
            //                           Icons.directions_car,
            //                           color: Colors.lightBlue[900],
            //                         ),
            //                         padding: EdgeInsets.all(12),
            //                       ),
            //                       SizedBox(
            //                         width: 16,
            //                       ),
            //                       Expanded(
            //                         child: Column(
            //                           crossAxisAlignment:
            //                               CrossAxisAlignment.start,
            //                           children: <Widget>[
            //                             Text(
            //                               "Petrol",
            //                               style: TextStyle(
            //                                 fontSize: 18,
            //                                 fontWeight: FontWeight.w700,
            //                                 color: Colors.grey[900],
            //                               ),
            //                             ),
            //                             Text(
            //                               "Order Canceled",
            //                               style: TextStyle(
            //                                 fontSize: 15,
            //                                 fontWeight: FontWeight.w700,
            //                                 color: Colors.grey[500],
            //                               ),
            //                             ),
            //                           ],
            //                         ),
            //                       ),
            //                       Column(
            //                         crossAxisAlignment: CrossAxisAlignment.end,
            //                         children: <Widget>[
            //                           Text(
            //                             "-\$500.5",
            //                             style: TextStyle(
            //                               fontSize: 18,
            //                               fontWeight: FontWeight.w700,
            //                               color: Colors.orange,
            //                             ),
            //                           ),
            //                           Text(
            //                             "26 Jan",
            //                             style: TextStyle(
            //                               fontSize: 15,
            //                               fontWeight: FontWeight.w700,
            //                               color: Colors.grey[500],
            //                             ),
            //                           ),
            //                         ],
            //                       ),
            //                     ],
            //                   ),
            //                 );
            //               },
            //               shrinkWrap: true,
            //               itemCount: 2,
            //               padding: EdgeInsets.all(0),
            //               controller: ScrollController(keepScrollOffset: false),
            //             ),
            //
            //             //now expense
            //           ],
            //         ),
            //         controller: scrollController,
            //       ),
            //     );
            //   },
            //   initialChildSize: 0.5,
            //   minChildSize: 0.5,
            //   maxChildSize: 0.88,
            // )
          ],
        ),
      ),
    );
  }
}
