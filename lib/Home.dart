import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eploy/Information.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  final TextEditingController _searchController = TextEditingController();
  final FocusNode focusNode = FocusNode();

  bool _searchBoolean = false;
  var snapshot =FirebaseFirestore.instance
      .collection('services')
      .snapshots();

  Widget _searchTextField() {
    return TextFormField(
      onChanged: (text) {
        text = text.toLowerCase();
        setState(() {
          if(text.isNotEmpty)
          snapshot = FirebaseFirestore.instance
              .collection('services').where('service', isEqualTo: text)
              .snapshots();
        });
      },
      focusNode: focusNode,
      autofocus: true,
      controller: _searchController,
      cursorColor: Colors.white,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white60,
          fontSize: 20,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final currentContext = context; // Save the reference to the current context

 
    return Scaffold(
      appBar: AppBar(
        title:  !_searchBoolean ?
        Text('Home') : _searchTextField(),
        actions: !_searchBoolean
            ? [
          IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  _searchBoolean = true;
                });
              })
        ]
            : [
          IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  _searchBoolean = false;
                  _searchController.clear();
                  snapshot =FirebaseFirestore.instance
                      .collection('services')
                      .snapshots();
                });
              })
        ],
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 150,
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://www.moniengineeringworks.com/images/banner-1.jpg',
                  ),
                ),
                color: Colors.cyanAccent,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Related Services',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text(
                  'View All',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
            SizedBox(height: 10),
            SizedBox(
              height: 310,
              child: StreamBuilder<QuerySnapshot>(
                stream: snapshot,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Text("Loading");
                  }

                  return ListView(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    children:
                        snapshot.data!.docs.map((DocumentSnapshot document) {
                      Map<String, dynamic> data =
                          document.data()! as Map<String, dynamic>;
                      return Container(
                        width: 200,
                        height: 300,
                        margin: EdgeInsets.only(right: 10),
                        decoration: BoxDecoration(
                          color: Colors.white70,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        clipBehavior: Clip.hardEdge,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            CachedNetworkImage(
                              imageUrl: data['image'],
                              progressIndicatorBuilder:
                                  (context, url, progress) {
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    CircularProgressIndicator(
                                        value: progress.progress),
                                  ],
                                );
                              },
                              fit: BoxFit.cover,
                              errorWidget: (context, url, error) {
                                return Icon(Icons.error);
                              },
                            ),
                            Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.transparent,
                                    Colors.black,
                                    Colors.black,
                                  ],
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0, 1, 1],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                padding: EdgeInsets.all(5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      data['service'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    Text(
                                      data['location'],
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    Text(
                                      data['price'].toString(),
                                      style: TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    Container(
                                      width: double.infinity,
                                      child: OutlinedButton(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Hire'),
                                            Icon(
                                              Icons.arrow_right,
                                              size: 20,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        onPressed: () {
                                          Navigator.push(
                                            currentContext,
                                            // Use the saved context
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Information()),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            )
            // Expanded(
            //   child: ListView.builder(
            //     scrollDirection: Axis.horizontal,
            //     shrinkWrap: true,
            //     physics: const ScrollPhysics(),
            //     itemCount: 5,
            //     itemBuilder: (index, context) {
            //       return Container(
            //         width: 160,
            //         margin: EdgeInsets.only(right: 10),
            //         decoration: BoxDecoration(
            //           color: Colors.white70,
            //           borderRadius: BorderRadius.circular(10),
            //         ),
            //         child: Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: [
            //             Expanded(
            //               flex: 2,
            //               child: CachedNetworkImage(
            //                 imageUrl: 'https://www.vhv.rs/dpng/d/126-1261776_plumbing-installation-amp-plumber-images-png-transparent-png.png',
            //                 progressIndicatorBuilder: (context, url, progress) {
            //                   return CircularProgressIndicator(value: progress.progress);
            //                 },
            //                 errorWidget: (context, url, error) {
            //                   return Icon(Icons.error);
            //                 },
            //               ),
            //             ),
            //             Expanded(
            //               child: Padding(
            //                 padding: const EdgeInsets.all(8.0),
            //                 child: Column(
            //                   crossAxisAlignment: CrossAxisAlignment.start,
            //                   children: [
            //                     Text(
            //                       'Plumber',
            //                       style: TextStyle(
            //                         color: Colors.grey,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                     ),
            //                     Text(
            //                       'Kandy',
            //                       style: TextStyle(
            //                         color: Colors.grey,
            //                       ),
            //                     ),
            //                     Text(
            //                       'Rs.3000',
            //                       style: TextStyle(
            //                         color: Colors.grey,
            //                       ),
            //                     ),
            //                     SizedBox(height: 10),
            //                     Container(
            //                       width: double.infinity,
            //                       child: OutlinedButton(
            //                         child: Row(
            //                           mainAxisAlignment: MainAxisAlignment.center,
            //                           children: [
            //                             Text('Hire'),
            //                             Icon(
            //                               Icons.arrow_right,
            //                               size: 20,
            //                               color: Colors.blue,
            //                             ),
            //                           ],
            //                         ),
            //                         onPressed: () {
            //                           Navigator.push(
            //                             currentContext, // Use the saved context
            //                             MaterialPageRoute(builder: (context) => Information()),
            //                           );
            //                         },
            //                       ),
            //                     ),
            //                   ],
            //                 ),
            //               ),
            //             )
            //           ],
            //         ),
            //       );
            //     },
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
