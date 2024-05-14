import 'package:findword/base/base_c.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/tba_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class NoTipsC extends BaseC{

  @override
  void onInit() {
    super.onInit();
    FlutterMaxAd.instance.loadAdByType(AdType.reward);
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_hint_over_pop);
  }

  showAd(Function() addTipsCall){
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.fw_hint_over_pop_c);
    AdUtils.instance.showAd(
        adType: AdType.reward,
        adPosId: AdPosId.fw_addtips_rv,
        adFormat: AdFomat.REWARD,
        adShowListener: AdShowListener(
            showAdSuccess: (MaxAd? ad) {  },
            showAdFail: (MaxAd? ad, MaxError? error) {  },
            onAdHidden: (MaxAd? ad) {
              UserInfoUtils.instance.updateTipsNum(3);
              RoutersUtils.off();
              addTipsCall.call();
            },
            onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {

            })
    );
  }
}