import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gazi_sales_app/sales/constant/app_constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import '../data_model/zid_model.dart';
import '../hr/notifications/approverNotification/screen/approver.dart';

class Get_zid extends StatefulWidget {
  Get_zid(
      {required this.zemail,
      //required this.loginModel,
      required this.xposition,
      required this.xrole,
      required this.xstaff});
  String zemail;
  // LoginModel loginModel;
  String xstaff;
  String xposition;
  String xrole;

  @override
  _Get_zidState createState() => _Get_zidState();
}

class _Get_zidState extends State<Get_zid> {
  Future<List<ZidModel>>? futurePost;

  AppConstants appConstants = AppConstants();

  Future<List<ZidModel>> fetchPost() async {
    var response = await http.get(Uri.parse(
        'http://${AppConstants.baseurl}/gazi/zid.php?zemail=${widget.zemail}'));

    print(response.body);

    if (response.statusCode == 200) {
      final parsed = json.decode(response.body).cast<Map<String, dynamic>>();

      return parsed.map<ZidModel>((json) => ZidModel.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load album');
    }
  }

  changeImage(String statusdemo) {
    switch (statusdemo) {
      case "Gazi Group":
        return AssetImage("assets/images/logo/100000.png");

      case "GAZI SINKS":
        return AssetImage("assets/images/logo/400060.png");

      case "GAZI DOORS":
        return AssetImage("assets/images/logo/400070.png");

      case "GAZI TANKS":
        return AssetImage("assets/images/logo/400080.png");

      case "GAZI PIPES":
        return AssetImage("assets/images/logo/400090.png");

      default:
        return AssetImage("assets/images/logo/100000.png");
    }
  }

  @override
  void initState() {
    super.initState();
    futurePost = fetchPost();
    fetchPost().whenComplete(() => futurePost);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Color(0xff064A76),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Center(
          child: Text(
            "Business ID",
            style: GoogleFonts.bakbakOne(
              fontSize: 20,
              color: Color(0xff074974),
            ),
          ),
        ),
        actions: [
          SizedBox(
            width: 20,
          )
        ],
        backgroundColor: Colors.white,
      ),
      body: Container(
        child: FutureBuilder<List<ZidModel>>(
          future: futurePost,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 100 / 90,
                    crossAxisCount: 2,
                  ),
                  itemCount: snapshot.data!.length,
                  itemBuilder: (_, index) => Container(
                    child: Card(
                      margin: const EdgeInsets.all(7),
                      elevation: 8,
                      shadowColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AdminNotification(
                                      xposition: widget.xposition,
                                      zemail: widget.zemail,
                                      zid: (snapshot.data![index].zid)
                                          .toString(),
                                      xStaff: widget.xstaff)));
                        },
                        child: Column(
                          //mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: changeImage(snapshot.data![index].zorg),
                              fit: BoxFit.fill,
                              height: 100,
                              width: double.maxFinite,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "${snapshot.data![index].zorg}",
                              style: GoogleFonts.bakbakOne(
                                fontSize: 12,
                                color: Color(0xff074974),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              return Center(
                child: Image(image: AssetImage("assets/images/loading.gif")),
              );
            }
          },
        ),
      ),
    );
  }
}
