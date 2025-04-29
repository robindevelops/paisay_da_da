import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:paisay_da_da/domain/models/groupmodel/group.model.dart';

class TotalBill extends StatefulWidget {
  String totalBill;
  String createdAt;
  List<OwedUsers>? owedUsers;
  String? payerName;
  TotalBill({
    super.key,
    required this.createdAt,
    required this.totalBill,
    required this.owedUsers,
    required this.payerName,
  });

  @override
  State<TotalBill> createState() => _TotalBillState();
}

class _TotalBillState extends State<TotalBill> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Detail",
          style: GoogleFonts.aBeeZee(
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.edit),
          ),
        ],
        backgroundColor: Colors.black,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Total Bill Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        "Bill",
                        style: GoogleFonts.aBeeZee(
                          fontSize: 35,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey[800],
                        ),
                      ),
                      SizedBox(height: 5),
                      Text(
                        'Added on ${displayJustDate(widget.createdAt)}',
                        style: TextStyle(fontSize: 14, color: Colors.black54),
                      ),
                    ],
                  ),
                  Text(
                    'Rs ${widget.totalBill}',
                    style: GoogleFonts.aBeeZee(
                      fontSize: 35,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30),

              // Payment Details Section
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Paid by ${widget.payerName!}"),
                  SizedBox(height: 20),
                  Text(
                    "Owed User",
                    style: GoogleFonts.aBeeZee(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: widget.owedUsers!.length,
                      itemBuilder: (context, index) {
                        var owedUsers = widget.owedUsers![index];
                        var name = owedUsers.user!.name;
                        var price = owedUsers.amount;
                        return ListTile(
                          subtitleTextStyle: TextStyle(
                            color: Colors.red,
                          ),
                          title: Text(
                            name!,
                          ),
                          subtitle: Text(
                            "Rs ${price}",
                          ),
                          leading: Icon(Icons.person_2_outlined),
                        );
                      },
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String displayJustDate(String date) {
    var dateLocal = DateTime(
        DateTime.parse(date).year,
        DateTime.parse(date).month,
        DateTime.parse(date).day,
        DateTime.parse(date).hour,
        DateTime.parse(date).minute,
        DateTime.parse(date).second); //.add(DateTime.now().timeZoneOffset);
    return DateFormat('d/MM/yyyy').format(dateLocal);
  }
}
