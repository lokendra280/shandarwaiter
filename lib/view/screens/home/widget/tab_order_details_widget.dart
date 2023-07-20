import 'package:efood_table_booking/util/dimensions.dart';
import 'package:efood_table_booking/util/styles.dart';
import 'package:efood_table_booking/view/base/custom_divider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:get/get.dart';

class TabOrderDetailsWidget extends StatelessWidget {
  const TabOrderDetailsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          transform: Matrix4.translationValues(0.0, -100.0, 0.0),
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  boxShadow:Get.isDarkMode ? null: [BoxShadow(color: Colors.grey[300]!, blurRadius: 1, spreadRadius: 1, offset: Offset(0,4))],
                ),
                child: Column(children: [

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                    child: Container(
                      child: Row(crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("${'note'.tr}: ", style: robotoBold),
                          Expanded(child: Text('Here is your not will be appear from customer Here is your not will be appear from customer', maxLines: 5,overflow: TextOverflow.clip,)),
                        ],
                      ),
                    ),
                  ),
                  CustomDivider(),
                  SizedBox(height: Dimensions.paddingSizeDefault),
                ],),),
              ClipPath(
                clipper: MultipleRoundedCurveClipper(),
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  height: 12,
                ),
              ),


            ],
          ),
        ),

      ],
    );
  }
}
