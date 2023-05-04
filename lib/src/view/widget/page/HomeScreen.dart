import 'dart:async';
import 'dart:developer';

import 'package:btc_app/src/common/constant/StyleFont.dart';
import 'package:btc_app/src/provider/Homeprovider.dart';
import 'package:btc_app/src/model/CoinModel.dart';
import 'package:btc_app/src/model/commonModel.dart';

import 'package:btc_app/src/view/widget/BoxItem.dart';
import 'package:btc_app/src/view/widget/TextField..dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import 'DetialScreen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController textEditingController = TextEditingController();
  String type = 'USD';
  num answerValue = 0;
  Timer? time;
  bool isInt = true;

  @override
  void initState() {
    calldata();
    super.initState();
  }

  void calldata() async {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      context.read<Homeprovider>().updateData('USD');
    });
  }

  @override
  void dispose() {
    time!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    time = Timer.periodic(const Duration(minutes: 1), (timer) {
      Provider.of<Homeprovider>(context, listen: false).updateData('USD');
    });
    void calculate() {
      if (!RegExp(r"^[0-9]+$").hasMatch(textEditingController.text)) {
        return;
      }

      if (type == 'USD') {
        answerValue = (num.tryParse(
                Provider.of<Homeprovider>(context, listen: false)
                    .rateList[0]
                    .replaceAll(",", ""))! *
            int.parse(textEditingController.text));
      } else if (type == 'GBP') {
        answerValue = (num.tryParse(
                Provider.of<Homeprovider>(context, listen: false)
                    .rateList[1]
                    .replaceAll(",", ""))! *
            int.parse(textEditingController.text));
      } else if (type == 'EUR') {
        answerValue = (num.tryParse(
                Provider.of<Homeprovider>(context, listen: false)
                    .rateList[2]
                    .replaceAll(",", ""))! *
            int.parse(textEditingController.text));
      }

      setState(() {});
    }

    List<LastData> queryLastData(types) {
      if (types == 'USD') {
        return Provider.of<Homeprovider>(context, listen: false).lastUsdData;
      } else if (types == 'GBP') {
        return Provider.of<Homeprovider>(context, listen: false).lastGbpData;
      } else {
        return Provider.of<Homeprovider>(context, listen: false).lastEurData;
      }
    }

    return Scaffold(
      backgroundColor: Colors.blueGrey.shade300,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(children: [
            SizedBox(
              height: height * 0.05,
            ),
            SizedBox(
                height: height * 0.3,
                width: width,
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: typeCoinList.length,
                    itemBuilder: (context, index) {
                      TypeCoin item = typeCoinList[index];

                      return BoxItem(
                          onpress: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DetialScreen(
                                          data: queryLastData(item.nameType),
                                        )));
                          },
                          pathimg: item.pathImg,
                          currencyName: item.nameType,
                          price: Provider.of<Homeprovider>(context)
                              .rateList[index]);
                    })),
            SizedBox(
              height: height * 0.15,
            ),
            TextFieldItem(
              textController: textEditingController,
              hintText: type,
            ),
            const SizedBox(
              height: 8,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: width * 0.2),
              child: SizedBox(
                  height: height * 0.15,
                  width: width,
                  child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: typeCoinList.length,
                      itemBuilder: (context, index) {
                        TypeCoin item = typeCoinList[index];
                        return TypeCoinWidget(
                          pahtImg: item.pathImg,
                          typeName: item.nameType,
                          onpress: () {
                            setState(() {
                              type = item.nameType;
                            });
                          },
                        );
                      })),
            ),
            Container(
              width: width * 0.65,
              height: 60,
              decoration: BoxDecoration(
                  color: const Color(0xffE5F9DB),
                  borderRadius: BorderRadius.circular(30)),
              child: Center(
                  child: Text(
                answerValue.toStringAsFixed(8),
                style: const TextStyle(fontWeight: FontWeight.w700),
              )),
            ),
            const SizedBox(
              height: 16,
            ),
            InkWell(
              onTap: () {
                calculate();
              },
              child: Center(
                child: Container(
                  width: width * 0.3,
                  height: 50,
                  decoration: BoxDecoration(
                      color: const Color(0xffE5F9DB),
                      borderRadius: BorderRadius.circular(50)),
                  child: const Center(
                      child: Text(
                    'Calculate',
                    style: boxTextStyle,
                  )),
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}

class TypeCoinWidget extends StatelessWidget {
  const TypeCoinWidget({
    super.key,
    required this.typeName,
    required this.pahtImg,
    required this.onpress,
  });
  final String typeName;
  final String pahtImg;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpress,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            CircleAvatar(
                radius: 30,
                backgroundColor: Colors.transparent,
                child: SvgPicture.asset(
                  pahtImg,
                  fit: BoxFit.fill,
                  height: 35,
                  width: 35,
                )),
            const SizedBox(
              height: 8,
            ),
            Text(
              typeName,
              style: TextStyle(
                  color: Colors.blueGrey.shade600, fontWeight: FontWeight.w700),
            )
          ],
        ),
      ),
    );
  }
}
