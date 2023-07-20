import 'package:efood_table_booking/data/model/response/language_model.dart';
import 'package:efood_table_booking/util/images.dart';

class AppConstants {
  static const String APP_NAME = 'ShandarCafe WaiterApp';
  static const double APP_VERSION = 1.1;
  // demo
  static const String BASE_URL = 'https://www.shandarcafe.com';
  static const String CONFIG_URI = '/api/v1/config/table';
  static const String CATEGORY_URI = '/api/v1/categories';
    static const String LOGIN_URI = '/api/v1/auth/waiter/login';
  static const String PRODUCT_URI = '/api/v1/products/latest';
    static const String PROFILE_URI = '/api/v1/waiter/profile';
  static const String CATEGORY_PRODUCT_URI = '/api/v1/categories/products';
  static const String PLACE_ORDER_URI = '/api/v1/table/order/place';
  static const String ORDER_DETAILS_URI = '/api/v1/table/order/details?';
    static const String FCM_TOKEN_URI = '/api/v1/waiter/update-fcm-token';
  static const String ORDER_LIST =
      '/api/v1/table/order/list?branch_table_token=';
      
  // Shared Key
  static const String THEME = 'theme';
  static const String TOKEN = 'token';
  static const String COUNTRY_CODE = 'country_code';
  static const String LANGUAGE_CODE = 'language_code';
  static const String CART_LIST = 'cart_list';
  static const String USER_PASSWORD = 'user_password';
  static const String USER_ADDRESS = 'user_address';
  static const String USER_NUMBER = 'user_number';
  static const String SEARCH_ADDRESS = 'search_address';
  static const String TOPIC = 'notify';
  static const String TABLE_NUMBER = 'table_number';
  static const String BRANCH = 'branch';
  static const String ORDER_INFO = 'order_info';
  static const String IS_FIX_TABLE = 'is_fix_table';
    static const String BRANCH_ID = 'branch_id';
  static List<LanguageModel> languages = [
    LanguageModel(
        imageUrl: Images.united_kingdom,
        languageName: 'English',
        countryCode: 'US',
        languageCode: 'en')
  ];
}
