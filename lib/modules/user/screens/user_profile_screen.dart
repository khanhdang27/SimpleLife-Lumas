import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/configs/app_color.dart';
import 'package:lumas/general/general.dart';

class UserProfileScreen extends StatelessWidget {
  UserController userController = Get.find();

  @override
  Widget build(BuildContext context) {
      return Layout(
        header: AppBar(
          title: Text('profile'.tr),
        ),
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: new Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(top: 20.0),
                    child: new Stack(fit: StackFit.loose, children: <Widget>[
                      new Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Container(
                              width: 140.0,
                              height: 140.0,
                              decoration: new BoxDecoration(
                                shape: BoxShape.circle,
                                image: new DecorationImage(
                                  image:  NetworkImage("https://cdn.icon-icons.com/icons2/2506/PNG/512/user_icon_150670.png"),
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ],
                      ),
                    ]),
                  )
                ],
              ),
            ),
            Container(
              color: Color(0xffFFFFFF),
              child: Padding(
                padding: EdgeInsets.only(bottom: 25.0),
                child: new Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.only(
                            left: 25.0, right: 25.0, top: 25.0),
                        child: new Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            new Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                new Text(
                                  'personalInformation'.tr,
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ],
                        )
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'name'.tr,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              userController.user.name,
                              style: TextStyle(fontSize: 20, color: AppColor.pinkPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'email'.tr,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              userController.user.email,
                              style: TextStyle(fontSize: 20, color: AppColor.pinkPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'role'.tr,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              userController.user.role.name,
                              style: TextStyle(fontSize: 20, color: AppColor.pinkPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),
                    /*Padding(
                      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 25.0),
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            child: Text(
                              'status'.tr,
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                          Container(
                            child: Text(
                              '${userController.user.status}',
                              style: TextStyle(fontSize: 20, color: AppColor.pinkPrimary),
                            ),
                          ),
                        ],
                      ),
                    ),*/
                  ],
                ),
              ),
            )
          ],
        ),
      );
  }
}