import 'package:firebase_auth/firebase_auth.dart';
import 'package:freelance_dxb/repositories/offer_repository.dart';
import 'package:freelance_dxb/screens/layout/home_layout.dart';
import 'package:freelance_dxb/screens/offer/fetch_offers.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../models/offer_model.dart';
import '../../style/colors.dart';
import '../../style/style.dart';

class UpdateOffer extends StatefulWidget {
  const UpdateOffer({Key? key, required this.offer});
  final Offer offer;

  @override
  _UpdateOfferState createState() => _UpdateOfferState();
}

class _UpdateOfferState extends State<UpdateOffer> {
  TextEditingController _idController = TextEditingController();

  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController dateinputend = TextEditingController();
  TextEditingController dateinputstart = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isUpdating = false;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.offer.title!;
    _descriptionController.text = widget.offer.description!;
    _priceController.text = widget.offer.price!;
    dateinputend.text = widget.offer.endDate!;
    dateinputstart.text = widget.offer.startDate!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
        ),
        body: Padding(
            padding: EdgeInsets.fromLTRB(10, 10, 10, 30),
            child: SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 50.0,
                      bottom: 50.0,
                      left: 0.0,
                      right: 100.0,
                    ),
                    child: Center(
                      child: Text(
                        'Update Freelance  offer',
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                          color: Color.fromARGB(255, 5, 5, 5),
                        ),
                      ),
                    ),
                  ),
                  Container(
                      alignment: Alignment.bottomCenter,
                      //  padding: const EdgeInsets.fromLTRB(20, 10, 300, 0),
                      child: Column(children: [
                        Container(
                            height: MediaQuery.of(context).size.height * 0.95,
                            width: MediaQuery.of(context).size.width,
                            color: bgColor,
                            child: Center(
                                child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 0.0,
                                      horizontal: 20.0,
                                    ),
                                    child: Form(
                                      key: _formKey,
                                      child: Column(
                                        children: <Widget>[
                                          TextField(
                                            style: TextStyle(fontSize: 18),
                                            controller: _titleController,
                                            decoration: InputDecoration(
                                                labelText: 'Title',
                                                hintText: ' enter title',
                                                hintStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromARGB(
                                                        255, 180, 174, 174)),
                                                labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 240, 67, 67),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                          SizedBox(height: 16.0),
                                          TextField(
                                        style: TextStyle(fontSize: 18),
                                            maxLines: 8,
                                            controller: _descriptionController,
                                            decoration: InputDecoration(
                                                labelText: 'Description',
                                                hintText: ' enter description',
                                                hintStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromARGB(
                                                        255, 180, 174, 174)),
                                                labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 240, 67, 67),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                ), // labelText: 'Enter description',
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 114, 112, 112)),
                                                  borderRadius:
                                                      BorderRadius.circular(15),
                                                ),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                        borderSide:
                                                            const BorderSide(
                                                                width: 1,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        114,
                                                                        112,
                                                                        112)))),
                                          ),
                                          SizedBox(height: 16.0),
                                          TextField(
                                           style: TextStyle(fontSize: 18),
                                            controller: _priceController,
                                            decoration: InputDecoration(
                                                labelText: 'Offer price',
                                                hintText: ' enter price',
                                                hintStyle: TextStyle(
                                                    fontSize: 12.0,
                                                    color: Color.fromARGB(
                                                        255, 180, 174, 174)),
                                                labelStyle: const TextStyle(
                                                  color: Color.fromARGB(
                                                      255, 240, 67, 67),
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w400,
                                                )),
                                          ),
                                          SizedBox(height: 16.0),
                                          TextField(
                                                 style: TextStyle(fontSize: 18),
                                            controller:
                                                dateinputstart, //editing controller of this TextField
                                            decoration: InputDecoration(
                                              labelText: 'start date',
                                              hintText: ' enter date',
                                              hintStyle: TextStyle(
                                                  fontSize: 12.0,
                                                  color: Color.fromARGB(
                                                      255, 180, 174, 174)),
                                              labelStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 240, 67, 67),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 114, 112, 112)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 114, 112, 112))),
                                              icon: Icon(Icons
                                                  .calendar_today), //icon of text field
                                              //label text of field
                                            ),
                                            readOnly:
                                                true, //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(
                                                          2000), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2101));

                                              if (pickedDate != null) {
                                                print(
                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                print(
                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement

                                                setState(() {
                                                  dateinputstart.text =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {
                                                print("Date is not selected");
                                              }
                                            },
                                          ),
                                          SizedBox(height: 16.0),
                                          TextField(
                                   style: TextStyle(fontSize: 18),
                                            controller:
                                                dateinputend, //editing controller of this TextField
                                            decoration: InputDecoration(
                                              labelText: 'end date',
                                              hintText: ' enter date',
                                              hintStyle: TextStyle(
                                                  fontSize: 18.0,
                                                  color: Color.fromARGB(
                                                      255, 180, 174, 174)),
                                              labelStyle: const TextStyle(
                                                color: Color.fromARGB(
                                                    255, 240, 67, 67),
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400,
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: const BorderSide(
                                                    width: 1,
                                                    color: Color.fromARGB(
                                                        255, 114, 112, 112)),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              focusedBorder: OutlineInputBorder(
                                                  borderSide: const BorderSide(
                                                      width: 1,
                                                      color: Color.fromARGB(
                                                          255, 114, 112, 112))),
                                              icon: Icon(Icons
                                                  .calendar_today), //icon of text field
                                              //label text of field
                                            ),
                                            readOnly:
                                                true, //set it true, so that user will not able to edit text
                                            onTap: () async {
                                              DateTime? pickedDate =
                                                  await showDatePicker(
                                                      context: context,
                                                      initialDate:
                                                          DateTime.now(),
                                                      firstDate: DateTime(
                                                          2000), //DateTime.now() - not to allow to choose before today.
                                                      lastDate: DateTime(2101));

                                              if (pickedDate != null) {
                                                print(
                                                    pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                                String formattedDate =
                                                    DateFormat('yyyy-MM-dd')
                                                        .format(pickedDate);
                                                print(
                                                    formattedDate); //formatted date output using intl package =>  2021-03-16
                                                //you can implement different kind of Date Format here according to your requirement

                                                setState(() {
                                                  dateinputend.text =
                                                      formattedDate; //set output date to TextField value.
                                                });
                                              } else {
                                                print("Date is not selected");
                                              }
                                            },
                                          ),
                                          SizedBox(height: 16.0),
                                          isUpdating
                                              ? CircularProgressIndicator()
                                              : ElevatedButton(
                                                  style: startBtnStyle,
                                                  onPressed: () {
                                                    Navigator.of(context).push(
                                                      MaterialPageRoute(
                                                          builder: (BuildContext
                                                                  context) =>
                                                              HomeLayout()),
                                                    );

                                                    setState(() {
                                                      isUpdating = true;
                                                      OfferRepository().updateOffer(
                                                      
                                                          _titleController.text,
                                                          widget.offer.id!,
                                                          _descriptionController
                                                              .text,
                                                          dateinputend.text,
                                                          dateinputstart.text,
                                                          _priceController
                                                              .text,
                                                                FirebaseAuth.instance.currentUser!.uid,
                                                              );
                                                    });
                                                  },
                                                  child: Text('Update ',
                                                      style: TextStyle(
                                                          fontSize: 25.0,
                                                          color: Colors.white)),
                                                ),
                                        ],
                                      ),
                                    ))))
                      ]))
                ]))));
  }
}
