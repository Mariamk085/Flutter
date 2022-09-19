import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'model/trasnportresponce.dart';

class Transportpage extends StatefulWidget {
  Transportpage({
    Key? key,
  }) : super(key: key);

  @override
  State<Transportpage> createState() => _TransportpageState();
}

class _TransportpageState extends State<Transportpage> {
  List<Transport> transportlist = [];
  get pollingstationlist => null;

  Future<List<dynamic>> Service() async {
    // print(widget.pollingstation.pollingstationID);

    var url = Uri.parse("http://api.cwiztech.com:8079/v1/apigateway");
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer f2096082-4db4-4b80-96f4-57b5526be9bc"
        },
        body: jsonEncode({
          "request_BODY": "{}",
          "request_TYPE": "GET",
          "request_URI": "transportroute",
          "service_NAME": "TRANSPORT"
        }));
    // print(response.body);
    List<dynamic> responselist = [];
    responselist = jsonDecode(response.body);
    print(responselist[0]);
    // print(responselist.length);
    // // print(responselist[0]);
    // TransportR t = TransportR.fromJson(responselist[0]);
    // TransportColor c = TransportColor.fromJson(t.colorid);
    // print(c.desc);
    // //print(response.body);
    // return response.body;
    return responselist;
  }

  Future<List<dynamic>>? _calculation;
  void initState() {
    _calculation = Service();
    // print(_calculation);
  }

  @override
  Widget build(BuildContext context) {
    var style;
    return Scaffold(
      body: Column(
        children: [
          Container(
            
            decoration: BoxDecoration(
              color: Colors.blue.shade300,
              
               //boxShadow: [
               //  BoxShadow(
                //    color: kDarkGreyColor,
                 //    blurRadius: 0,
                  //  offset: Offset(0, 0)),
              // ]),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                child: Text(
                  "Transport",
                ),
              ),
            ),
          ),
          Container(
            child: FutureBuilder<List<dynamic>>(
              future: _calculation,
              builder: (
                BuildContext context,
                AsyncSnapshot<List<dynamic>> snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasError) {
                    return const Text('Error');
                  } else if (snapshot.hasData) {
                    for (int i = 0; i < snapshot.data!.length; i++) {
                      TransportR t = TransportR.fromJson(snapshot.data![i]);
                      TransportColor c = TransportColor.fromJson(t.colorid);
                      Transport transport = Transport();
                      transport.code = t.code;
                      transport.desc = t.desc;
                      transport.type = t.type;
                      transport.id = t.id;
                      transport.colordesc = c.desc;
                      transportlist.add(transport);
                    }

                    // TransportColor list1 = [];
                    //  List<dynamic> responselist = [];
                    // responselist = jsonDecode(snapshot.data);
                    // print(responselist.length);
                    // print(responselist[0]);
                    // TransportR t = TransportR.fromJson(responselist[0]);
                    // TransportColor c = TransportColor.fromJson(t.colorid);
                    // print(c.desc);
                    //print(response.body);
                    return Container(
                      height: 675,
                      child: ListView.builder(
                        itemCount: snapshot.data!.length,
                        //  responselist.length,
                        itemBuilder: (context, position) {
                          // ignore: prefer_typing_uninitialized_variables
                          var style;
                          return Card(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                              child: ListTile(
                                title: Text(
                                    "${transportlist[position].desc.toString()}  ${transportlist[position].colordesc.toString()}"),
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Row(
                                //       children: [
                                //         Expanded(
                                //           child: Text(
                                //             candidatelist[position]
                                //                 .politicalPartyName
                                //                 .toString(),
                                //             overflow: TextOverflow.clip,
                                //             style: GoogleFonts.poppins(
                                //               textStyle: style,
                                //               fontSize: 13,
                                //               fontWeight: FontWeight.w500,
                                //               letterSpacing: 0.5,
                                //               color: kBlackColor,
                                //             ),

                                //             // a.description.toString()
                                //           ),
                                //         ),
                                //         // Image.asset(
                                //         //   'assets/images/k.png',
                                //         //   width: 30,
                                //         //   height: 30,
                                //         // ),
                                //       ],
                                //     ),
                                //     Row(
                                //       children: [
                                //         // Text(
                                //         //   "Constituency Name:",
                                //         //   style: GoogleFonts.poppins(
                                //         //     textStyle: style,
                                //         //     fontSize: 14,
                                //         //     fontWeight: FontWeight.w400,
                                //         //     letterSpacing: 0.5,
                                //         //     color: kBlackColor,
                                //         //   ),
                                //         // ),

                                //         Text(
                                //           candidatelist[position]
                                //               .candidateforenames
                                //               .toString(),
                                //           // b.contituencyCODE.toString(),
                                //           style: GoogleFonts.poppins(
                                //             textStyle: style,
                                //             fontSize: 13,
                                //             fontWeight: FontWeight.w400,
                                //             letterSpacing: 1,
                                //             color: kPrimaryColor,
                                //           ),
                                //         ),
                                //         SizedBox(
                                //           width: 2,
                                //         ),
                                //         Text(
                                //           candidatelist[position]
                                //               .candidatesurname
                                //               .toString(),
                                //           style: GoogleFonts.poppins(
                                //             textStyle: style,
                                //             fontSize: 13,
                                //             fontWeight: FontWeight.w400,
                                //             letterSpacing: 0.5,
                                //             color: kPrimaryColor,
                                //           ),
                                //           // a.description.toString()
                                //         ),
                                //       ],
                                //     ),
                                //     Text(
                                //       candidatelist[position]
                                //           .politicalpartySYMBOL
                                //           .toString(),
                                //       overflow: TextOverflow.clip,
                                //       style: GoogleFonts.poppins(
                                //         textStyle: style,
                                //         fontSize: 13,
                                //         fontWeight: FontWeight.w500,
                                //         letterSpacing: 0.5,
                                //         color: kBlackColor,
                                //       ),
                                //       // a.description.toString()
                                //     ),
                                //     Row(
                                //       children: [
                                //         Text(
                                //           'votes: ',
                                //           style: GoogleFonts.poppins(
                                //             textStyle: style,
                                //             fontSize: 13,
                                //             fontWeight: FontWeight.w500,
                                //             letterSpacing: 0.5,
                                //             color: kBlackColor,
                                //           ),
                                //           // a.description.toString()
                                //         ),
                                //         Text(
                                //           candidatelist[position]
                                //               .obtainedVOTES
                                //               .toString(),
                                //           style: GoogleFonts.poppins(
                                //             textStyle: style,
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.w500,
                                //             letterSpacing: 0.5,
                                //             color: kPrimaryColor,
                                //           ),
                                //           // a.description.toString()
                                //         ),
                                //       ],
                                //     ),

                                //     // Row(
                                //     //   crossAxisAlignment: CrossAxisAlignment.start,
                                //     //   children: [
                                //     //     Text(
                                //     //       pollingstationlist[position]
                                //     //           .electionDescription
                                //     //           .toString(),
                                //     //       style: GoogleFonts.poppins(
                                //     //         textStyle: style,
                                //     //         fontSize: 12,
                                //     //         fontWeight: FontWeight.w400,
                                //     //         letterSpacing: 0.5,
                                //     //         color: kDarkGreyColor,
                                //     //         // d.description.toString()
                                //     //       ),
                                //     //     ),
                                //     //     Spacer(),
                                //     //     // Text(pollingstationlist[position]
                                //     //     //     .entityname
                                //     //     //     .toString()),
                                //     //     // // f.entityname.toString()),
                                //     //     // Text(pollingstationlist[position]
                                //     //     //         .entitynameDescription
                                //     //     //         .toString()
                                //     //     //     //f.description.toString()
                                //     //     //     ),
                                //     //     Text(
                                //     //       pollingstationlist[position]
                                //     //           .electionDATE
                                //     //           .toString(),
                                //     //       style: GoogleFonts.poppins(
                                //     //         textStyle: style,
                                //     //         fontSize: 12,
                                //     //         fontWeight: FontWeight.w400,
                                //     //         letterSpacing: 0.5,
                                //     //         color: kDarkGreyColor,
                                //     //         // c.election_DATE.toString()
                                //     //       ),
                                //     //     ),
                                //     //   ],
                                //     // ),
                                //   ],
                                // ),
                                // onTap: () {
                                //   Navigator.of(context).push(MaterialPageRoute(
                                //       builder: (context) => Pollingresultpage(
                                //           pollingstation:
                                //               pollingstationlist[position])));
                                // }),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                    // return CustomResult(
                    //     candidate: candidatelist); //Column(children: [
                    //for (int i = 0; i < candidatelist.length; i++)
                    // CustomResult(candidate: candidatelist)
                    //  ]);
                    // return Text("NULL");
                    // Column(
                    //   children: [
                    //     for (int i = 0; i < candidatelist.length; i++)
                    //       Text(
                    //         candidatelist[i].politicalPartyName.toString(),
                    //         // b.contituencyCODE.toString(),
                    //         style: TextStyle(fontSize: 22.0),
                    //       ),
                    //     for (int i = 0; i < candidatelist.length; i++)
                    //       Text(
                    //         candidatelist[i].politicalpartySYMBOL.toString(),
                    //         // b.contituencyCODE.toString(),
                    //         style: TextStyle(fontSize: 22.0),
                    //       ),
                    //     for (int i = 0; i < candidatelist.length; i++)
                    //       Text(
                    //         candidatelist[i].candidateforenames.toString(),
                    //         // a.description.toString()
                    //       ),
                    //     for (int i = 0; i < candidatelist.length; i++)
                    //       Text(candidatelist[i].candidatesurname.toString()
                    //           // d.description.toString()
                    //           ),

                    //     // Text(widget.pollingstation.entityname.toString()),
                    //     // // f.entityname.toString()),
                    //     // Text(widget.pollingstation.entitynameDescription.toString()
                    //     //     //f.description.toString()
                    //     //     ),
                    //     // Text(
                    //     //   widget.pollingstation.electionDATE.toString(),
                    //     //   // c.election_DATE.toString()
                    //     // ),
                    //   ],
                    // );
                    // ListView.builder(
                    //   itemCount: pollingstationlist.length,
                    //   //  responselist.length,
                    //   itemBuilder: (context, position) {
                    //     return Card(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(16.0),
                    //         child: ListTile(
                    //             title: Column(
                    //               children: [
                    //                 Text(
                    //                   pollingstationlist[position]
                    //                       .contituencyCODE
                    //                       .toString(),
                    //                   // b.contituencyCODE.toString(),
                    //                   style: TextStyle(fontSize: 22.0),
                    //                 ),
                    //                 Text(pollingstationlist[position]
                    //                         .pollingstationname
                    //                         .toString()
                    //                     // a.description.toString()
                    //                     ),
                    //                 Text(pollingstationlist[position]
                    //                         .electionDescription
                    //                         .toString()
                    //                     // d.description.toString()
                    //                     ),
                    //                 Text(pollingstationlist[position]
                    //                     .entityname
                    //                     .toString()),
                    //                 // f.entityname.toString()),
                    //                 Text(pollingstationlist[position]
                    //                         .entitynameDescription
                    //                         .toString()
                    //                     //f.description.toString()
                    //                     ),
                    //                 Text(
                    //                   pollingstationlist[position]
                    //                       .electionDATE
                    //                       .toString(),
                    //                   // c.election_DATE.toString()
                    //                 ),
                    //               ],
                    //             ),
                    //             onTap: () {
                    //               Navigator.of(context).push(MaterialPageRoute(
                    //                   builder: (context) => Pollingresultpage(
                    //                       pollingstation:
                    //                           pollingstationlist[position])));
                    //             }),
                    //       ),
                    //     );
                    //   },
                    // );
                    // Text(snapshot.data.toString(),
                    //     style: const TextStyle(color: Colors.cyan, fontSize: 36));
                  } else {
                    return const Text('Empty data');
                  }
                } else {
                  return Text('State: ${snapshot.connectionState}');
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
