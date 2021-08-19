import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() => runApp(GetMaterialApp(home: Home()));


///controller管理State、处理逻辑业务
class Controller extends GetxController {
  var count = 0.obs;
  
  increment() => count++;
}

///View包含controller实例，通过实例获取状态，更新状态
class Home extends StatelessWidget {
  @override
  Widget build(context) {
    // 使用Get.put()实例化你的类，使其对当下的所有子路由可用。
    final Controller control = Get.put(Controller());

    return Scaffold(
        // 使用Obx(()=>每当改变计数时，就更新Text()。
        appBar: AppBar(title: Obx(() => Text("Clicks: ${control.count}"))),

        // 用一个简单的Get.to()即可代替Navigator.push那8行，无需上下文！
        body: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    child: Text("Go to Other"), onPressed: () => Get.to(Other())),
                ///展示snackBar
                ElevatedButton(
                    child: Text("show snackBar"), onPressed: () => Get.snackbar('title', 'message')),
                ///展示dialog
                ElevatedButton(
                    child: Text("show dialog"), onPressed: () => Get.defaultDialog(title: 'what are you doing')),
                ///改变主题颜色
                ElevatedButton(
                    child: Text("change ThemeData"), onPressed: () => Get.changeTheme(ThemeData.dark())),
                ///改变主题颜色
                ElevatedButton(
                    child: Text("change ThemeData"), onPressed: () => Get.changeTheme(ThemeData.light())),
              ],
            )),
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add), onPressed: control.increment));
  }
}

class Other extends StatelessWidget {
  // 你可以让Get找到一个正在被其他页面使用的Controller，并将它返回给你。
  final Controller c = Get.find();

  @override
  Widget build(context) {
    // 访问更新后的计数变量
    return Scaffold(body: Center(child: Text("${c.count}")));
  }
}
