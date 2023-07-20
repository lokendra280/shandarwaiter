import 'package:efood_table_booking/controller/cart_controller.dart';
import 'package:efood_table_booking/controller/order_controller.dart';
import 'package:efood_table_booking/data/model/response/cart_model.dart';
import 'package:efood_table_booking/helper/price_converter.dart';
import 'package:efood_table_booking/helper/responsive_helper.dart';
import 'package:efood_table_booking/util/dimensions.dart';
import 'package:efood_table_booking/util/images.dart';
import 'package:efood_table_booking/util/styles.dart';
import 'package:efood_table_booking/view/base/bodyTemplate.dart';
import 'package:efood_table_booking/view/base/custom_app_bar.dart';
import 'package:efood_table_booking/view/base/custom_button.dart';
import 'package:efood_table_booking/view/base/custom_loader.dart';
import 'package:efood_table_booking/view/base/custom_snackbar.dart';
import 'package:efood_table_booking/view/base/custom_text_field.dart';
import 'package:efood_table_booking/view/screens/home/widget/filter_button_widget.dart';
import 'package:efood_table_booking/view/screens/order/widget/order_success_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:convert';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({Key? key}) : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();

}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController _amountTextController = TextEditingController();
  double _changeAmount = 0;
  double _currentAmount = 0;
  double _payableAmount = 0;

  @override
  void dispose() {
    _amountTextController.dispose();
    super.dispose();
  }
  @override
  void initState() {
    final _orderController = Get.find<OrderController>();
    _orderController.isLoadingUpdate = false;
    _orderController.setSelectedMethod(Get.find<OrderController>().paymentMethodList.first, isUpdate: false);
     _currentAmount = _orderController.placeOrderBody!.orderAmount! - Get.find<OrderController>().previousDueAmount();

     _payableAmount = _orderController.placeOrderBody!.orderAmount!;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(builder: (orderController) {
      
      OrderDetailsModel _orderDetailsModel = OrderDetailsModel(
        orderID: 'no_id',
        paymentMethod: orderController.selectedMethod,
        cartList: Get.find<CartController>().cartList,
        paidAmount: double.tryParse(_amountTextController.text),
        change: _changeAmount,
      );

      void _callback(
          bool isSuccess,
          String message,
          String orderID
          ) async {

        _orderDetailsModel = _orderDetailsModel.copyWith(id: orderID);
        if(isSuccess) {
          Get.find<CartController>().clearCartData();
          Get.find<OrderController>().updateOrderNote(null);
          orderController.setSelectedMethod(orderController.paymentMethodList.first);
          if(orderController.getOrderSuccessModel() != null) {
            orderController.getCurrentOrder(orderController.orderSuccessModel!.orderId!).then((value){
              Get.off(()=> OrderSuccessScreen(fromPlaceOrder: true));
            });

          }



        }else {
          showCustomSnackBar(message);
        }

      }

        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: ResponsiveHelper.isTab(context) ? null : CustomAppBar(
            isBackButtonExist: true, onBackPressed: null, showCart: true,
          ),
          body: ResponsiveHelper.isTab(context)
              ? BodyTemplate(body: Flexible(child: _body(orderController, context, _callback)))
              : _body(orderController, context, _callback),
        );
      }
    );
  }

  Widget _body(
      OrderController orderController,
      BuildContext context,
      void _callback(bool isSuccess, String message, String orderID),
      ) {

    return SingleChildScrollView(
      child: Column( children: [
        SizedBox(height: Dimensions.paddingSizeExtraLarge),

        Text('paid_by'.tr, style: robotoRegular,),

        FilterButtonWidget(
          isSmall: Get.width < 390,
            items: orderController.paymentMethodList,
            type: orderController.selectedMethod,
            isBorder: true,

            onSelected: (_method) {
              if(_method != 'cash') {
                _amountTextController..text = PriceConverter.convertPrice(orderController.placeOrderBody!.orderAmount!);
              }else{
                _amountTextController.clear();
              }
              orderController.setSelectedMethod(_method);

            }
        ),

        Image.asset(Images.poss_image, height: Get.height * 0.2),
        SizedBox(height: Dimensions.paddingSizeLarge,),

        Text('payment_pending'.tr, style: robotoRegular),
        SizedBox(height: Dimensions.paddingSizeLarge,),

        Padding(
          padding: ResponsiveHelper.isTab(context) ?
          EdgeInsets.symmetric(horizontal: Get.width * 0.08) : EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Container(
            padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault, horizontal: Dimensions.paddingSizeDefault),
            margin: EdgeInsets.only(bottom: Dimensions.paddingSizeExtraLarge),
            decoration: BoxDecoration(
              color: Theme.of(context).canvasColor, borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).textTheme.bodyText1!.color!.withOpacity(0.05),
                  offset: Offset(0, 2.75), blurRadius: 6.86,
                )
              ],
            ),
            child: Column( children: [

              if(ResponsiveHelper.isTab(context)) SizedBox(height: Dimensions.paddingSizeExtraLarge,),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Row(children: [
                  SizedBox(width: 100,child: Text('paid_amount'.tr)),
                  SizedBox(width: Dimensions.paddingSizeLarge),

                  Expanded(
                    child: SizedBox(
                      height: Get.width < 390 ? 30 : ResponsiveHelper.isSmallTab() ? 40 : ResponsiveHelper.isTab(context) ? 50 : 40,
                      child: IgnorePointer(
                        ignoring: orderController.selectedMethod != 'cash',
                        child: CustomTextField(
                          borderColor: Theme.of(context).primaryColor.withOpacity(0.4),
                          hintText: 'enter_amount'.tr,
                          controller: _amountTextController,
                          inputFormatter:[
                            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
                            LengthLimitingTextInputFormatter(10),
                          ],
                          hintStyle: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                          onChanged: (value) {
                            if(double.parse(value) > Get.find<CartController>().totalAmount) {
                              _changeAmount = (Get.find<CartController>().totalAmount  - double.parse(value)) * - 1.0;
                            }else{
                              _changeAmount = 0;
                            }
                            orderController.update();
                          },
                        ),
                      ),
                    ),
                  ),

                ],),
              ),
              if(!ResponsiveHelper.isTab(context))
                SizedBox(height: Dimensions.paddingSizeDefault,),

              !ResponsiveHelper.isTab(context) ?  Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Row(children: [
                  Flexible(child: SizedBox(width: 100,child: Text('previous_due'.tr))),

                  SizedBox(width: Dimensions.paddingSizeExtraLarge),

                  Expanded(
                    child:Text('${PriceConverter.convertPrice(orderController.previousDueAmount())}'),
                  ),

                ],),
              ) : SizedBox(),

              if(!ResponsiveHelper.isTab(context))
                SizedBox(height: Dimensions.paddingSizeDefault,),


              !ResponsiveHelper.isTab(context) ?  Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Row(children: [
                  Flexible(child: SizedBox(width: 100,child: Text('current_amount'.tr))),

                  SizedBox(width: Dimensions.paddingSizeExtraLarge),

                  Expanded(
                    child:Text('${ PriceConverter.convertPrice(_currentAmount)}'),
                  ),

                ],),
              ) : SizedBox(),

              if(!ResponsiveHelper.isTab(context))
                SizedBox(height: Dimensions.paddingSizeDefault,),

              !ResponsiveHelper.isTab(context) ?  Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Row(children: [
                  Flexible(child: SizedBox(width: 100,child: Text('payable_amount'.tr))),

                  SizedBox(width: Dimensions.paddingSizeExtraLarge),

                  Expanded(
                    child:Text('${PriceConverter.convertPrice(_payableAmount)}'),
                  ),

                ],),
              ) : SizedBox(),

              SizedBox(height: Dimensions.paddingSizeDefault,),

              orderController.selectedMethod == 'cash' ?  Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeLarge),
                child: Row(children: [
                  Flexible(child: SizedBox(width: 100,child: Text('change'.tr))),

                  SizedBox(width: Dimensions.paddingSizeExtraLarge),

                  Expanded(
                    child:Text('${PriceConverter.convertPrice(_changeAmount)}'),
                  ),

                ],),
              ) : SizedBox(),




              SizedBox(height: Dimensions.paddingSizeExtraLarge,),

              orderController.isLoading ? Center(child: CustomLoader(color: Theme.of(context).primaryColor),
              ) : Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: Row(children: [
                  Expanded(
                    child: CustomButton(
                      height: ResponsiveHelper.isSmallTab() ? 40 : ResponsiveHelper.isTab(context) ? 50 : 40,
                      transparent: true, buttonText: 'pay_after_eating'.tr,
                      fontSize: Get.width < 390 ? 12 : null,
                      onPressed: () {
                        orderController.placeOrder(
                          orderController.placeOrderBody!.copyWith(
                            paymentStatus: 'unpaid', paymentMethod: '',
                            previousDue: orderController.previousDueAmount(),
                          ), _callback, '0', 0,
                        );
                      },
                    ),
                  ),
                  SizedBox(width: Dimensions.paddingSizeLarge,),

                  Expanded(
                    child: CustomButton(
                      height: ResponsiveHelper.isSmallTab() ? 40 : ResponsiveHelper.isTab(context) ? 50 : 40,
                      buttonText: 'confirm_payment'.tr,
                      fontSize: Get.width < 390 ? 12 : null,

                      onPressed: (){
                        if(orderController.selectedMethod == 'cash' && _amountTextController.text.isEmpty) {
                          showCustomSnackBar('please_enter_your_amount'.tr);

                        }else if(orderController.selectedMethod == 'cash' && orderController.placeOrderBody!.orderAmount! > int.parse(_amountTextController.text)){
                          showCustomSnackBar('you_need_pay_more_amount'.tr);

                        }else{
                          orderController.placeOrder(
                            orderController.placeOrderBody!.copyWith(
                              paymentStatus: 'paid', paymentMethod: orderController.selectedMethod,
                              previousDue: orderController.previousDueAmount(),
                            ), _callback, _amountTextController.text, _changeAmount,
                          );
                          print(jsonEncode(orderController.placeOrderBody));
                        }},
                    ),
                  ),
                ],),
              ),
              if(ResponsiveHelper.isTab(context)) SizedBox(height: Dimensions.paddingSizeExtraLarge,),
            ],),
          ),
        ),

        SizedBox(height: MediaQuery.of(context).viewInsets.bottom,),

      ],),
    );
  }




}

class OrderDetailsModel{
  String orderID;
  double? paidAmount;
  double? change;
  String paymentMethod;
  List<CartModel> cartList;

  OrderDetailsModel({
    required this.orderID,
    this.paidAmount,
    this.change,
    required this.paymentMethod,
    required this.cartList,
  });

  OrderDetailsModel copyWith({required String id}) {
    orderID = id;
    return this;
  }
}
