import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_series/ui/Auth/login.dart';
import 'package:firebase_series/ui/posts/add_post.dart';
import 'package:firebase_series/utilities/utils.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  final auth = FirebaseAuth.instance;
  final ref = FirebaseDatabase.instance.ref("post");
  final searchFilter = TextEditingController();
  final editController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Post")),
          actions: [
            IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LoginScreen(),
                      ));
                }).onError((error, stackTrace) {
                  Utils().toastMessage(error.toString());
                });
              },
              icon: const Icon(Icons.logout_outlined),
            )
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddPost(),
                ));
          },
          child: Icon(Icons.add),
        ),
        body: Column(
          children: [
            // Expanded(
            //   child: StreamBuilder(
            //       stream: ref.onValue,
            //       builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
            //         if (!snapshot.hasData) {
            //           return CircularProgressIndicator();
            //         } else {
            //           Map<dynamic, dynamic> map =
            //               snapshot.data!.snapshot.value as dynamic;
            //           List<dynamic> list = [];
            //           list.clear();
            //           list = map.values.toList();
            //           return ListView.builder(
            //               itemCount: snapshot.data!.snapshot.children.length,
            //               itemBuilder: (context, index) {
            //                 return ListTile(
            //                   title: Text(list[index]["title"]),
            //                   subtitle: Text(list[index]["id"]),
            //                 );
            //               });
            //         }
            //       }),
            // ),
            SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: TextFormField(
                controller: searchFilter,
                decoration: InputDecoration(
                  hintText: "Search",
                  border: OutlineInputBorder(),
                ),
                onChanged: (String value) {
                  setState(() {});
                },
              ),
            ),
            Expanded(
                child: FirebaseAnimatedList(
              query: ref,
              padding: const EdgeInsets.all(8.0),
              reverse: false,
              defaultChild: Text("loading"),
              itemBuilder: (context, snapshot, Animation, Index) {
                final title = snapshot.child("title").value.toString();
                if (searchFilter.text.isEmpty) {
                  return ListTile(
                    title: Text(
                      snapshot.child("title").value.toString(),
                    ),
                    subtitle: Text(
                      snapshot.child("id").value.toString(),
                    ),
                    trailing: PopupMenuButton(
                      itemBuilder: (context) => [
                        PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              leading: Icon(Icons.edit_outlined),
                              trailing: Text("Edit"),
                              onTap: () {
                                Navigator.pop(context);
                                showMyDialog(title,
                                    snapshot.child("id").value.toString());
                              },
                            )),
                        PopupMenuItem(
                            value: 2,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref.child(
                                    snapshot.child("id").value.toString()).remove();
                              },
                              leading: Icon(Icons.delete_outline),
                              trailing: Text("delete"),
                            ))
                      ],
                    ),
                  );
                } else if (title
                    .toLowerCase()
                    .contains(searchFilter.text.toLowerCase().toString())) {
                  return ListTile(
                    title: Text(
                      snapshot.child("title").value.toString(),
                    ),
                    subtitle: Text(
                      snapshot.child("id").value.toString(),
                    ),
                  );
                } else {
                  return Container();
                }
              },
            ))
          ],
        ));
  }

  Future<void> showMyDialog(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: "edit"),
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ref.child(id).update({
                    "title": editController.text.toLowerCase(),
                  }).then((value) {
                    Utils().toastMessage("Updated");
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error.toString());
                  });
                },
                child: Text("Update"))
          ],
        );
      },
    );
  }
}
