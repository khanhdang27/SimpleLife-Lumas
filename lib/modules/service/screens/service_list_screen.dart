import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class ServiceListScreen extends GetWidget<ServiceController> {
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
              title: Text("${controller.type.name}"),
              searchCtrl: searchCtrl,
              callback: (value) {
                controller.getList(name: value, typeId: controller.typeId);
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
    if (controller.isAddLoading.value) {}
    return NotificationListener<ScrollEndNotification> (
      child: RefreshIndicator(
        color: AppColor.whiteMain,
        backgroundColor: AppColor.pinkPrimary,
        onRefresh: () => controller.getList(name: searchCtrl.text, typeId: controller.typeId),
        child:  ListView.separated(
          shrinkWrap: true,
          padding: const EdgeInsets.all(8),
          itemCount: controller.services.length,
          itemBuilder: (BuildContext context, int index) {
            Service service = controller.services[index];
            return Obx(() {
              if(controller.isAddLoading.value){
                if(index == controller.services.length-1){
                  return Container(
                    child: AppBtn(
                      padding: EdgeInsets.all(18),
                      borderSide: BorderSide(
                          color: AppColor.pinkPrimary
                      ),
                      child: LoadingScreen(),
                    ),
                  );
                }
              }
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
            });
          },
          separatorBuilder: (BuildContext context, int index) => const Divider(),
        )
      ),
      onNotification: (t){
        var metrics = t.metrics;
        if (metrics.atEdge) {
          //is bottom
          if (metrics.pixels != 0) // metrics.pixels == 0 is top
            controller.addList();
        }
        return true;
      },
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
          Expanded(
            flex: 5,
            child: Container(
              child: Align(
               alignment: Alignment.topRight,
               child: GestureDetector(
                 child: Label(
                   icon: Obx(() => Icon(iconSort.value, size: 20,)),
                   text: "price".tr,
                     style: TextStyle(
                       decoration: TextDecoration.underline,
                       fontSize: 18,
                       color: AppColor.serviceColor,
                       fontWeight: AppFont.wMedium
                     )
                 ),
                 onTap: (){
                   if(iconSort.value == Icons.arrow_upward){
                     iconSort(Icons.arrow_downward);
                     controller.getList(name: searchCtrl.text, typeId: controller.typeId, priceSort: 'DESC');
                   }else{
                     iconSort(Icons.arrow_upward);
                     controller.getList(name: searchCtrl.text, typeId: controller.typeId, priceSort: 'ASC');
                   }
                 },
               )
              ),
            )
          ),
        ],
      ),
    );
  }

  Widget getServiceItem(service){
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
                  child: Text('${service.name}', style: TextStyle(
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
                  child: Text("${service.intendTime} "+"minutes".tr, style: TextStyle(fontSize: 13, color: color, fontWeight: AppFont.wBold)
                  )
              ),
              Row(
                children: [
                  Expanded(
                    flex: 5,
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text("${service.type!.name}".tr, style: TextStyle(fontSize: 14,color: color, fontWeight: AppFont.wBold)
                        )
                    ),
                  ),
                  Expanded(
                    flex: 5,
                    child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                            "${service.price}",
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
        callback: () => controller.getDetailScreen(service.id)
    );
  }
}
