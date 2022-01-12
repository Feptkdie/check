// ignore_for_file: unnecessary_null_comparison, avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:check/helpers/api_url.dart';
import 'package:check/helpers/app_preferences.dart';
import 'package:check/meet_pages/auth/login_page.dart';
import 'package:check/meet_pages/auth/register_page.dart';
import 'package:check/meet_pages/profile/profile_edit.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import '../../constants.dart';
import '../../data.dart';
import 'my_interest.dart';
import 'my_status.dart';

class MeetProfilePage extends StatefulWidget {
  const MeetProfilePage({Key? key}) : super(key: key);

  @override
  _MeetProfilePageState createState() => _MeetProfilePageState();
}

class _MeetProfilePageState extends State<MeetProfilePage> {
  final GlobalKey<ScaffoldState> _key = new GlobalKey<ScaffoldState>();
  late File _image;
  bool _isLoad = false;
  final picker = ImagePicker();

  Future getImage() async {
    var pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 1024.0,
        maxWidth: 1650.0);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      try {
        // var pickedFile = await picker.getImage(source: ImageSource.gallery);
        if (_image != null) {
          // var byteData = await images.readAsBytes();
          Uri apiUrl = Uri.parse(mainApiUrl + "update-user-avatar");
          final mimeTypeData =
              lookupMimeType(_image.path, headerBytes: [0xFF, 0xD8])
                  ?.split('/');
          // Intilize the multipart request
          final imageUploadRequest = https.MultipartRequest('POST', apiUrl);
          // Attach the file in the request
          final file = await https.MultipartFile.fromPath(
            'avatar',
            _image.path,
            contentType: MediaType(
              mimeTypeData![0],
              mimeTypeData[1],
            ),
          );
          Map<String, String> headers = {
            "Authorization": "Bearer $token",
            "Content-Type": "multipart/form-data"
          };
          imageUploadRequest.headers.addAll(headers);
          imageUploadRequest.files.add(file);

          imageUploadRequest.fields['url'] = url;
          try {
            setState(() {
              _isLoad = true;
            });
            final streamedResponse = await imageUploadRequest.send();
            final response = await https.Response.fromStream(streamedResponse);
            if (response.statusCode != 200) {
              print(response.body);
              showSnackBar("Алдаа гарлаа дахин оролдоно уу", _key);
            } else {
              setState(() {
                if (json.decode(response.body)["status"]) {
                  setState(() {
                    currentUserAvatar =
                        json.decode(response.body)["avatar"].toString();
                  });
                } else {
                  showSnackBar("Алдаа гарлаа дахин оролдоно уу", _key);
                }
              });
              print(response.body);
            }
          } catch (e) {
            print(e);
          }
        } else {
          showSnackBar("Зураг сонгоогүй байна!", _key);
        }
      } catch (e) {
        print("error:" + e.toString());
      }

      setState(() {
        _isLoad = false;
      });
    }
  }

  void _signOut() async {
    removeUserData();
    goMeet(context);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _key,
      body: SizedBox(
        height: height,
        width: width,
        child: SingleChildScrollView(
          child: SafeArea(
            child: Column(
              children: <Widget>[
                _top(height, width),
                if (token != null) _body(height, width),
                if (token == null)
                  Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.2,
                          left: width * 0.2,
                          top: height * 0.05,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor2.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Material(
                              color: kPrimaryColor2.withOpacity(1.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MeetLoginPage(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: height * 0.05,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.person,
                                          color: Colors.white),
                                      SizedBox(width: width * 0.02),
                                      const Text(
                                        "НЭВТРЭХ",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          right: width * 0.2,
                          left: width * 0.2,
                          top: height * 0.03,
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: kPrimaryColor2.withOpacity(0.2),
                                spreadRadius: 5,
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Material(
                              color: kPrimaryColor2.withOpacity(1.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const MeetRegisterPage(),
                                    ),
                                  );
                                },
                                child: SizedBox(
                                  height: height * 0.05,
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.person_add,
                                          color: Colors.white),
                                      SizedBox(width: width * 0.02),
                                      const Text(
                                        "БҮРТГҮҮЛЭХ",
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.02,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: SizedBox(
                    height: height * 0.1,
                    width: height * 0.1,
                    child: Stack(
                      children: [
                        if (_isLoad)
                          Center(
                            child: SizedBox(
                              height: height * 0.042,
                              width: height * 0.042,
                              child: CircularProgressIndicator(
                                strokeWidth: 1.5,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  kLightColor2,
                                ),
                              ),
                            ),
                          ),
                        if (!_isLoad)
                          Center(
                            child: Stack(
                              children: [
                                if (currentUserAvatar != null)
                                  SizedBox(
                                    height: height * 0.1,
                                    width: height * 0.1,
                                    child: Image.network(
                                      url +
                                          "/storage" +
                                          currentUserAvatar
                                              .split("/storage")[1],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                if (currentUserAvatar == null)
                                  SizedBox(
                                    height: height * 0.1,
                                    width: height * 0.1,
                                    child: const Center(
                                      child: Icon(Icons.add_a_photo),
                                    ),
                                  ),
                                Material(
                                  color: Colors.black.withOpacity(0.3),
                                  child: InkWell(
                                    onTap: () {
                                      if (!_isLoad) getImage();
                                    },
                                    child: SizedBox(
                                      height: height * 0.1,
                                      width: height * 0.1,
                                      child: const Text(""),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: width * 0.08,
                    left: width * 0.08,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Нэр",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: height * 0.022,
                        ),
                      ),
                      Text(
                        currentUserName,
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w400,
                          fontSize: height * 0.022,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(
                    right: width * 0.08,
                    left: width * 0.08,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "И-майл",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        currentUserEmail,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(),
                Padding(
                  padding: EdgeInsets.only(
                    right: width * 0.08,
                    left: width * 0.08,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Blog",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        myBlogItems.length.toString(),
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: height * 0.022,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: height * 0.05,
                ),
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ProfileEdit(),
                        ),
                      );
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                          top: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.person_pin_circle_outlined),
                            SizedBox(width: width * 0.02),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Танилцуулга",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height * 0.024,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Хэрэглэгчийн нэр, нас.. засах",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: height * 0.016,
                                      ),
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyInterest(),
                        ),
                      );
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.star_border),
                            SizedBox(width: width * 0.02),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Миний сонирхол",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height * 0.024,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Хэрэглэгчийн дуртай өнгө, хоол.. засах",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: height * 0.016,
                                      ),
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MyStatus(),
                        ),
                      );
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.group_outlined),
                            SizedBox(width: width * 0.02),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Миний бүлгэм",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height * 0.024,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Мэнтор, Дэлхийн Монголчууд.. засах",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: height * 0.016,
                                      ),
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
                Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      _signOut();
                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            width: 1.0,
                          ),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            const Icon(Icons.exit_to_app),
                            SizedBox(width: width * 0.02),
                            Expanded(
                              child: Column(
                                children: [
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Гарах",
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: height * 0.024,
                                      ),
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Системээс гарах",
                                      style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: height * 0.016,
                                      ),
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
                SizedBox(height: height * 0.1),
              ],
            ),
          ),
        ],
      );

  Widget _top(double height, double width) => SizedBox(
        height: height * 0.08,
        child: Padding(
          padding: EdgeInsets.only(
            left: width * 0.03,
            right: width * 0.03,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                ),
              ),
              Text(
                "ХЭРЭГЛЭГЧИЙН ХУУДАС",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.02,
                  fontWeight: FontWeight.w500,
                ),
              ),
              IconButton(
                icon: const Icon(
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
