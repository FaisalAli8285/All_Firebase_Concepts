import 'package:firebase_series/firestore/add_firestore_data.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_series/ui/Auth/login.dart';
import 'package:firebase_series/ui/posts/add_post.dart';
import 'package:firebase_series/utilities/utils.dart';

class FireStoreList extends StatefulWidget {
  const FireStoreList({super.key});

  @override
  State<FireStoreList> createState() => _FireStoreListState();
}

class _FireStoreListState extends State<FireStoreList> {
  final auth = FirebaseAuth.instance;
  final editController = TextEditingController();
  final firestore = FirebaseFirestore.instance.collection("User").snapshots();
  CollectionReference ref = FirebaseFirestore.instance.collection("User");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("FireStore Post")),
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
                  builder: (context) => AddFireStoreDataScreen(),
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
            StreamBuilder<QuerySnapshot>(
                stream: firestore,
                builder: ((BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text("Some Error");
                  }

                  return Expanded(
                      child: ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      final title =
                          snapshot.data!.docs[index]["title"].toString();
                      return ListTile(
                        onTap: () {
                          // ref
                          //     .doc(snapshot.data!.docs[index]["id"].toString())
                          //     .update({"title": "hero"}).then((value) {
                          //   Utils().toastMessage("Updated");
                          // }).onError((error, stackTrace) {
                          //   Utils().toastMessage(error.toString());
                          // });
                          ref
                              .doc(snapshot.data!.docs[index]["id"].toString())
                              .delete();
                        },
                        title: Text(
                            snapshot.data!.docs[index]["title"].toString()),
                        subtitle:
                            Text(snapshot.data!.docs[index]["id"].toString()),
                        trailing: PopupMenuButton(
                          icon: Icon(Icons.more_vert),
                          itemBuilder: (context) => [
                            PopupMenuItem(
                                value: 1,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    showMyDialogueBox(
                                        title,
                                        snapshot.data!.docs[index]["id"]
                                            .toString());
                                  },
                                  leading: Icon(Icons.edit_outlined),
                                  title: Text("Edit"),
                                )),
                            PopupMenuItem(
                                value: 2,
                                child: ListTile(
                                  onTap: () {
                                    Navigator.pop(context);
                                    ref
                                        .doc(snapshot.data!.docs[index]["id"]
                                            .toString())
                                        .delete();
                                  },
                                  leading: Icon(Icons.delete_outline),
                                  title: Text("Delete"),
                                ))
                          ],
                        ),
                      );
                    },
                  ));
                })),
          ],
        ));
  }

  Future<void> showMyDialogueBox(String title, String id) async {
    editController.text = title;
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Update"),
          content: Container(
            child: TextField(
              controller: editController,
              decoration: InputDecoration(hintText: "Edit here"),
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
                  ref.doc(id).update({
                    'title': editController.text.toLowerCase(),
                  }).then((value) {
                    Utils().toastMessage("updated");
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
