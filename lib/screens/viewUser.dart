import 'package:crud_sqlite_joes/model/User.dart';
import 'package:crud_sqlite_joes/screens/AddUser.dart';
import 'package:flutter/material.dart';

class ViewUser extends StatefulWidget {
  final User user;

  const ViewUser({Key? key, required this.user}) : super(key: key);

  @override
  State<ViewUser> createState() => _ViewUserState();
}

class _ViewUserState extends State<ViewUser> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(hex("#E18B43")),
          title:  Text("Nadeem's  Notes",
            style: TextStyle(
              fontFamily: "Satisfy",
              fontSize: 30,
              color: Color(hex("#65393A"))
            ),),
        ),
        body: Container(
          color: Color(hex("#F0EFE0")),
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: Text(
                  "Full Details",
                  style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Color(hex("#65393A")),
                      fontSize: 21),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Name',
                      style: TextStyle(
                          color: Color(hex("#65393A")),
                          fontSize: 19,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Text(widget.user.name ?? '', style: TextStyle(fontSize: 18,
                      color: Color(hex("#414A45")),)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text('Contact',
                      style: TextStyle(
                          color: Color(hex("#65393A")),
                          fontSize: 19,
                          fontWeight: FontWeight.w600)),
                  Padding(
                    padding: const EdgeInsets.only(left: 25),
                    child: Text(widget.user.contact ?? '', style: TextStyle(fontSize: 18,
                      color: Color(hex("#414A45")),)),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Description',
                      style: TextStyle(
                          color: Color(hex("#65393A")),
                          fontSize: 19,
                          fontWeight: FontWeight.w600)),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(widget.user.description ?? '', style: TextStyle(fontSize: 18,
                    color: Color(hex("#414A45")),)),
                ],
              )
            ],
          ),
        ));
  }
}
