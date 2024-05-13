class TbaUtils{
  factory TbaUtils()=>_getInstance();
  static TbaUtils get instance => _getInstance();
  static TbaUtils? _instance;
  static TbaUtils _getInstance(){
    _instance??=TbaUtils._internal();
    return _instance!;
  }

  TbaUtils._internal();


}