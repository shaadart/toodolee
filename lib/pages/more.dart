import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';

class MorePage extends StatefulWidget {
  @override
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black54),
        elevation: 5,
        title: Text("More Page",
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black54,
            )),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 1.6,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                    child: Container(
                  alignment: Alignment.topLeft,
                  height: MediaQuery.of(context).size.height / 1,
                  decoration: BoxDecoration(
                      borderRadius:
                          BorderRadius.only(bottomLeft: Radius.circular(12)),
                      border: Border.all(color: Colors.blueAccent)),
                  child: Text("Ss"),
                )),
                Expanded(
                  child: Column(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(12)),
                              color: Colors.amber.withOpacity(0.4),
                              border: Border.all(color: Colors.blueAccent)),
                          child: Text("Ss"),
                        ),
                      ),
                      Expanded(
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(),
                            child: Center(
                              child: Text(
                                "4/10" + " : " + "🏃",
                                style: TextStyle(
                                    fontFamily: "Elsie",
                                    fontWeight: FontWeight.w900,
                                    fontSize: 30),
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          ListView(
            children: [
              ListTile(
                leading: Icon(
                  CarbonIcons.add,
                  color: Colors.red,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
