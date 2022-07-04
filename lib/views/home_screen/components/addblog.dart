import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../createblog/create_blog.dart';

class addblog extends StatelessWidget {
  const addblog({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical:3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: (){
          Get.to(const CreateBlog());})
      ]),
    
    );
  }
}

