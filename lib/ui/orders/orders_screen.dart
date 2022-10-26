import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 200,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          backgroundColor: Colors.grey,
          flexibleSpace: FlexibleSpaceBar(
              titlePadding: const EdgeInsets.all(16),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  //ImageFiltered(
                    //imageFilter: ImageFilter.blur(sigmaX: 1, sigmaY: 1),
                    //child: data.imageUrl == null
                        //? const FlutterLogo()
                        //: Image.network(
                          //  data.imageUrl!,
                           // fit: BoxFit.cover,
                          //),
                  //),
                  Container(color: Colors.black.withOpacity(0.2)),
                ],
              ),
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  //data.logoUrl == null
                    //  ? const FlutterLogo()
                      //: Image.network(
                        //  data.logoUrl!,
                          //height: 50,
                          //width: 50,
                        //),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'PEDIDOS',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
        ),
        SliverToBoxAdapter(
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 20),
              height: 10,
              alignment: Alignment.center,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 4,
                itemBuilder: (context, index) {
                  //final cat = data.categories[index];
                  //final isSelected = selectedCategoryIndex == index;
                  return Padding(
                    padding: EdgeInsets.only(
                      right: 15,
                      top: 2,
                      bottom: 2,
                      left: index == 0 ? 10 : 0,
                    ),
                  );
                },
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index){
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                     child: Container(
                       color:
                           index % 2 == 0 ? Colors.grey : Colors.white30,
                       height: 80,
                       alignment: Alignment.center,
                       child: Text(
                         "Item $index",
                         style: const TextStyle(fontSize: 30),
                       ),
                     ),
                );
              },
              childCount: 8, 
            ),
          ),
         const SliverToBoxAdapter(child: SizedBox(height: 60)),
      ],
    );          
  }

}