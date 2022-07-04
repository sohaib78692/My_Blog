
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myblog/services/crud.dart';
import 'package:random_string/random_string.dart';

class CreateBlog extends StatefulWidget {
  const CreateBlog({Key? key}) : super(key: key);

  @override
  State<CreateBlog> createState() => _CreateBlogState();
}

class _CreateBlogState extends State<CreateBlog> {
    String authorName="", title="",desc="";
    var selectedImage;
    bool _isloading=false;
  CrudMethods crudMethods=CrudMethods();
  Future getImage() async{
    var image=await ImagePicker().pickImage(source:ImageSource.gallery);
    setState((){
      selectedImage= File(image!.path);
    });
  }
  uploadBlog()async{
    if(selectedImage!=null){
      setState(() {
        _isloading=true;
      });

      Reference firebaseStorageRef =FirebaseStorage.instance.ref().child("blogImage").child("${randomAlphaNumeric(9)}.jpg");
      final UploadTask task =firebaseStorageRef.putFile(selectedImage);
      var downloadUrl="";
      await task.whenComplete(() async  {
        downloadUrl = await firebaseStorageRef.getDownloadURL();
      } );
      Map<String,String> blogMap={
        "imgUrl": downloadUrl,
        "authorName":authorName,
        "title":title,
        "desc":desc
      };
      crudMethods.addData(blogMap).then((value){
        Navigator.pop(context);
      });
    }
    else{
      
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size size=MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(0, 0, 0, 0),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text("Create",
              style: TextStyle(
                fontSize: 22,
              ),),
              Text("Blog",
              style: TextStyle(
                fontSize: 22,
                color: Colors.blue
              ),),
            ],
          ),
          elevation: 0.0,
          actions: [
            GestureDetector(
              onTap: (){
                uploadBlog();
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const Icon((Icons.upload))),
            )
          ],
        ),
        body: _isloading? Container(
          alignment: Alignment.center,
          child: const CircularProgressIndicator(),
        ): Column(children: [
          const SizedBox(height: 10,),
          GestureDetector (
            onTap: () => getImage(),
            child: selectedImage != null?
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6)
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.file(selectedImage,fit: BoxFit.cover,)),
            )
            : Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              height: 150,
              width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(6)
              ),
              child: const Icon(Icons.add_a_photo),
            ),
          ),
          const SizedBox(height: 8,),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 10),
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 8.0,horizontal: 8),
              child: Column(children: [
                TextField(
                  decoration: InputDecoration(
                    hintText: "Author Name",
                    
                  ),
                  onChanged: (val){
                    authorName=val;
                  },
                ),
                TextField(
                  decoration: InputDecoration(
                    hintText: "Title",
                  ),
                  onChanged: (val){
                    title=val;
                  },
                ),
                TextField(
                  
                  style: TextStyle(
                    color: Colors.white,),
                  decoration: InputDecoration(
                    hintText: "Description",
                  ),
                  onChanged: (val){
                    desc=val;
                  },
                )
              ]),
            ),
          )
        ],),
      ),
    );
    
  }
}