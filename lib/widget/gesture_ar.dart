// import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
// import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';
// import 'package:ar_flutter_plugin/models/ar_anchor.dart';
// import 'package:flutter/material.dart';
// import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
// import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
// import 'package:ar_flutter_plugin/datatypes/node_types.dart';
// import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
// import 'package:ar_flutter_plugin/models/ar_node.dart';
// import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';

// import 'package:vector_math/vector_math_64.dart';


// import '../models/models.dart';

// class ObjectGesturesWidget extends StatefulWidget {
//   final Product product;
//   const ObjectGesturesWidget({Key key,this.product}) : super(key: key);
//   @override
//   _ObjectGesturesWidgetState createState() => _ObjectGesturesWidgetState();
// }

// class _ObjectGesturesWidgetState extends State<ObjectGesturesWidget> {
//   ARSessionManager arSessionManager;
//   ARObjectManager arObjectManager;
//   ARAnchorManager arAnchorManager;

//   List<ARNode> nodes = [];
//   List<ARAnchor> anchors = [];

//   @override
//   void dispose() {
//     super.dispose();
//     arSessionManager.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           title: const Text('Object Transformation Gestures'),
//         ),
//         body:  Stack(children: [
//           ARView(
//             onARViewCreated: onARViewCreated,
//             planeDetectionConfig: PlaneDetectionConfig.horizontal,
//           ),
//           Align(
//             alignment: FractionalOffset.bottomCenter,
//             child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   ElevatedButton(
//                       onPressed: onRemoveEverything,
//                       child:const Text("Remove Everything")),
//                 ]),
//           )
//         ]));
//   }

//   void onARViewCreated(
//       ARSessionManager arSessionManager,
//       ARObjectManager arObjectManager,
//       ARAnchorManager arAnchorManager,
//       ARLocationManager arLocationManager) {
//     this.arSessionManager = arSessionManager;
//     this.arObjectManager = arObjectManager;
//     this.arAnchorManager = arAnchorManager;

//     this.arSessionManager.onInitialize(
//           showFeaturePoints: false,
//           showPlanes: true,
//           customPlaneTexturePath: "assets/images/triangle.png",
//           showWorldOrigin: false,
//           handlePans: true,
//           handleRotation: true,
//         );
//     this.arObjectManager.onInitialize();

//     this.arSessionManager.onPlaneOrPointTap = onPlaneOrPointTapped;
//     this.arObjectManager.onPanStart = onPanStarted;
//     this.arObjectManager.onPanChange = onPanChanged;
//     this.arObjectManager.onPanEnd = onPanEnded;
//     this.arObjectManager.onRotationStart = onRotationStarted;
//     this.arObjectManager.onRotationChange = onRotationChanged;
//     this.arObjectManager.onRotationEnd = onRotationEnded;
//   }

//   Future<void> onRemoveEverything() async {
//     /*nodes.forEach((node) {
//       this.arObjectManager.removeNode(node);
//     });*/
//     for(var anchor in anchors) {
//       arAnchorManager.removeAnchor(anchor);
//     }
//     anchors = [];
//   }
// var count = 0;
//   Future<void> onPlaneOrPointTapped(
//       List<ARHitTestResult> hitTestResults) async {
    
//     var singleHitTestResult = hitTestResults.firstWhere(
//         (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
//     if (singleHitTestResult != null &&count == 0) {
//       count+=1;
//       var newAnchor =
//           ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
//       bool didAddAnchor = await arAnchorManager.addAnchor(newAnchor);
//       if (didAddAnchor) {
//         anchors.add(newAnchor);
//         // Add note to anchor
//         var newNode = ARNode(
//             type: NodeType.webGLB,
//             uri:
//                 widget.product.threeDModelUrl,
//             scale: Vector3(0.5, 0.5, 0.5),
//             position: Vector3(0.0, 0.0, 0.0),
//             rotation: Vector4(1.0, 0.0, 0.0, 0.0));
//         bool didAddNodeToAnchor =
//             await arObjectManager.addNode(newNode, planeAnchor: newAnchor);
//         if (didAddNodeToAnchor) {
//           nodes.add(newNode);
//         } else {
//           arSessionManager.onError("Adding Node to Anchor failed");
//         }
//       } else {
//         arSessionManager.onError("Adding Anchor failed");
//       }
//     }
//   }

//   onPanStarted(String nodeName) {
//     debugPrint("Started panning node " + nodeName);
//   }

//   onPanChanged(String nodeName) {
//     debugPrint("Continued panning node " + nodeName);
//   }

//   onPanEnded(String nodeName, Matrix4 newTransform) {
//     debugPrint("Ended panning node " + nodeName);
//     final pannedNode =
//         nodes.firstWhere((element) => element.name == nodeName);
//   }

//   onRotationStarted(String nodeName) {
//     debugPrint("Started rotating node " + nodeName);
//   }

//   onRotationChanged(String nodeName) {
//     debugPrint("Continued rotating node " + nodeName);
//   }

//   onRotationEnded(String nodeName, Matrix4 newTransform) {
//     debugPrint("Ended rotating node " + nodeName);
//     final rotatedNode =
//         nodes.firstWhere((element) => element.name == nodeName);

//   }
// }

import 'dart:io';

import 'package:ar_flutter_plugin/managers/ar_location_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_session_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_object_manager.dart';
import 'package:ar_flutter_plugin/managers/ar_anchor_manager.dart';

import 'package:ar_flutter_plugin/models/ar_anchor.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ar_flutter_plugin/ar_flutter_plugin.dart';
import 'package:ar_flutter_plugin/datatypes/config_planedetection.dart';
import 'package:ar_flutter_plugin/datatypes/node_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';

import 'package:vector_math/vector_math_64.dart';
import 'dart:math';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_archive/flutter_archive.dart';

class LocalAndWebObjectsWidget extends StatefulWidget {
  const LocalAndWebObjectsWidget({Key key}) : super(key: key);
  @override
  _LocalAndWebObjectsWidgetState createState() =>
      _LocalAndWebObjectsWidgetState();
}

class _LocalAndWebObjectsWidgetState extends State<LocalAndWebObjectsWidget> {
  ARSessionManager arSessionManager;
  ARObjectManager arObjectManager;
  ARAnchorManager arAnchorManager;
  //String localObjectReference;
  ARNode localObjectNode;
  //String webObjectReference;
  ARNode webObjectNode;
  ARNode fileSystemNode;
  HttpClient httpClient;
  List<ARAnchor> anchors = [];
  @override
  void dispose() {
    super.dispose();
    arSessionManager.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Object Transformation Gestures'),
        ),
        body:  Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontal,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: onRemoveEverything,
                      child:const Text("Remove Everything")),
                ]),
          )
        ]));

        
          
  }
  
  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: false,
          customPlaneTexturePath: "images/triangle.png",
          showWorldOrigin: true,
          handleTaps: false,
          handlePans : true,
          handleRotation : true
        );
    this.arObjectManager.onInitialize();

    //Download model to file system
    httpClient =  HttpClient();
    _downloadFile(
        "https://github.com/KhronosGroup/glTF-Sample-Models/raw/master/2.0/Duck/glTF-Binary/Duck.glb",
        "LocalDuck.glb");
    // Alternative to use type fileSystemAppFolderGLTF2:
    //_downloadAndUnpack(
    //    "https://drive.google.com/uc?export=download&id=1fng7yiK0DIR0uem7XkV2nlPSGH9PysUs",
    //    "Chicken_01.zip");
  }
  Future<void> onRemoveEverything() async {
    
    for(var anchor in anchors) {
      arAnchorManager.removeAnchor(anchor);
    }
    anchors = [];
  }
  Future<File> _downloadFile(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file =  File('$dir/$filename');
    await file.writeAsBytes(bytes);
    debugPrint("Downloading finished, path: "'$dir/$filename');
    return file;
  }

  Future<void> _downloadAndUnpack(String url, String filename) async {
    var request = await httpClient.getUrl(Uri.parse(url));
    var response = await request.close();
    var bytes = await consolidateHttpClientResponseBytes(response);
    String dir = (await getApplicationDocumentsDirectory()).path;
    File file = File('$dir/$filename');
    await file.writeAsBytes(bytes);
    debugPrint("Downloading finished, path: "'$dir/$filename');

    // To print all files in the directory: print(Directory(dir).listSync());
    // try {
    //   await ZipFile.extractToDirectory(
    //       zipFile: File('$dir/$filename'), destinationDir: Directory(dir));
    //   print("Unzipping successful");
    // } catch (e) {
    //   print("Unzipping failed: " + e);
    // }
  }

  Future<void> onFileSystemObjectAtOriginButtonPressed() async {
    if (fileSystemNode != null) {
     arObjectManager.removeNode(fileSystemNode);
      fileSystemNode = null;
    } else {
      var newNode = ARNode(
          type: NodeType.fileSystemAppFolderGLB,
          uri: "LocalDuck.glb",
          scale: Vector3(0.2, 0.2, 0.2));
      
      bool didAddFileSystemNode = await arObjectManager.addNode(newNode);
      fileSystemNode = (didAddFileSystemNode) ? newNode : null;
    }
  }
  

  

  
}