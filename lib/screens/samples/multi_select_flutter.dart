import 'package:multi_select_item/multi_select_item.dart';
import 'package:flutter/material.dart';

class MultiSelectListDemo extends StatefulWidget {
  @override
  _MultiSelectListDemoState createState() => new _MultiSelectListDemoState();
}

class _MultiSelectListDemoState extends State<MultiSelectListDemo> {


  List multiSelectList = [];


  MultiSelectListDemo controller = new MultiSelectListDemo();

  @override
  void initState() {
    super.initState();

    multiSelectList.add({"images": 'assets/images/resort_1.jpg', "desc":"Welcome to New York City!"});
    multiSelectList.add({"images":'assets/images/resort_2.jpg' ,"desc":"Welcome to Los Angeles!"});
    multiSelectList.add({"images":'assets/images/resort_3.jpg' ,"desc":"Welcome to Chicago!"});
    multiSelectList.add({"images":'assets/images/resort_4.jpg', "desc":"Welcome to Houston!"});
    multiSelectList.add({"images":'assets/images/sanfrancisco.jpg', "desc":"Welcome to San francisco!"});

    controller.disableEditingWhenNoneSelected = true;
    controller.set(multiSelectList.length);
  }

  void add() {
    multiSelectList.add({"images": multiSelectList.length});
    multiSelectList.add({"desc": multiSelectList.length});

    setState(() {
      controller.set(multiSelectList.length);
    });
  }

  void delete() {
    var list = controller.selectedIndexes;
    list.sort((b, a) =>
        a.compareTo(b)); 
    list.forEach((element) {
      multiSelectList.removeAt(element);
    });

    setState(() {
      controller.set(multiSelectList.length);
    });
  }

  void selectAll() {
    setState(() {
      controller.toggleAll();
    });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        var before = !controller.isSelecting;
        setState(() {
          controller.deselectAll();
        });
        return before;
      },
      child: new Scaffold(
        appBar: new AppBar(
          title: new Text('Selected ${controller.selectedIndexes.length}' ),
          actions: (controller.isSelecting)
              ? <Widget>[
            IconButton(
              icon: Icon(Icons.select_all),
              onPressed: selectAll,
            ),
            IconButton(
              icon: Icon(Icons.delete),
              onPressed: delete,
            )
          ]
              : <Widget>[],
        ),
        body:Container(

          child: ListView.builder(
            itemCount: multiSelectList.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {},
                child: MultiSelectItem(
                  isSelecting: controller.isSelecting,
                  onSelected: () {
                    setState(() {
                      controller.toggle(index);
                    });
                  },
                  child:Container(
                      height:75,
                    margin: EdgeInsets.only(left:15,right:15,top:15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.transparent,
                    ),
                    child:Card(
                      color:controller.isSelected(index)
                          ? Colors.grey.shade200:Colors.white,
                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.all(Radius.circular(8.0)),

                      ),
                      child:Padding(
                        padding:EdgeInsets.symmetric(vertical:10, horizontal: 12),
                        child: Row(
                          children: [
                            //contentPadding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child:Image.asset(multiSelectList[index]['images'],fit:BoxFit.cover,width:60,height:60,),
                            ),
                            SizedBox(width:20,),
                            Text(multiSelectList[index]['desc'], style: TextStyle(fontSize:14)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}