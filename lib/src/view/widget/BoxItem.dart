import 'package:btc_app/src/common/constant/StyleFont.dart';
import 'package:btc_app/src/view/widget/page/DetialScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BoxItem extends StatefulWidget {
  const BoxItem(
      {super.key,
      required this.currencyName,
      required this.price,
      required this.pathimg, required this.onpress});
  final String currencyName;
  final String price;
  final String pathimg;
  final VoidCallback onpress;
  @override
  State<BoxItem> createState() => _BoxItemState();
}

class _BoxItemState extends State<BoxItem> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GestureDetector(
      onTap:widget.onpress,
      child: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 15),
          width: width * 0.9,
          height: 60,
          decoration: BoxDecoration(
              color: const Color(0xffE5F9DB),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(width: 2, color: const Color(0xffA2A378))),
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            SvgPicture.asset(
              widget.pathimg,
              width: 35,
              height: 35,
            ),
            const SizedBox(
              width: 16,
            ),
            const Text(
              'BTC',
              style: boxTextStyle,
            ),
            const SizedBox(
              width: 16,
            ),
            Text('Currency : ${widget.currencyName}', style: boxTextStyle),
            const SizedBox(
              width: 16,
            ),
            Text('Price : ${widget.price}', style: boxTextStyle)
          ]),
        ),
      ),
    );
  }
}
