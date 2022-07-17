import 'package:check/constants.dart';
import 'package:check/data.dart';
import 'package:check/helpers/api_url.dart';
import 'package:check/pages/profile/mail_detail.dart';
import 'package:flutter/material.dart';

class MailBox extends StatelessWidget {
  final dynamic mail;
  const MailBox({Key? key, required this.mail}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
        left: width * 0.06,
        right: width * 0.06,
        bottom: height * 0.02,
      ),
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 0.1,
              blurRadius: 5,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4.0),
          child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MailDetail(mail: mail),
                  ),
                );
              },
              child: SizedBox(
                height: height * 0.15,
                width: width,
                child: Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                        bottom: height * 0.01,
                        left: width * 0.02,
                        right: width * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(50.0),
                            child: Image.network(
                              url +
                                  "/storage" +
                                  currentUserAvatar.split("/storage")[1],
                              height: height * 0.04,
                              width: height * 0.04,
                              fit: BoxFit.cover,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.more_vert,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Bayrbileg",
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.3),
                                fontSize: height * 0.014,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hi there, I have a quistion for you",
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: height * 0.016,
                              ),
                            ),
                          ),
                          SizedBox(height: height * 0.01),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Hi there, I have a quistion for you. Can you revieve my problem. If you can revieve my problem i will never forget you",
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              style: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                                fontSize: height * 0.014,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.02,
                        bottom: height * 0.01,
                        left: width * 0.02,
                        right: width * 0.02,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "2022-1-14",
                            style: TextStyle(
                              color: Colors.black.withOpacity(0.3),
                              fontSize: height * 0.012,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.bookmark_add,
                              color: kPrimaryColor.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
