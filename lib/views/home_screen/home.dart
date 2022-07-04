import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myblog/services/crud.dart';
import 'components/addblog.dart';
import 'components/tilebox.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = CrudMethods();
  QuerySnapshot? blogsnapshot;

  @override
  void initState() {
    super.initState();
    crudMethods.getData().then((result) {
      blogsnapshot = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                "Flutter",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              Text(
                "Blog",
                style: TextStyle(fontSize: 22, color: Colors.blue),
              )
            ],
          ),
          backgroundColor: const Color.fromARGB(0, 0, 0, 0),
          elevation: 0.0,
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance.collection('blogs').snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    alignment: Alignment.center,
                    child: const CircularProgressIndicator());
              }
              return ListView(
                  physics: const BouncingScrollPhysics(),
                  children: snapshot.data!.docs.map((document) {
                    return TileBox(
                      imgUrl: document["imgUrl"],
                      title: document["title"],
                      desc: document["desc"],
                      authorName: document["authorName"],
                    );
                  }).toList());
            }),
        floatingActionButton: const addblog(),
      ),
    );
  }
}
