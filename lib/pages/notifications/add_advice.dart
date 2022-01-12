// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io';

import 'package:check/helpers/api_url.dart';
import 'package:check/helpers/app_preferences.dart';
import 'package:check/models/home_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as https;
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';
import '../../constants.dart';
import '../../data.dart';

class AddAdviceData {
  static int _selectedCategoryIndex = 0;
}

class AddAdvice extends StatefulWidget {
  const AddAdvice({Key? key}) : super(key: key);

  @override
  _AddAdviceState createState() => _AddAdviceState();
}

class _AddAdviceState extends State<AddAdvice> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final _titleTEC = TextEditingController();
  final _contentTEC = TextEditingController();
  late File _image = File("");
  bool _isFree = true;
  ImagePicker picker = ImagePicker();
  bool _isLoad = false;

  _uploadAdvice() async {
    try {
      // var pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (_image.path.isNotEmpty) {
        // var byteData = await images.readAsBytes();
        Uri apiUrl = Uri.parse(mainApiUrl + "upload-advice");
        final mimeTypeData =
            lookupMimeType(_image.path, headerBytes: [0xFF, 0xD8])?.split('/');
        // Intilize the multipart request
        final imageUploadRequest = https.MultipartRequest('POST', apiUrl);
        // Attach the file in the request
        final file = await https.MultipartFile.fromPath(
          'cover',
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
        String _free;
        if (_isFree) {
          _free = "free";
        } else {
          _free = "premium";
        }
        imageUploadRequest.headers.addAll(headers);
        imageUploadRequest.files.add(file);
        imageUploadRequest.fields['owner_id'] = currentUserId;
        imageUploadRequest.fields['url'] = url;
        imageUploadRequest.fields['owner_name'] = currentUserName;
        imageUploadRequest.fields['owner_avatar'] = currentUserAvatar;
        imageUploadRequest.fields['content'] = _contentTEC.text;
        imageUploadRequest.fields['title'] = _titleTEC.text;
        imageUploadRequest.fields["is_free"] = _free;
        imageUploadRequest.fields['category_id'] =
            adviceCategoryItems[AddAdviceData._selectedCategoryIndex]
                .id
                .toString();
        imageUploadRequest.fields['category_text'] =
            adviceCategoryItems[AddAdviceData._selectedCategoryIndex]
                .title
                .toString();
        imageUploadRequest.fields['category_image'] =
            adviceCategoryItems[AddAdviceData._selectedCategoryIndex]
                .image
                .toString();
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
                homeItems.clear();
                List fetchItem = [];
                final items =
                    json.encode(json.decode(response.body)["advices"]);
                fetchItem = json.decode(items);
                for (var element in fetchItem) {
                  HomeModel homeModel = HomeModel(
                    id: element["id"].toString(),
                    title: element["title"].toString(),
                    image: element["image"].toString(),
                    advices: element["advice"] ?? [],
                  );
                  homeItems.add(homeModel);
                }
                goHome(context);
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

  Future getImage() async {
    var pickedFile = await picker.getImage(
        source: ImageSource.gallery,
        imageQuality: 70,
        maxHeight: 1024.0,
        maxWidth: 1650.0);

    if (pickedFile != null) {
      _image = File(pickedFile.path);
      setState(() {});
      print(_image.toString());
    } else {
      print('No image selected.');
    }
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
                _body(height, width),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _body(double height, double width) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: height * 0.2,
            child: Padding(
              padding: const EdgeInsets.all(28.0),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 10),
                    ),
                  ],
                ),
                child: _image.path.isNotEmpty
                    ? InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                            ),
                            child: FittedBox(
                              fit: BoxFit.cover,
                              child: Image.file(_image),
                            ),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          getImage();
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.black.withOpacity(0.5),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(Icons.camera_alt_rounded),
                              Text("Select photo"),
                            ],
                          ),
                        ),
                      ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.03,
              right: width * 0.06,
              left: width * 0.06,
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const MyDialog();
                        });
                  },
                  child: Container(
                    height: height * 0.06,
                    width: width,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: ButtonTheme(
                        alignedDropdown: true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8, right: 6),
                          child: DropdownButton<String>(
                            hint: const Text("Ангилал сонгох"),
                            iconSize: 24,
                            elevation: 16,
                            style: const TextStyle(color: Colors.black),
                            onChanged: null,
                            items: const [],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 28.0,
              left: 28.0,
              top: 12.0,
            ),
            child: TextField(
              controller: _titleTEC,
              decoration: const InputDecoration(
                hintText: "Гарчиг..",
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 28.0,
              left: 28.0,
              top: 12.0,
            ),
            child: TextField(
              controller: _contentTEC,
              maxLength: 2500,
              maxLines: 10,
              decoration: const InputDecoration(
                hintText: "Мэдээлэл..",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              top: height * 0.01,
              left: 28.0,
              right: 28.0,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    if (_isFree) const Text("Үнэгүй"),
                    if (!_isFree) const Text("Premium"),
                    Switch(
                      value: _isFree,
                      activeColor: kPrimaryColor,
                      onChanged: (value) {
                        setState(() {
                          _isFree = value;
                        });
                      },
                    ),
                  ],
                ),
                if (_isFree)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Бүх хэрэглэгч үзэх боломжтой"),
                  ),
                if (!_isFree)
                  const Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Зөвхөн premium хэрэглэгч үзэх боломжтой"),
                  ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: 28.0,
              left: 28.0,
              top: height * 0.04,
              bottom: 48.0,
            ),
            child: InkWell(
              onTap: () {
                _uploadAdvice();
              },
              child: Container(
                height: height * 0.06,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: kLightColor,
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoad)
                      SizedBox(
                        height: height * 0.03,
                        width: height * 0.03,
                        child: const CircularProgressIndicator(
                          strokeWidth: 1.2,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        ),
                      ),
                    if (!_isLoad)
                      Text(
                        "НИЙТЛЭХ",
                        style: TextStyle(
                          fontSize: height * 0.02,
                          fontFamily: 'fsf',
                          color: Colors.white,
                        ),
                      ),
                  ],
                ),
              ),
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
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.black,
                ),
              ),
              Text(
                "ЗӨВЛГӨӨ НИЙТЛЭХ",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: height * 0.018,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const IconButton(
                icon: Icon(
                  Icons.upload_rounded,
                  color: Colors.transparent,
                ),
                onPressed: null,
              ),
            ],
          ),
        ),
      );
}

class MyDialog extends StatefulWidget {
  const MyDialog({Key? key}) : super(key: key);
  @override
  _MyDialogState createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      insetPadding: const EdgeInsets.all(0.0),
      actions: [
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("ХААХ"),
        ),
      ],
      content: Builder(builder: (context) {
        return SizedBox(
          width: width * 0.8,
          // height: height * 0.8,
          child: SingleChildScrollView(
            child: Wrap(
              children: List.generate(
                adviceCategoryItems.length,
                (index) => Padding(
                  padding: EdgeInsets.only(
                    bottom: height * 0.005,
                    top: height * 0.005,
                  ),
                  child: SizedBox(
                    height: height * 0.06,
                    child: Row(
                      children: [
                        Checkbox(
                          activeColor: kPrimaryColor.withOpacity(0.8),
                          onChanged: (value) {
                            setState(() {
                              if (value!) {
                                for (int i = 0;
                                    i < adviceCategoryItems.length;
                                    i++) {
                                  adviceCategoryItems[i].isSelect = false;
                                }
                                adviceCategoryItems[index].isSelect = value;
                                AddAdviceData._selectedCategoryIndex = index;
                              } else {
                                adviceCategoryItems[index].isSelect = value;
                              }
                            });
                          },
                          value: adviceCategoryItems[index].isSelect,
                        ),
                        Text(
                          adviceCategoryItems[index].title.toString(),
                          style: const TextStyle(
                            fontSize: 20,
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
      }),
    );
  }
}
