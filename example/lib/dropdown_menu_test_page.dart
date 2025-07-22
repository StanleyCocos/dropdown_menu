import 'package:dropdown_menu/dropdown_menu.dart';
import 'package:flutter/material.dart';

class SortCondition {
  String name;
  bool isSelected;

  SortCondition({
    required this.name,
    required this.isSelected,
  });
}

class TestPage extends StatefulWidget {
  const TestPage({super.key});

  @override
  State<StatefulWidget> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  final DropdownMenuController _dropdownMenuController = DropdownMenuController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey _stackKey = GlobalKey();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text(
          '拉筛选菜单',
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Stack(
        key: _stackKey,
        children: <Widget>[
          Column(
            children: <Widget>[
              DropDownHeader(
                children: [
                  Container(
                    width: 100,
                    height: 40,
                    color: Colors.red,
                    child: Text('1'),
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    color: Colors.red,
                    child: Text('2'),
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    color: Colors.red,
                    child: Text('3'),
                  ),
                  Container(
                    width: 100,
                    height: 40,
                    color: Colors.red,
                    child: Text('4'),
                  ),
                ],
                stackKey: _stackKey,
                controller: _dropdownMenuController,
                onItemTap: <int>(index) {
                  print("_TestPageState.build -->$index ");
                  if (index == 3) {
                    _dropdownMenuController.hide();
                  }
                },
              ),
              Expanded(
                child: ListView.separated(
                  itemCount: 100,
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(height: 1.0),
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      child: ListTile(
                        leading: Text('test$index'),
                      ),
                      onTap: () {},
                    );
                  },
                ),
              ),
            ],
          ),
          DropDownMenu(
            controller: _dropdownMenuController,
            animationMilliseconds: 300,
            dropdownMenuChanging: (isShow, index) {
              setState(() {
                print('(正在${isShow ? '显示' : '隐藏'}$index)');
              });
            },
            dropdownMenuChanged: (isShow, index) {
              setState(() {
                print('(已经${isShow ? '显示' : '隐藏'}$index)');
              });
            },
            menus: [
              DropdownMenuBuilder(
                dropDownHeight: 40 * 8.0,
                dropDownWidget: Container(
                  width: double.infinity,
                  height: 200,
                  color: Colors.black,
                )
              ),

              DropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: Container(
                    width: double.infinity,
                    height: 300,
                    color: Colors.green,
                  )
              ),
              DropdownMenuBuilder(
                  dropDownHeight: 40 * 8.0,
                  dropDownWidget: Container(
                    width: double.infinity,
                    height: 400,
                    color: Colors.yellow,
                  )
              ),
            ],
          ),
        ],
      ),
    );
  }
}
