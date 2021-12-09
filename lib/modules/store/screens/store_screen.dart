import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';
import 'package:url_launcher/url_launcher.dart';

class StoreScreen extends GetWidget<StoreController> {
  TextEditingController searchCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.getList();
    return Obx(() {
      return Column(
        children: [
          Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: AppColor.pinkPrimary),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    onChanged: (value) {
                      if (value != '')
                        controller.search(value);
                      else
                        controller.getList();
                    },
                    onFieldSubmitted: (value) {
                      if (value != '')
                        controller.search(value);
                      else
                        controller.getList();
                    },
                    style: TextStyle(fontSize: 18, color: AppColor.pinkPrimary),
                    controller: searchCtrl,
                    decoration: InputDecoration(border: InputBorder.none),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      if (searchCtrl.text != '')
                        controller.search(searchCtrl.text);
                      else
                        controller.getList();
                    },
                    icon: Icon(Icons.search)),
              ],
            ),
          ),
          controller.isLoading.value
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: CircularProgressIndicator(
                    color: AppColor.pinkPrimary,
                  ),
                )
              : controller.stores.length == 0
                  ? Center(
                      child: Text('No store info yet...'.tr,
                          style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic)),
                    )
                  : Expanded(
                      child: getStoreList(controller),
                    ),
        ],
      );
    });
  }

  getStoreList(StoreController controller) {
    return RefreshIndicator(
      color: AppColor.whiteMain,
      backgroundColor: AppColor.pinkPrimary,
      onRefresh: () {
        searchCtrl.text = '';
        return controller.getList();
      },
      child: ListView.builder(
          itemCount: controller.stores.length,
          padding: EdgeInsets.all(5),
          itemBuilder: (BuildContext context, int index) {
            Stores store = controller.stores[index];
            return Obx(() {
              if (controller.isAddLoading.value) {
                if (index == controller.stores.length - 1) {
                  return Container(
                    child: AppBtn(
                      padding: EdgeInsets.all(18),
                      borderSide: BorderSide(color: AppColor.pinkPrimary),
                      child: LoadingScreen(),
                    ),
                  );
                }
              }
              return AppBtn(
                margin: EdgeInsets.all(5),
                padding: EdgeInsets.all(18),
                borderSide: BorderSide(color: AppColor.pinkPrimary),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(store.name ?? '',
                          style: TextStyle(fontWeight: AppFont.wBold, fontSize: 19)),
                      Text('address'.tr + ': ' + (store.address ?? ''),
                          style: TextStyle(fontSize: 16)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                              'phoneNumber'.tr +
                                  ': ' +
                                  (store.phone ?? (Storage.getPhoneHelper() ?? '')),
                              style: TextStyle(fontSize: 16)),
                          Text(store.openCloseTime ?? '',
                              style: TextStyle(
                                fontWeight: AppFont.wBold,
                              )),
                        ],
                      ),
                    ],
                  ),
                ),
                callback: () => launch('tel:${store.phone ?? (Storage.getPhoneHelper() ?? '')}'),
              );
            });
          }),
    );
  }
}
