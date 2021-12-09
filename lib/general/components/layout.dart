import 'package:lumas/general/configs.dart';
import 'package:lumas/general/components/components.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lumas/general/general.dart';

class Layout extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? header;
  final Widget? drawer;
  final Widget? endDrawer;
  final background;

  const Layout({Key? key, required this.child, this.header, this.drawer, this.background, this.endDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperScreen(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          child: SafeArea(
            child: Scaffold(
              appBar: header,
              drawer: drawer,
              endDrawer: endDrawer,
              backgroundColor: background ?? AppColor.whiteMain,
              body: SingleChildScrollView(
                child: child,
              ),
              extendBody: true,
            ),
          ),
        ),
      ),
    );
  }
}

class LayoutSecond extends StatelessWidget {
  final Widget child;
  final PreferredSizeWidget? header;
  final Widget? drawer;
  final Widget? endDrawer;
  final background;

  const LayoutSecond({Key? key, required this.child, this.header, this.drawer, this.background, this.endDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperScreen(
      child: Container(
        child: SafeArea(
          child: Scaffold(
            appBar: header,
            drawer: drawer,
            endDrawer: endDrawer,
            backgroundColor: background ?? AppColor.whiteMain,
            body: child,
            extendBody: true,
          ),
        ),
      ),
    );
  }
}


class LayoutTab extends StatelessWidget {
  final Widget? child;
  final PreferredSizeWidget? header;
  final List<Tab> tabList;
  final List<Widget> tabViews;
  final GetxController? controller;
  final void Function(int)? callback;
  final bool bottomTabBar;
  final int? initialIndex;

  const LayoutTab({Key? key, this.child, this.header, required this.tabList, required this.tabViews, this.controller, this.callback, this.bottomTabBar = false, this.initialIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SuperScreen(
      child: DefaultTabController(
        initialIndex: initialIndex ?? 0,
        length: tabList.length,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColor.whiteMain,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: Image.asset(
              AppAsset.logo, width: 150,
            ),
            bottom: (bottomTabBar) ? null : TabBar(
              tabs: tabList,
              onTap: callback,
            ),
          ),
          bottomNavigationBar: (!bottomTabBar) ? null : Container(
            decoration: BoxDecoration(
              color: AppColor.whiteMain,
              border: Border.all(
                color: AppColor.pinkPrimary
              )
            ),
            child:  TabBar(
              tabs: tabList,
              onTap: callback,
            ),
          ),
          body: TabBarView(
            children: tabViews,
          ),
        ),
      ),
    );
  }
}
