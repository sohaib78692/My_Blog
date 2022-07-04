import 'package:flutter/material.dart';

class TileBox extends StatelessWidget {
  const TileBox({Key? key,
  required this.imgUrl,
  required this.title, 
  required this.authorName,
  required this.desc}) : super(key: key);

  final String imgUrl,title,authorName,desc;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(16),
        child:Stack(
          children: <Widget>[
          
            ClipRRect(child: Image.network(imgUrl,
            height: 170,
            width: 500,
            fit:BoxFit.fill,
            ),
            borderRadius: BorderRadius.circular(6),),
            Container(
              height:170,
              decoration:BoxDecoration(color:Colors.black45.withOpacity(0.3),
              borderRadius: BorderRadius.circular(6))
            ),
            Container(
              width: 500,
              child:Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                Container(
                  margin: EdgeInsets.only(top:30),
                                  child: Text(title,
                  style:TextStyle(
                    fontSize:22,
                    fontWeight:FontWeight.w500
                  ),),
                ),
                SizedBox(height:4),
                Text(desc,style: TextStyle(
                  fontSize:17,
                  fontWeight:FontWeight.w400
                ),),
                SizedBox(height:4),
                Text(authorName)
              ],)
            )
          ],
        )
    );
  }
}