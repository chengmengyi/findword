class ValueBean {
  ValueBean({
      this.range, 
      this.conversion, 
      this.rewardLucky, 
      this.wheel,});

  ValueBean.fromJson(dynamic json) {
    range = json['range'] != null ? json['range'].cast<int>() : [];
    conversion = json['conversion'];
    if (json['reward_lucky'] != null) {
      rewardLucky = [];
      json['reward_lucky'].forEach((v) {
        rewardLucky?.add(RewardLucky.fromJson(v));
      });
    }
    if (json['wheel'] != null) {
      wheel = [];
      json['wheel'].forEach((v) {
        wheel?.add(RewardLucky.fromJson(v));
      });
    }
  }
  List<int>? range;
  int? conversion;
  List<RewardLucky>? rewardLucky;
  List<RewardLucky>? wheel;
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['range'] = range;
    map['conversion'] = conversion;
    if (rewardLucky != null) {
      map['reward_lucky'] = rewardLucky?.map((v) => v.toJson()).toList();
    }
    if (wheel != null) {
      map['wheel'] = wheel?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class RewardLucky {
  RewardLucky({
      this.firstNumber, 
      this.step, 
      this.endNumber,});

  RewardLucky.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    step = json['step'] != null ? json['step'].cast<int>() : [];
    endNumber = json['end_number'];
  }
  int? firstNumber;
  List<int>? step;
  int? endNumber;
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['step'] = step;
    map['end_number'] = endNumber;
    return map;
  }
}