import 'package:btc_app/src/common/constant/StyleFont.dart';
import 'package:btc_app/src/model/commonModel.dart';
import 'package:flutter/material.dart';


class DetialScreen extends StatefulWidget {
 DetialScreen({super.key, required this.data});
 List<LastData> data = [];
  @override
  State<DetialScreen> createState() => _DetialScreenState();
}

class _DetialScreenState extends State<DetialScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    
   
  
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade100,
      appBar: AppBar(
        leading: Builder(
          builder: (context) {
            return GestureDetector(
              onTap: () => Navigator.pop(context),
              child: const Icon(
                Icons.arrow_back,
                color: Colors.black,
                size: 30,
              ),
            );
          },
        ),
        elevation: 0,
        backgroundColor: Colors.blueGrey.shade100,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Last Price',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
            ),
            const SizedBox(
              height: 16,
            ),
            SizedBox(
                height: height * 0.8,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount:widget.data.length,
                    itemBuilder: (context, index) {
                      LastData item =widget.data[index];
                      return Container(
                        width: width,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        decoration: const BoxDecoration(
                            border: Border(
                                bottom:
                                    BorderSide(width: 1, color: Colors.black))),
                        child: Text(
                          '${item.datatime} ${item.lastRate} ',
                          style: boxTextStyle,
                          textAlign: TextAlign.center,
                        ),
                      );
                    }))
          ],
        ),
      ),
    );
  }
}
