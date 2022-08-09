import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freelance_dxb/cubit/add_category/add_category_cubit.dart';
import 'package:freelance_dxb/repositories/categories_repository.dart';
import 'package:freelance_dxb/style/colors.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../components/app_bar_actions_item.dart';
import '../components/side_menu.dart';
import 'add_category.dart';
import 'constraints.dart/textstyle.dart';
import 'edit_category.dart';

class CategoryHome extends StatefulWidget {
  const CategoryHome({Key? key}) : super(key: key);

  @override
  State<CategoryHome> createState() => _CategoryHomeState();
}

class _CategoryHomeState extends State<CategoryHome> {
  // Getting Student all Records

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: CategoriesRepository().categoryRecords,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something Wrong in categoryHome');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          // Storing Data
          final List subcategoriesData = [];
          final List firebaseData = [];
          snapshot.data?.docs.map((DocumentSnapshot documentSnapshot) {
            Map store = documentSnapshot.data() as Map<String, dynamic>;
            firebaseData.add(store);
            store['idcat'] = documentSnapshot.id;
          }).toList();

          return Scaffold(
            drawer: const SizedBox(
              width: 100,
              child: SideMenu(),
            ),
            appBar: AppBar(
              backgroundColor: bgColor,
              title: Text('category managment'.toUpperCase(),
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 46, 45, 45))),
              actions: const [AppBarActionItem()],
            ),
            body: Container(
              margin: const EdgeInsets.fromLTRB(10, 70, 10, 20),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Table(
                      border: TableBorder(
                          horizontalInside: BorderSide(
                              width: 1,
                              // color: Colors.blue,
                              style: BorderStyle.none)),
                      columnWidths: const <int, TableColumnWidth>{
                        1: FixedColumnWidth(150),
                      },
                      defaultVerticalAlignment:
                          TableCellVerticalAlignment.middle,
                      children: <TableRow>[
                        TableRow(
                          children: [
                            TableCell(
                              child: Container(
                                //color: Colors.greenAccent,
                                child: Center(
                                  child: Text(
                                    'designation',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 46, 45, 45)),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                //color: Colors.greenAccent,
                                child: Center(
                                  child: Text(
                                    'subcategories',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 46, 45, 45)),
                                  ),
                                ),
                              ),
                            ),
                            TableCell(
                              child: Container(
                                //color: Colors.greenAccent,
                                child: Center(
                                  child: Text(
                                    'Action',
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: Color.fromARGB(255, 46, 45, 45)),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        for (var i = 0; i < firebaseData.length; i++) ...[
                          TableRow(
                            children: [
                              TableCell(
                                child: SizedBox(
                                  child: Center(
                                    child: Text(
                                      firebaseData[i]['designation'],
                                      style: txt2,
                                    ),
                                  ),
                                ),
                              ),
                              TableCell(
                                  child: StreamBuilder(
                                      stream: CategoriesRepository()
                                          .getSubcategories(
                                              idcat: firebaseData[i]['idcat']),
                                      builder: (context,
                                          AsyncSnapshot<QuerySnapshot>
                                              streamSnapshott) {
                                        if (streamSnapshott.hasData) {
                                          snapshot.data?.docs.map(
                                              (DocumentSnapshot
                                                  documentSnapshott) {
                                            Map store = documentSnapshott.data()
                                                as Map<String, dynamic>;
                                            subcategoriesData.add(store);
                                            store['idsubcat'] =
                                                documentSnapshott.id;
                                          }).toList();
                                        }

                                        return Text(''
                                            //  subcategoriesData[i].toString()
                                            );
                                      })),
                              TableCell(
                                child: Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => EditPage(
                                              docID: firebaseData[i]['idcat'],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.orange,
                                      ),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        CategoriesRepository()
                                            .delete(firebaseData[i]['idcat']);
                                        //print(firebaseData);
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                        //this is loop
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(100, 300, 100, 100),
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BlocProvider(
                                create: (context) => AddCategoryCubit(),
                                child: AddCategoryPage(),
                              ),
                            ),
                          );
                        },
                        child: const Text('Add',
                            style: TextStyle(color: Colors.white)),
                      ),
                    )
                  ])),
            ),
          );
        });
  }
}
