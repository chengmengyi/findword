class ValueBean2 {
  ValueBean2({
      this.range, 
      this.levelReward, 
      this.wheel, 
      this.floatReward, 
      this.signIn,
  });

  ValueBean2.fromJson(dynamic json) {
    range = json['range'] != null ? json['range'].cast<int>() : [];
    if (json['level_reward'] != null) {
      levelReward = [];
      json['level_reward'].forEach((v) {
        levelReward?.add(LevelReward.fromJson(v));
      });
    }
    if (json['wheel'] != null) {
      wheel = [];
      json['wheel'].forEach((v) {
        wheel?.add(LevelReward.fromJson(v));
      });
    }
    if (json['float_reward'] != null) {
      floatReward = [];
      json['float_reward'].forEach((v) {
        floatReward?.add(LevelReward.fromJson(v));
      });
    }
    signIn = json['sign_in'] != null ? json['sign_in'].cast<int>() : [];
  }
  List<int>? range;
  List<LevelReward>? levelReward;
  List<LevelReward>? wheel;
  List<LevelReward>? floatReward;
  List<int>? signIn;
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['range'] = range;
    if (levelReward != null) {
      map['level_reward'] = levelReward?.map((v) => v.toJson()).toList();
    }
    if (wheel != null) {
      map['wheel'] = wheel?.map((v) => v.toJson()).toList();
    }
    if (floatReward != null) {
      map['float_reward'] = floatReward?.map((v) => v.toJson()).toList();
    }
    map['sign_in'] = signIn;
    return map;
  }
}

class LevelReward {
  LevelReward({
      this.firstNumber, 
      this.step, 
      this.intAd, 
      this.endNumber,
  });

  LevelReward.fromJson(dynamic json) {
    firstNumber = json['first_number'];
    step = json['step'] != null ? json['step'].cast<int>() : [];
    intAd = json['int_ad'];
    endNumber = json['end_number'];
  }
  int? firstNumber;
  List<int>? step;
  int? intAd;
  int? endNumber;
  
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['first_number'] = firstNumber;
    map['step'] = step;
    map['int_ad'] = intAd;
    map['end_number'] = endNumber;
    return map;
  }
}