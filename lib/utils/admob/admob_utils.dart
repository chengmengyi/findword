import 'package:findword/utils/admob/admob_listener.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdmobUtils{
  factory AdmobUtils()=>_getInstance();
  static AdmobUtils get instance => _getInstance();
  static AdmobUtils? _instance;
  static AdmobUtils _getInstance(){
    _instance??=AdmobUtils._internal();
    return _instance!;
  }

  AdmobUtils._internal();

  InterstitialAd? _interstitialAd;
  AdmobListener? _admobListener;

  loadInterAd(){
    if(null!=_interstitialAd){
      return;
    }
    InterstitialAd.load(
        adUnitId: "ca-app-pub-3940256099942544/4411468910",
        request: const AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (ad) {
            print("admob---->onAdLoaded");
            ad.fullScreenContentCallback=FullScreenContentCallback(
              onAdShowedFullScreenContent: (ad){
                _admobListener?.showAdSuccess();
                _interstitialAd=null;
                loadInterAd();
              },
              onAdFailedToShowFullScreenContent: (ad,err){
                _admobListener?.hideAd();
                _interstitialAd=null;
                loadInterAd();
              },
            );
            _interstitialAd=ad;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print("admob---->onAdFailedToLoad--->${error.message}");
          },
        ));
  }

  showInterAd(){
    _interstitialAd?.show();
  }

  setAdmobListener(AdmobListener admobListener){
    _admobListener=admobListener;
  }
}