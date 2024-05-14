import 'package:findword/base/base_c.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/max_ad/ad_utils.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:findword/utils/value_utils.dart';
import 'package:flutter_max_ad/ad/ad_bean/max_ad_bean.dart';
import 'package:flutter_max_ad/ad/ad_type.dart';
import 'package:flutter_max_ad/ad/listener/ad_show_listener.dart';
import 'package:flutter_max_ad/export.dart';
import 'package:flutter_max_ad/flutter_max_ad.dart';

class BoxC extends BaseC{
  var showTop=false;
  var addNum=ValueUtils.instance.getCurrentAddNum();

  @override
  void onInit() {
    super.onInit();
    FlutterMaxAd.instance.loadAdByType(AdType.reward);
  }

  @override
  void onReady() {
    super.onReady();
    Future.delayed(const Duration(milliseconds: 1000),(){
      showTop=true;
      update(["top"]);
    });
  }

  clickClose(){

  }

  clickCollect(Function() dismissDialog){
    AdUtils.instance.showAd(
      adType: AdType.reward,
      adPosId: AdPosId.fw_wordbox_rv,
      adFormat: AdFomat.REWARD,
      adShowListener: AdShowListener(
          showAdSuccess: (MaxAd? ad) {
          },
          showAdFail: (MaxAd? ad, MaxError? error) {
          },
          onAdHidden: (MaxAd? ad) {
            UserInfoUtils.instance.updateUserCoinNum(addNum);
            UserInfoUtils.instance.updateTipsNum(1);
            RoutersUtils.off();
            dismissDialog.call();
          },
          onAdRevenuePaidCallback: (MaxAd ad, MaxAdInfoBean? maxAdInfoBean) {

          }),
    );
  }
}