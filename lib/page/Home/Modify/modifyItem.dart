import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import '../../../commonComponents/constants.dart';
import '../Home/petlist.dart';

class ModifyItem extends StatefulWidget {
  final petRowData rowData;
  const ModifyItem({Key? key, required this.rowData}) : super(key: key);

  @override
  State<ModifyItem> createState() => _ModifyItemState();
}

class _ModifyItemState extends State<ModifyItem> {
  @override
  Widget build(BuildContext context) {
    int width = MediaQuery.of(context).size.width.toInt();
    int height = MediaQuery.of(context).size.height.toInt();
    return Container(
      child: Column(
        children: [
          Container(
            width: width * 1,
            height: height * 0.2,
            color: Colors.white,
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _showCustomModalBottomSheet(width, height);
                },
                child: Image(
                  image: AssetImage(widget.rowData.src),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                  height: height * 0.1,
                  width: height * 0.1,
                ),
              ),
            ),
          ),
          SizedBox(height: height * 0.05),
          Container(
            margin: EdgeInsets.symmetric(horizontal: width * 0.05),
            width: width * 1,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Column(
              children: [
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black45),
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      minimumSize: Size(width * 1, 50),
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(10),
                        ),
                      ),
                      side: BorderSide.none,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Name',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '${widget.rowData.number}',
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(width: 1, color: Colors.black45),
                    ),
                  ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      minimumSize: Size(width * 1, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                      side: BorderSide.none,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Baseline(mg/dl)',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '200',
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  // decoration: const BoxDecoration(
                  //   border: Border(
                  //     bottom: BorderSide(width: 1, color: Colors.transparent),
                  //   ),
                  // ),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      splashFactory: NoSplash.splashFactory,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      minimumSize: Size(width * 1, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          bottom: Radius.circular(10),
                        ),
                      ),
                      side: BorderSide.none,
                    ),
                    onPressed: () {},
                    child: Row(
                      children: [
                        const FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            'Baseline(℃)',
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        ),
                        const Spacer(),
                        FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            '40',
                            style: const TextStyle(fontSize: 16, color: Colors.black),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showCustomModalBottomSheet(int width, int height) async {
    return showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(10),
            ),
          ),
          height: 300,
          width: width * 1,
          child: Column(
            children: [
              Container(
                width: width * 0.1,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Image(
                  image: AssetImage(widget.rowData.src),
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.center,
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  splashFactory: NoSplash.splashFactory,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size(width * 1, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Image(
                      image: AssetImage('assets/home/gallery.png'),
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Select from gallery',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  splashFactory: NoSplash.splashFactory,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size(width * 1, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage('assets/home/camera.png'),
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Photograph',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  splashFactory: NoSplash.splashFactory,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size(width * 1, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage('assets/home/edit.png'),
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                    ),
                    SizedBox(width: width * 0.05),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Edit icon',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  splashFactory: NoSplash.splashFactory,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  minimumSize: Size(width * 1, 50),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                ),
                onPressed: () {},
                child: Row(
                  children: [
                    const Image(
                      image: AssetImage('assets/home/delete.png'),
                      fit: BoxFit.scaleDown,
                      width: 30,
                      height: 30,
                      color: Colors.red,
                    ),
                    SizedBox(width: width * 0.05),
                    const FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        'Remove current photo',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }
}