import 'package:findword/base/base_c.dart';
import 'package:findword/dialog/buy/comment/comment_success_dialog.dart';
import 'package:findword/utils/routers/routers_utils.dart';
import 'package:findword/utils/user_info_utils.dart';
import 'package:in_app_review/in_app_review.dart';

class CommentC extends BaseC{
  var starNum=-1,showFinger=true;

  @override
  void onInit() {
    super.onInit();
    UserInfoUtils.instance.updateShowReviewDialogNum();
  }

  clickStar(index){
    starNum=index;
    showFinger=false;
    update(["star","finger"]);
    Future.delayed(const Duration(milliseconds: 500),(){
      RoutersUtils.off();
      UserInfoUtils.instance.updateUserCoinNum(5000);
      if(starNum>=4){
        _showReviewDialog();
      }else{
        RoutersUtils.showDialog(child: CommentSuccessDialog());
      }
    });
  }

  _showReviewDialog()async{
    var review = InAppReview.instance;
    var available = await review.isAvailable();
    if(available){
      review.requestReview();
    }
  }
}