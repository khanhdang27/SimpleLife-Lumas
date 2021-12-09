import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class PaidServiceListScreen extends GetWidget<ClientController> {
  TextEditingController searchCtrl = TextEditingController();
  dynamic iconSort = Icons.import_export.obs;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: LayoutSecond(
        header: PreferredSize(
            preferredSize: Size.fromHeight(40.0), // here the desired height
            child: SearchBar(
              searchCtrl: searchCtrl,
              callback: (value) {
                controller.getPaidServiceList(clientId: controller.client.id, key: value);
                iconSort(Icons.import_export);
              },
            ),
        ),
        child: Column(
          children: [
            Expanded(
              child: Obx((){
                if(controller.isLoading.value){
                  return Center(child: LoadingScreen());
                }
                if(controller.services.length == 0){
                  return getToolBar();
                }

                return getServiceList();
              })
            )
          ],
        ),
      ),
    );
  }

  Widget getServiceList(){
    if (controller.isLoading.value) {}
    return RefreshIndicator(
        color: AppColor.whiteMain,
        backgroundColor: AppColor.pinkPrimary,
        onRefresh: () => controller.getPaidServiceList(clientId: controller.client.id),
        child:  ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: controller.services.length,
          itemBuilder: (BuildContext context, int index) {
            ClientService service = controller.services[index];
            if(index == 0){
              return Column(
                children: [
                  getToolBar(),
                  Container(
                    width: double.infinity,
                    child: getServiceItem(service),
                  )
                ],
              );
            }

            return Container(
              child: getServiceItem(service),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
    );
  }

  Widget getToolBar(){
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Row(
        children: [
          Expanded(
           flex: 5,
           child: Container(
             child: Align(
               alignment: Alignment.topLeft,
               child: Text('total'.tr+": ${controller.services.length}", style: TextStyle(fontSize: 17, color: AppColor.serviceColor, fontWeight: AppFont.wMedium))
             ),
           )
          ),
        ],
      ),
    );
  }

  Widget getServiceItem(service){
    ClientService item = service;
    var color = Color.fromRGBO(253, 103, 93, 1.0);
    return AppBtn(
        padding: EdgeInsets.zero,
        borderSide: BorderSide(
          color: Colors.pink,
        ),
        child : Container(
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(AppAsset.backgroundService),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${item.service!.name}', style: TextStyle(
                    fontWeight: AppFont.wBold,
                    color: color,
                    fontSize: 16,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.white,
                      ),
                    ],

                  )
                  )
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text('${item.code}', style: TextStyle(
                    fontWeight: AppFont.wBold,
                    color: color,
                    fontSize: 15,
                    shadows: <Shadow>[
                      Shadow(
                        offset: Offset(1.0, 2.0),
                        blurRadius: 2.0,
                        color: Colors.white,
                      ),
                    ],

                  )
                  )
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("${item.service!.intendTime} "+"minutes".tr, style: TextStyle(fontSize: 13, color: color, fontWeight: AppFont.wBold)
                  )
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("remaining".tr + ": ${item.remainingQuantity}".tr, style: TextStyle(fontSize: 15,color: color, fontWeight: AppFont.wBold)
                        )
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            "${item.totalPrice}",
                            style: TextStyle(
                              fontSize: 16,
                              color: color,
                              fontWeight: AppFont.wMedium,
                              shadows: <Shadow>[
                                Shadow(
                                  offset: Offset(1.0, 2.0),
                                  blurRadius: 2.0,
                                  color: Colors.white,
                                ),
                              ],
                            )
                        )
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        callback: () => controller.getPaidServiceDetail(item.id)
    );
  }
}
