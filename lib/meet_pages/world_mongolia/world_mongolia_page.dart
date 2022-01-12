import 'package:flutter/material.dart';

class WorldMogoliaPage extends StatefulWidget {
  const WorldMogoliaPage({Key? key}) : super(key: key);

  @override
  _WorldMogoliaPageState createState() => _WorldMogoliaPageState();
}

class _WorldMogoliaPageState extends State<WorldMogoliaPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        child: SafeArea(
          child: Column(
            children: [
              _top(size),
              _body(size),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(Size size) => Column(
        children: [],
      );

  Widget _top(Size size) => SizedBox(
        width: size.width * 0.9,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              icon: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.arrow_back,
                    size: size.height * 0.024,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Text(
              "Дэлхийн Монголчууд",
              style: TextStyle(
                fontSize: size.height * 0.02,
                fontWeight: FontWeight.bold,
              ),
            ),
            IconButton(
              onPressed: null,
              icon: Container(
                height: size.height * 0.05,
                width: size.height * 0.05,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: Colors.grey.withOpacity(0.1),
                ),
                child: Center(
                  child: Icon(
                    Icons.cached,
                    size: size.height * 0.024,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
}
