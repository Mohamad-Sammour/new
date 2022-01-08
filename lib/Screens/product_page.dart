import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:untitled/Widget/custom_action_bar.dart';
import 'package:untitled/Widget/image_swipe.dart';
import 'package:untitled/constants.dart';

class ProductPage extends StatefulWidget {

   final String? productId;

   ProductPage({this.productId});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final CollectionReference _productRef =
      FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          FutureBuilder(
            future: _productRef.doc(widget.productId).get(),
            builder: (context, snapshot){
                if(snapshot.hasError) {
                  return Scaffold(
                    body: Center(
                      child: Text("Error :${snapshot.error}"),
                    ),
                  );
                }

                if(snapshot.connectionState==ConnectionState.done){
                  Map<String, dynamic> documentData = snapshot.data.data();

                  List imagesList = documentData['images'];

                  return ListView(
                    padding: EdgeInsets.all(0),
                    children: [
                      ImageSwip(imageList: imagesList,),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 24.0,
                          left: 24.0,
                          right: 24.0,
                          bottom: 4.0,
                        ),
                        child: Text("${documentData['name']}",
                        style: Constants.boldHeading,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text("\$${documentData['price']}",
                        style: TextStyle(
                          fontSize: 18.0,
                          color: Theme.of(context).accentColor,
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 8.0,
                          horizontal: 24.0,
                        ),
                        child: Text("${documentData['desc']}",
                        style: TextStyle(
                          fontSize: 16.0,
                        ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          vertical: 24.0,
                          horizontal: 24.0,
                        ),
                        child: Text("Select Size",
                        style: Constants.regularDarkText,
                        ),
                      ),

                    ],
                  );
                }


                return Scaffold(
                  body: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
            },
          ),

          CustomActionBar(
            HasBackArrow:true,
            hasTitle: false,
            hasBackground: false,
          ),
        ],
      ),
    );
  }
}
