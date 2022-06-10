import 'package:camera/camera.dart';
import 'package:discoveryourplate/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:tflite/tflite.dart';
class LiveDetection extends StatefulWidget {
  const LiveDetection({Key? key}) : super(key: key);

  @override
  State<LiveDetection> createState() => _LiveDetectionState();
}

class _LiveDetectionState extends State<LiveDetection> {

  CameraController? controller;
  CameraImage ? cameraimage;
  bool isWorking=false;
  bool loadin=false;
  List ? recognitionList=[];

  // Display 'Loading' text wghen the camera is still loading.
  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {


      return Center(
        child: const Text(
          'Loading..',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20.0,
            fontWeight: FontWeight.w900,
          ),
        ),
      );
    }


    return AspectRatio(
      aspectRatio:

      controller!.value.aspectRatio/2.5
      ,
      child: CameraPreview(
        controller!,

      ),
    );
  }

  Future loadmodal() async {

    await Tflite.loadModel(
        model: "LiveDetectionAssets/ssd_mobilenet.tflite",
        labels: "LiveDetectionAssets/ssd_mobilenet.txt",
        numThreads: 1, // defaults to 1
        isAsset: true, // defaults to true, set to false to load resources outside assets
        useGpuDelegate: false // defaults to false, set to true to use GPU delegate
    );
  }

  List<Widget> renderBoxes(Size screen) {
    if (recognitionList == null) return [];
    if (cameraimage!.height == null || cameraimage!.width == null) return [];

    double factorX = screen.width+30;
    double factorY = cameraimage!.height -600/ cameraimage!.width * screen.width/2;
    Color blue = Color.fromRGBO(37, 213, 253, 1.0);
    return recognitionList!.map((re) {
      return Positioned(
        left: re["rect"]["x"] * factorX,
        top: re["rect"]["y"] * factorY+40,
        width: re["rect"]["w"] * factorX-30,
        height: re["rect"]["h"] * factorY,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
            border: Border.all(
              color: blue,
              width: 2,
            ),
          ),
          child: Center(
            child: Text(
              "${re["detectedClass"]} ${(re["confidenceInClass"] * 100).toStringAsFixed(0)}%",
              style: TextStyle(
                background: Paint()..color = Colors.pink,
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      );
    }).toList();
  }


  Future runModalIoFrame()async{

    recognitionList= await Tflite.detectObjectOnFrame(
      bytesList: cameraimage!.planes.map((plane) {return plane.bytes;}).toList(),// required
      model: "SSDMobileNet",
      imageHeight: cameraimage!.height,
      imageWidth: cameraimage!.width,
      imageMean: 127.5,   // defaults to 127.5
      imageStd: 127.5,    // defaults to 127.5
      rotation: 90,       // defaults to 90, Android only
      numResultsPerClass: 1,      // defaults to 5
      threshold: 0.4,     // defaults to 0.1
      // defaults to true
    );
    isWorking=false;
    setState(() {
      cameraimage;
    });


  }
  initcamera() async {

    controller=controller=CameraController(cameras![0], ResolutionPreset.medium);
    await controller!.initialize().then((value)
    {
      print("step7");
      setState(() {
        controller!.startImageStream((imagefromstream) => {
          print("step2"),
          if(!isWorking){
            print("step3"),
            isWorking=true,
            cameraimage=imagefromstream,
            print("step4"),
            runModalIoFrame(),
            print("step6"),
          }
        });
      });


    });
  }

  @override
  void initState() {
    // TODO: implement initState
loadmodal();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    initcamera();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    controller!.stopImageStream();
    controller!.dispose();
    Tflite.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height=MediaQuery.of(context).size.height;
    final width=MediaQuery.of(context).size.width;

    List<Widget> stackChildrenWidget=[];
    stackChildrenWidget.add(
      Positioned(
        top: 0,
        left: 0,
        width: width,
        child: Container(
          width: width,
          alignment: Alignment.bottomCenter,
          height: height*1,
          child: _cameraPreviewWidget(),

        ),
      ),
    );
    if(cameraimage!=null){

      stackChildrenWidget.addAll(renderBoxes(MediaQuery.of(context).size));
    }

    return Scaffold(

      body:      Container(
        height: height*0.9,
        alignment: Alignment.bottomCenter,
        child: Center(
          child: Stack(
              children: stackChildrenWidget
          ),
        ),
      ),

    );
  }
}