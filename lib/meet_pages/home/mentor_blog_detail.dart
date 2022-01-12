import 'package:flutter/material.dart';

import '../../constants.dart';

class MenterBlogDetail extends StatefulWidget {
  const MenterBlogDetail({Key? key}) : super(key: key);

  @override
  _MenterBlogDetailState createState() => _MenterBlogDetailState();
}

class _MenterBlogDetailState extends State<MenterBlogDetail> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              _body(height, width),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Image.asset(
              "assets/plant.jpeg",
              fit: BoxFit.cover,
              height: height * 0.38,
              width: width,
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: SizedBox(
              height: height * 0.38,
              width: width,
              child: Padding(
                padding: EdgeInsets.only(
                  right: width * 0.04,
                  bottom: height * 0.02,
                ),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          8.0,
                        ),
                        child: Container(
                          color: Colors.black.withOpacity(0.4),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "20",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: height * 0.02,
                                  ),
                                ),
                                SizedBox(width: width * 0.02),
                                Icon(
                                  Icons.visibility_outlined,
                                  color: Colors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: width * 0.04),
                      // ClipRRect(
                      //   borderRadius: BorderRadius.circular(
                      //     8.0,
                      //   ),
                      //   child: Container(
                      //     color: Colors.black.withOpacity(0.4),
                      //     child: Padding(
                      //       padding: const EdgeInsets.all(8.0),
                      //       child: Row(
                      //         mainAxisSize: MainAxisSize.min,
                      //         children: [
                      //           Text(
                      //             homeItems[widget.index]
                      //                 .advices[widget.index2]["likes"]
                      //                 .toString(),
                      //             style: TextStyle(
                      //               color: Colors.white,
                      //               fontSize: height * 0.02,
                      //             ),
                      //           ),
                      //           SizedBox(width: width * 0.02),
                      //           if (token != null)
                      //             Row(
                      //               mainAxisSize: MainAxisSize.min,
                      //               children: [
                      //                 if (currentUserLikedAdvice.contains(
                      //                     homeItems[widget.index]
                      //                         .advices[widget.index2]["id"]
                      //                         .toString()))
                      //                   Icon(
                      //                     Icons.star,
                      //                     color: Colors.white,
                      //                   ),
                      //                 if (!currentUserLikedAdvice.contains(
                      //                     homeItems[widget.index]
                      //                         .advices[widget.index2]["id"]
                      //                         .toString()))
                      //                   Icon(
                      //                     Icons.star_border,
                      //                     color: Colors.white,
                      //                   )
                      //               ],
                      //             ),
                      //           if (token == null)
                      //             Icon(Icons.star_border, color: Colors.white),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.only(top: height * 0.43),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.08,
                      right: width * 0.08,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Гарчиг",
                        style: TextStyle(
                          fontSize: height * 0.028,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: height * 0.01),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.08,
                      right: width * 0.08,
                    ),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        children: [
                          Text(
                            "Blog оруулсан,",
                            style: TextStyle(
                              fontSize: height * 0.02,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          Text(
                            " " + "admin",
                            style: TextStyle(
                              fontSize: height * 0.02,
                              color: kPrimaryColor2.withOpacity(0.9),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.03,
                  ),
                  Row(
                    children: [
                      // Padding(
                      //   padding: EdgeInsets.only(left: width * 0.08),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(
                      //         8.0,
                      //       ),
                      //       child: Material(
                      //         color: kPrimaryColor2,
                      //         child: InkWell(
                      //           onTap: () {
                      //             if (token != null) {
                      //               if (!_isLoadLike) _pushLike();
                      //             } else {
                      //               showSnackBar(
                      //                   "Та нэвтэрсэн байх хэрэгтэй", _key);
                      //             }
                      //           },
                      //           child: Container(
                      //             child: Padding(
                      //               padding: EdgeInsets.all(height * 0.01),
                      //               child: Column(
                      //                 children: [
                      //                   if (_isLoadLike)
                      //                     Container(
                      //                       height: height * 0.038,
                      //                       width: height * 0.038,
                      //                       child: CircularProgressIndicator(
                      //                         strokeWidth: 1.5,
                      //                         valueColor:
                      //                             AlwaysStoppedAnimation<Color>(
                      //                           Colors.white,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   if (!_isLoadLike)
                      //                     Row(
                      //                       mainAxisSize: MainAxisSize.min,
                      //                       children: [
                      //                         if (token != null)
                      //                           Row(
                      //                             mainAxisSize:
                      //                                 MainAxisSize.min,
                      //                             children: [
                      //                               if (currentUserLikedAdvice
                      //                                   .contains(homeItems[
                      //                                           widget.index]
                      //                                       .advices[widget
                      //                                           .index2]["id"]
                      //                                       .toString()))
                      //                                 Icon(
                      //                                   Icons.star,
                      //                                   color: Colors.white,
                      //                                 ),
                      //                               if (!currentUserLikedAdvice
                      //                                   .contains(homeItems[
                      //                                           widget.index]
                      //                                       .advices[widget
                      //                                           .index2]["id"]
                      //                                       .toString()))
                      //                                 Icon(
                      //                                   Icons.star_border,
                      //                                   color: Colors.white,
                      //                                 )
                      //                             ],
                      //                           ),
                      //                         if (token == null)
                      //                           Icon(Icons.star_border,
                      //                               color: Colors.white),
                      //                       ],
                      //                     ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(left: width * 0.04),
                      //   child: Align(
                      //     alignment: Alignment.centerLeft,
                      //     child: ClipRRect(
                      //       borderRadius: BorderRadius.circular(
                      //         8.0,
                      //       ),
                      //       child: Material(
                      //         color: kLightColor2,
                      //         child: InkWell(
                      //           onTap: () {
                      //             if (token != null) {
                      //               if (currentUserReportedAdvice.contains(
                      //                   homeItems[widget.index]
                      //                       .advices[widget.index2]["id"]
                      //                       .toString())) {
                      //                 showSnackBar(
                      //                     "Та аль хэдийн Report хийсэн байна",
                      //                     _key);
                      //               } else {
                      //                 if (!_isLoadReport) _pushReport();
                      //               }
                      //             } else {
                      //               showSnackBar(
                      //                   "Та нэвтэрсэн байх хэрэгтэй", _key);
                      //             }
                      //           },
                      //           child: Container(
                      //             child: Padding(
                      //               padding: EdgeInsets.all(height * 0.016),
                      //               child: Row(
                      //                 mainAxisSize: MainAxisSize.min,
                      //                 children: [
                      //                   if (_isLoadReport)
                      //                     Container(
                      //                       height: height * 0.024,
                      //                       width: height * 0.024,
                      //                       child: CircularProgressIndicator(
                      //                         strokeWidth: 1.5,
                      //                         valueColor:
                      //                             AlwaysStoppedAnimation<Color>(
                      //                           Colors.white,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                   if (!_isLoadReport)
                      //                     Text(
                      //                       "Report",
                      //                       style: TextStyle(
                      //                         color: Colors.white,
                      //                         fontSize: height * 0.02,
                      //                       ),
                      //                     ),
                      //                 ],
                      //               ),
                      //             ),
                      //           ),
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: height * 0.06,
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: width * 0.08,
                      right: width * 0.08,
                    ),
                    child: Text(
                      "Content",
                      textAlign: TextAlign.justify,
                    ),
                  ),
                  SizedBox(
                    height: height * 0.1,
                  ),
                ],
              ),
            ),
          ),
          SafeArea(
            child: _top(height, width),
          ),
        ],
      );

  Widget _top(double height, double width) => SizedBox(
        height: height * 0.09,
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.03,
            right: width * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 0.1,
                      blurRadius: 4,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: Material(
                    color: Colors.grey.shade200.withOpacity(0.5),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: SizedBox(
                        height: height * 0.06,
                        width: height * 0.06,
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Text(
                "",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.done_outline,
                  color: Colors.transparent,
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      );
}
