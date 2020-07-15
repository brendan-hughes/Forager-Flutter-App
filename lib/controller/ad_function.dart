import 'dart:io';
import 'package:firebase_admob/firebase_admob.dart';


class AdMobService {
  String getAdMobAppId() {
    if (Platform.isIOS) {
      return 'ca-app-pub-9513303834364544~6676869317';
    } else if (Platform.isAndroid) {
      return 'ca-app-pub-9513303834364544~5379265364';
    } return null;
  }


}


BannerAd createBannerAd() {
  String testDevice = 'mobile_id';
  MobileAdTargetingInfo targetingInfo = MobileAdTargetingInfo(
    keywords: <String>['healthy', 'food','health food', 'nutrition', 'diet', 'fat','exercise','meal planning','meal','meal prep'],
    childDirected: false,
    testDevices: testDevice != null? <String>[testDevice] : null,
    nonPersonalizedAds: true,
  );
  String adID;
  if (Platform.isIOS) {
    adID = 'ca-app-pub-9513303834364544/4170959621';
  } else if (Platform.isAndroid) {
    adID = 'ca-app-pub-9513303834364544/1301060183';
  }
  String appID;
  if (Platform.isIOS) {
    appID= 'ca-app-pub-9513303834364544~6676869317';
  } else if (Platform.isAndroid) {
    appID = 'ca-app-pub-9513303834364544~5379265364';
  }
  return BannerAd(
      adUnitId: adID,
    size: AdSize.smartBanner,
    targetingInfo: targetingInfo,
      listener: (MobileAdEvent event) { //Write logic here to display loading circle until ad has finished loading.
        print(event);
      }
  );
}

