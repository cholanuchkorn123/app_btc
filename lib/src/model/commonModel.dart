import 'package:btc_app/src/common/constant/Image.dart';

class TypeCoin {
  final String pathImg;
  final String nameType;

  TypeCoin(this.pathImg, this.nameType);
}

List<TypeCoin> typeCoinList = [
  TypeCoin(UsdLogo, 'USD'),
  TypeCoin(Gbplogo, 'GBP'),
  TypeCoin(Eurlogo, 'EUR'),
];

class LastData {
   final String datatime;
  final String lastRate;

  LastData(this.datatime, this.lastRate);
}
