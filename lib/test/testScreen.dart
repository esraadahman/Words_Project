import 'package:flutter/material.dart';
//import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class testScreen extends StatelessWidget {
  const testScreen({super.key});

  @override
  Widget build(BuildContext context) {
    late Box box;

    return Scaffold(
      appBar: AppBar(
        title: const Text(""),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () async {
                //**** */ open box is one time and it is take String only
                //  await   Hive.openBox<String>('test');
                box = await Hive.openBox("testbox");
              },
              child: const Text("open box")),
          const SizedBox(
            height: 20,
          ),
          // ElevatedButton(
          //     onPressed: () {
          //       print('clicked');
          //       Box testBox = Hive.box<String>('test');
          //     },
          //     child: Text("Access"))

          // ElevatedButton(
          //     onPressed: () {
          //       // box.put("name", "esraa");
          //    //   box.putAll({"name": "esraa22", "age": 30});

          //     },
          //     child: const Text("put data")),

          ElevatedButton(
              onPressed: () {
                // box.addAll([
                //   1,
                //   'dd',
                //   [1, 2, 3],
                //   false
                // ]);
                box.add("esraa222");
                //  box.put(79, 'adam');
              },
              child: const Text("add data")),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                //  print(box.get(90,defaultValue: true));
                print(box.values.toList());
              },
              child: const Text("Display data")),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () async {
                await box.deleteFromDisk();
              },
              child: const Text("delete data")),
        ],
      ),
    );
  }
}
