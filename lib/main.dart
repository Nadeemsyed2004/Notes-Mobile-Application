import 'package:crud_sqlite_joes/model/User.dart';
import 'package:crud_sqlite_joes/screens/EditUser.dart';
import 'package:crud_sqlite_joes/screens/AddUser.dart';
import 'package:crud_sqlite_joes/screens/viewUser.dart';
import 'package:crud_sqlite_joes/services/UserService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<User> _userList = <User>[];
  final _userService = UserService();

  getAllUserDetails() async {
    var users = await _userService.readAllUsers();
    _userList = <User>[];
    users.forEach((user) {
      setState(() {
        var userModel = User();
        userModel.id = user['id'];
        userModel.name = user['name'];
        userModel.contact = user['contact'];
        userModel.description = user['description'];
        _userList.add(userModel);
      });
    });
  }

  @override
  void initState() {
    getAllUserDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  _deleteFormDialog(BuildContext context, userId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Are You Sure to Delete',
              style: TextStyle(color: Colors.teal, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.red),
                  onPressed: ()  async{
                    var result=await _userService.deleteUser(userId);
                    if (result != null) {
                      Navigator.pop(context);
                      getAllUserDetails();
                      _showSuccessSnackBar(
                          'User Detail Deleted Success');
                    }
                  },
                  child: const Text('Delete')),
              TextButton(
                  style: TextButton.styleFrom(
                      primary: Colors.white, // foreground
                      backgroundColor: Colors.teal),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Close'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(hex("#414A45")),
        title: Text("          Nadeem's  Notes",
          style: TextStyle(
          fontFamily: "Satisfy",
          color: Colors.white,
          fontSize: 30,
        ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image:AssetImage("Assets/notes.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: ListView.builder(
            itemCount: _userList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      color: Color(hex("#F0EFE0")),
                    ),

                    child: ListTile(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ViewUser(
                                  user: _userList[index],
                                )));
                      },
                      leading: const Icon(Icons.person),
                      title: Text(_userList[index].name ?? ''),
                      subtitle: Text(_userList[index].contact ?? ''),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => EditUser(
                                          user: _userList[index],
                                        ))).then((data) {
                                  if (data != null) {
                                    getAllUserDetails();
                                    _showSuccessSnackBar(
                                        'User Detail Updated Success');
                                  }
                                });
                                ;
                              },
                              icon: const Icon(
                                Icons.update,
                                color: Colors.teal,
                              )),
                          IconButton(
                              onPressed: () {
                                _deleteFormDialog(context, _userList[index].id);
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(hex("#414A45")),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddUser()))
              .then((data) {
            if (data != null) {
              getAllUserDetails();
              _showSuccessSnackBar('User Detail Added Success');
            }
          });
        },
        child: const Icon(Icons.add,color: Colors.white,),
      ),
    );
  }
}
