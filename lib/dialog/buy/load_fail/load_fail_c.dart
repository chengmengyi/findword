import 'package:findword/base/base_c.dart';
import 'package:findword/utils/max_ad/ad_pos_id.dart';
import 'package:findword/utils/tba_utils.dart';

class LoadFailC extends BaseC{
  @override
  void onInit() {
    super.onInit();
    TbaUtils.instance.uploadAppPoint(appPoint: AppPoint.try_again_pop);
  }
}