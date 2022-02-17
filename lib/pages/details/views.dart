import 'package:flutter/material.dart';


class Details extends StatefulWidget {
  const Details({ Key? key }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title:Text("Details"),backgroundColor:  Color(0xffc6782b),),
        body:Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height:200,
                child: Image.network("https://anongulam.s3.amazonaws.com/pic19.png",fit:BoxFit.cover)
              )
            ],
          ),
    )
    );
  }
}