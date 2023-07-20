
// import 'package:country_code_picker/country_code_picker.dart';
// import 'package:efood_table_booking/view/screens/auth/widget/country_code_picker_widget.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';

// import '../../../../helper/responsive_helper.dart';
// import '../../../../helper/route_helper.dart';
// import '../../../../util/dimensions.dart';
// import '../../../../util/images.dart';
// import '../../../../util/styles.dart';
// import '../../../controller/auth_controller.dart';
// import '../../base/custom_button.dart';
// import '../../base/custom_shape.dart';
// import '../../base/custom_snackbar.dart';
// import '../../base/custom_text_field.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({Key? key}) : super(key: key);

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   String _countryDialCode = "+977";
//   TextEditingController phoneNumberController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   FocusNode phoneNumberFocusNode = FocusNode();
//   FocusNode passwordFocusNode = FocusNode();



//   @override
//   void initState() {
//     super.initState();
//     phoneNumberController.text = (Get.find<AuthController>().getUserNumber());
//     passwordController.text = (Get.find<AuthController>().getUserPassword());
//     // _countryDialCode = CountryCode.fromCountryCode(Get.find<SplashController>().configModel.country).dialCode!;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       body: Stack(
//         children: [
//           Align(
//             alignment:Alignment.bottomCenter,
//             child: CustomPaint(
//               size: Size(MediaQuery.of(context).size.width, Get.height * 0.5),
//               painter: CurvedPainter(),
//             ),
//           ),
//           GetBuilder<AuthController>(
//               builder: (authController) {

//                 return SingleChildScrollView(
//                   child: Column(
//                     children: [
//                       SizedBox(height: Dimensions.paddingSizeExtraSmall),
//                       Container(width : 100, height: Get.height <700? 100 : 150,
//                           child: Image.asset(Images.logo)),

//                       Text('login'.tr, style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
//                       Get.height >700?
//                       SizedBox(height: Dimensions.fontSizeExtraLarge):SizedBox(),

//                       Padding(
//                         padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
//                         child: Container(width: ResponsiveHelper.isMobile(context) ? Get.width: Get.width/2.5,
//                           child: Column(
//                             children: [
//                               Container(
//                                 decoration: BoxDecoration(
//                                     color: Theme.of(context).highlightColor
//                                 ),
//                                 padding: EdgeInsets.only(left: Dimensions.paddingSizeExtraSmall),
//                                 margin: EdgeInsets.only(top: Dimensions.paddingSizeExtraSmall),
//                                 child: Row(children: [
//                                   CodePickerWidget(
//                                     onChanged: (CountryCode countryCode) {
//                                       _countryDialCode = countryCode.dialCode!;
//                                     },
//                                     initialSelection: _countryDialCode,
//                                     favorite: [_countryDialCode],
//                                     showDropDownButton: true,
//                                     padding: EdgeInsets.zero,
//                                     showFlagMain: true,
//                                     textStyle: TextStyle(color: Theme.of(context).textTheme.headline1!.color!),

//                                   ),
//                                   Container(height: 40, width: 1, color: Theme.of(context).hintColor),

//                                   Expanded(child: CustomTextField(
//                                     hintText: 'enter_your_phone_number'.tr,
//                                     controller: phoneNumberController,
//                                     focusNode: phoneNumberFocusNode,
//                                     nextFocus: passwordFocusNode,
//                                     inputAction: TextInputAction.next,
//                                     inputType: TextInputType.phone,
//                                   )),
//                                 ]),
//                               ),
//                               SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                               CustomTextField(
//                                 hintText: '5+_character'.tr,
//                                 controller: passwordController,
//                                 focusNode: passwordFocusNode,
//                                 inputAction: TextInputAction.done,
//                                 inputType: TextInputType.phone,
//                                 isPassword: true,
//                                 prefixIcon: Images.lock,
//                               ),

//                               Row(
//                                 children: [
//                                   SizedBox(
//                                     width: 20.0,
//                                     child: Checkbox(
//                                       side: BorderSide(color: Theme.of(context).primaryColor,width: 1),
//                                       activeColor: Theme.of(context).primaryColor,
//                                       value: authController.isActiveRememberMe,
//                                       onChanged: authController.toggleRememberMe,
//                                     ),
//                                   ),
//                                   SizedBox(width: Dimensions.paddingSizeExtraSmall),
//                                   Text('remember_me'.tr, style: robotoRegular.copyWith(
//                                     fontSize: Dimensions.fontSizeSmall,
//                                   )),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),

//                       SizedBox(height: Dimensions.paddingSizeExtraSmall),

//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal:  ResponsiveHelper.isTab(context) ? MediaQuery.of(context).size.width/3.3: Dimensions.paddingSizeExtraSmall),
//                         child:  Container(
//                           child:authController.isLoading?
//                           Container(width: MediaQuery.of(context).size.width,
//                               child: Center(child: Container(width: 30,height: 30,child: CircularProgressIndicator()))):
//                           CustomButton(buttonText: 'login'.tr, onPressed: (){
//                             String phoneNumber = phoneNumberController.text.trim();
//                             String phoneNumberWithCountryCode = _countryDialCode+phoneNumberController.text.trim();
//                             String password = passwordController.text.trim();
//                             if(phoneNumber.isEmpty){
//                               showCustomSnackBar('phone_number_is_required'.tr);
//                             }else if(password.isEmpty){
//                               showCustomSnackBar('password_is_required'.tr);
//                             }else if(password.length <6){
//                               showCustomSnackBar('minimum_password_length_is_8'.tr);
//                             }else{
//                               if (Get.find<AuthController>().isActiveRememberMe) {
//                                 Get.find<AuthController>().saveUserNumberAndPassword(phoneNumber, password);
//                               } else {
//                                 Get.find<AuthController>().clearUserNumberAndPassword();
//                               }
//                               Get.find<AuthController>().login(phoneNumberWithCountryCode, password).then((value){
//                                 if(value.statusCode == 200){
//                                   Get.toNamed(RouteHelper.home);
//                                 }
//                               });


//                             }


//                           }),
//                         ),
//                       ),
//                       SizedBox(height: MediaQuery.of(context).viewInsets.bottom,)
//                     ],
//                   ),
//                 );
//               }
//           ),



//         ],
//       )
//     );
//   }
// }