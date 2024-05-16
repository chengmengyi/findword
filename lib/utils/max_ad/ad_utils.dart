import 'dart:convert';
import 'package:findword/dialog/buy/load_ad/laod_ad_d.dart';
import 'package:findword/dialog/buy/load_fail/load_fail_d.dart';
import 'package:findword/utils/data.dart';
import 'package:findword/utils/firebase_data_utils.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/storage/storage_key.dart';
import 'package:findword/utils/storage/storage_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/ad/listener/load_ad_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class AdUtils{
  factory AdUtils()=>_getInstance();
  static AdUtils get instance => _getInstance();
  static AdUtils? _instance;
  static AdUtils _getInstance(){
    _instance??=AdUtils._internal();
    return _instance!;
  }

  AdUtils._internal();

  var upLevelCloseNum=0,wheelCloseNum=0,answerRightCloseNum=0;

  initAd(){
    var json = _getLocalAdJson();
    var maxAdBean = MaxAdBean(
      maxShowNum: json["fha"],
      maxClickNum: json["fag"],
      firstOpenAdList: _getAdList(json["fw_open_3"],"fw_open_3"),
      secondOpenAdList: _getAdList(json["fw_open_2"],"fw_open_2"),
      firstRewardedAdList: _getAdList(json["fw_rv_3"],"fw_rv_3"),
      secondRewardedAdList: _getAdList(json["fw_rv_2"],"fw_rv_2"),
      firstInterAdList: _getAdList(json["fw_int_3"],"fw_int_3"),
      secondInterAdList: _getAdList(json["fw_int_2"],"fw_int_2"),
    );
    FlutterMaxAd.instance.initMax(
      maxKey: maxAdKey.base64(),
      maxAdBean: maxAdBean,
      testDeviceAdvertisingIds: ["B27491C2-E99E-4743-9712-B0A14B45E4C9"]
    );
    FlutterMaxAd.instance.setLoadAdListener(
      LoadAdListener(
          startLoad: (){
            TbaUtils.instance.uploadAdPoint(adPoint: AdPoint.ad_request);
          },
          loadSuccess: (){
            TbaUtils.instance.uploadAdPoint(adPoint: AdPoint.ad_fill);
          })
    );
  }

  showAd({
    required AdType adType,
    required AdPosId adPosId,
    required AdFomat adFormat,
    required AdShowListener adShowListener,
    Function()? cancelShow
  }){
    TbaUtils.instance.uploadAdPoint(adPoint: AdPoint.ad_chance);
    FlutterMaxAd.instance.loadAdByType(adType);
    loadAdDialogShowing=true;
    RoutersUtils.showDialog(
      child: LoadAdD(
        adType: adType,
        loadFail: (){
          RoutersUtils.showDialog(
              child: LoadFailD(
                tryAgain: (){
                  showAd(
                      adType: adType,
                      adShowListener: adShowListener,
                      adPosId: adPosId,
                      adFormat: adFormat,
                      cancelShow: cancelShow
                  );
                },
                closeCall: (){
                  loadAdDialogShowing=false;
                  cancelShow?.call();
                },
              )
          );
        },
        loadSuccess: (){
          FlutterMaxAd.instance.showAd(
              adType: adType,
              adShowListener: AdShowListener(
                  showAdSuccess: (MaxAd? ad) {
                    adShowListener.showAdSuccess(ad);
                  },
                  showAdFail: (MaxAd? ad, MaxError? error) {
                    loadAdDialogShowing=false;
                    adShowListener.showAdFail(ad,error);
                  },
                  onAdHidden: (MaxAd? ad) {
                    loadAdDialogShowing=false;
                    adShowListener.onAdHidden(ad);
                  },
                  onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {
                    TbaUtils.instance.uploadAdEvent(ad: ad, info: maxAdInfoBean, adPosId: adPosId, adFormat: adFormat);
                    adShowListener.onAdRevenuePaidCallback(ad,maxAdInfoBean);
                  })
          );
        },
      ),
    );
  }

  updateUpLevelCloseNum(){
    upLevelCloseNum++;
    if(upLevelCloseNum%FirebaseDataUtils.instance.wordInt==0){
      _showCancelNumIntAd();
    }
  }

  updateWheelCloseNum(){
    wheelCloseNum++;
    if(wheelCloseNum%FirebaseDataUtils.instance.closeWord==0){
      _showCancelNumIntAd();
    }
  }

  updateAnswerRightCloseNum(){
    answerRightCloseNum++;
    if(answerRightCloseNum%3==0){
      _showCancelNumIntAd();
    }
  }

  _showCancelNumIntAd(){
    TbaUtils.instance.uploadAdPoint(adPoint: AdPoint.ad_chance);
    FlutterMaxAd.instance.showAd(
        adType: AdType.inter,
        adShowListener: AdShowListener(
            showAdSuccess: (MaxAd? ad) {
            },
            showAdFail: (MaxAd? ad, MaxError? error) {

            },
            onAdHidden: (MaxAd? ad) {

            },
            onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {
              TbaUtils.instance.uploadAdEvent(ad: ad, info: maxAdInfoBean, adPosId: AdPosId.fw_all_int, adFormat: AdFomat.INT);
            })
    );
  }

  List<MaxAdInfoBean> _getAdList(json,adLocationName){
    try{
      List<MaxAdInfoBean> adList=[];
      json.forEach((v) {
        var v2 = v["qjkr"];
        adList.add(
            MaxAdInfoBean(
                id: v["gro"],
                plat: v["orm"],
                adType: v2=="open"?AdType.open:v2=="interstitial"?AdType.inter:v2=="native"?AdType.native:AdType.reward,
                expire: v["mtj"],
                sort: v["pqn"],
                adLocationName: adLocationName
            )
        );
      });
      return adList;
    }catch(e){
      return [];
    }
  }

  _getLocalAdJson(){
    var s = StorageUtils.instance.getValue<String>(StorageKey.adStr)??"";
    try{
      if(s.isEmpty){
        return jsonDecode(localAd.base64());
      }
      return jsonDecode(s);
    }catch(e){
      return jsonDecode(localAd.base64());
    }
  }
}