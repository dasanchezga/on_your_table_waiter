import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TablesScreen extends ConsumerStatefulWidget {
  const TablesScreen({
    super.key,
    required this.selectedList,
    required this.isSelectionMode,
    required this.onSelectionChange,
  });

  final bool isSelectionMode;
  final Function(bool)? onSelectionChange;
  final List<bool> selectedList;

  @override
  ConsumerState<TablesScreen> createState() => _TablesScreenState();
}
int selectedIndex = 0;
  late List<bool> _selected;
  bool isSelectionMode = false;
//@override
  //void initState(){
    //initState();
    //initializeSelection();
  //}

  void initializeSelection(){
    _selected = List<bool>.generate(10, (_) => false);
  }

  @override
  void dispose(){
    _selected.clear();
    dispose();
  }

class _TablesScreenState extends ConsumerState<TablesScreen> {
  void _toggle(int index){
    if(widget.isSelectionMode){
      setState(() {
        widget.selectedList[index] = !widget.selectedList[index];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title:const Text('Mesas'),
        leading: isSelectionMode ?
        IconButton(
          onPressed: (){
            setState(() {
              isSelectionMode = false;
            });
            initializeSelection();
          },
           icon: const Icon(Icons.close),
         ) :const SizedBox(),
      ),
      body: GridView.builder(
      itemCount: widget.selectedList.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount( crossAxisCount: 2),
      itemBuilder: (context, int index ){
        return InkWell(
          onTap: ()=> _toggle(index),
          onLongPress: (){
            if(!widget.isSelectionMode){
              setState(() {
                widget.selectedList[index] = true;
              });
              widget.onSelectionChange!(true);
            }
          },
          child: GridTile(
              child: ListView(
                padding: const EdgeInsets.all(80.0),
                children: [
                    Center(child: FittedBox(
                       child: Text(
                      'Mesa N° $index',
                      style: const TextStyle( color: Colors.black87),
                      textAlign: TextAlign.center,
                     )
                    )                   
                    ),                
                    const Center(child:Icon(Icons.table_bar_sharp)),
                    widget.isSelectionMode
                    ? const Text('Estado:', textAlign: TextAlign.left,)
                  : const Text('Pedido:'),                                         
                ]
              ),
          ),
        );
      }
      )
    );
  }
}