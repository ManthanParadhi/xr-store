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
import 'package:ar_flutter_plugin/datatypes/hittest_result_types.dart';
import 'package:ar_flutter_plugin/models/ar_node.dart';
import 'package:ar_flutter_plugin/models/ar_hittest_result.dart';
import 'package:flutter/services.dart';
import 'package:flutter_xlider/flutter_xlider.dart';
import 'package:path_provider/path_provider.dart';
import 'package:vector_math/vector_math_64.dart';
import 'dart:math';

import '../models/models.dart';

class ObjectGesturesWidget extends StatefulWidget {
  final Product product;
  const ObjectGesturesWidget({Key key, this.product}) : super(key: key);
  @override
  _ObjectGesturesWidgetState createState() => _ObjectGesturesWidgetState();
}

class _ObjectGesturesWidgetState extends State<ObjectGesturesWidget> {
  bool isLoading = false;
  ARSessionManager arSessionManager;
  ARObjectManager arObjectManager;
  ARAnchorManager arAnchorManager;
  HttpClient httpClient;

  List<ARNode> nodes = [];
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
          title: Text(widget.product.name),
        ),
        body: Container(
            child: Stack(children: [
          ARView(
            onARViewCreated: onARViewCreated,
            planeDetectionConfig: PlaneDetectionConfig.horizontalAndVertical,
          ),
          Align(
            alignment: FractionalOffset.bottomCenter,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                isLoading
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Column(children: [
                        ElevatedButton(
                            onPressed: onRemoveEverything,
                            child: Text("Remove Everything")),
                      ]),
              ],
            ),
          )
        ])));
  }

  void onARViewCreated(
      ARSessionManager arSessionManager,
      ARObjectManager arObjectManager,
      ARAnchorManager arAnchorManager,
      ARLocationManager arLocationManager) {
    this.arSessionManager = arSessionManager;
    this.arObjectManager = arObjectManager;
    this.arAnchorManager = arAnchorManager;

    this.arSessionManager.onInitialize(
          showFeaturePoints: false,
          showPlanes: true,
          customPlaneTexturePath: "assets/images/triangle.png",
          showWorldOrigin: false,
          handlePans: true,
          handleRotation: true,
        );
    this.arObjectManager.onInitialize();

    httpClient = HttpClient();
    _downloadFile(widget.product.threeDModelUrl, widget.product.name + ".glb");

    this.arSessionManager.onPlaneOrPointTap = onPlaneOrPointTapped;
    
  }

  Future<File> _downloadFile(String url, String filename) async {
    String productName = widget.product.name + ".glb";
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = dir + "/" + productName;
    if (File(path).existsSync()) {
      print("Model exists");
      return File(path);
    } else {
      print("Model does not exist");
      var request = await httpClient.getUrl(Uri.parse(url));
      var response = await request.close();
      var bytes = await consolidateHttpClientResponseBytes(response);
      File file = new File('$dir/$filename');
      await file.writeAsBytes(bytes);
      print("Downloading finished, path: " + '$dir/$filename');
      return file;
    }
  }

  Future<void> onRemoveEverything() async {
    /*nodes.forEach((node) {
      this.arObjectManager.removeNode(node);
    });*/
    anchors.forEach((anchor) {
      arAnchorManager.removeAnchor(anchor);
    });
    count = 0;
    anchors = [];
  }

  // Future<String> waitforDownload() async {

  //   return path;
  // }

  var count = 0;
  Future<void> onPlaneOrPointTapped(
      List<ARHitTestResult> hitTestResults) async {
    String productName = widget.product.name + ".glb";
    String dir = (await getApplicationDocumentsDirectory()).path;
    String path = dir + "/" + productName;
    var singleHitTestResult = hitTestResults.firstWhere(
        (hitTestResult) => hitTestResult.type == ARHitTestResultType.plane);
    if (singleHitTestResult != null && count == 0) {
      count += 1;
      var newAnchor =
          ARPlaneAnchor(transformation: singleHitTestResult.worldTransform);
      bool didAddAnchor = await arAnchorManager.addAnchor(newAnchor);
      if (didAddAnchor) {
        anchors.add(newAnchor);
        // Add note to anchor
        // var newNode = ARNode(
        //     type: NodeType.webGLB,
        //     uri:
        //         widget.product.threeDModelUrl,
        //     scale: Vector3(1, 1, 1),
        //     position: Vector3(0.0, 0.0, 0.0),
        //     rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        var newNode = ARNode(
            type: NodeType.fileSystemAppFolderGLB,
            uri: path,
            scale: Vector3(1, 1, 1),
            position: Vector3(0.0, 0.0, 0.0),
            rotation: Vector4(1.0, 0.0, 0.0, 0.0));
        setState(() {
          isLoading = true;
        });
        bool didAddNodeToAnchor =
            await arObjectManager.addNode(newNode, planeAnchor: newAnchor);
        setState(() {
          isLoading = false;
        });
        if (didAddNodeToAnchor) {
          nodes.add(newNode);
        } else {
          arSessionManager.onError("Adding Node to Anchor failed");
        }
      } else {
        arSessionManager.onError("Adding Anchor failed");
      }
    }
  }

  
}
