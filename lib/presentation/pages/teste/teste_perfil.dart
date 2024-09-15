import 'dart:typed_data';

import 'package:crop_your_image/crop_your_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class CropSample extends StatefulWidget {
  @override
  _CropSampleState createState() => _CropSampleState();
}

class _CropSampleState extends State<CropSample> {
  static const _images = const [
    'assets/imgs/avatares/1.jpg',
    'assets/imgs/avatares/2.jpg',
    'assets/imgs/avatares/3.jpg',
  ];

  final _cropController = CropController();
  final _imageDataList = <Uint8List>[];

  var _loadingImage = false;
  var _currentImage = 0;
  set currentImage(int value) {
    setState(() {
      _currentImage = value;
    });
    _cropController.image = _imageDataList[_currentImage];
  }

  var _isSumbnail = false;
  var _isCropping = false;
  var _isCircleUi = false;
  Uint8List? _croppedData;
  var _statusText = '';

  @override
  void initState() {
    _loadAllImages();
    super.initState();
  }

  Future<void> _loadAllImages() async {
    setState(() {
      _loadingImage = true;
    });
    for (final assetName in _images) {
      _imageDataList.add(await _load(assetName));
    }
    setState(() {
      _loadingImage = false;
    });
  }

  Future<Uint8List> _load(String assetName) async {
    final assetData = await rootBundle.load(assetName);
    return assetData.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crop Your Image'),
      ),
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Visibility(
            visible: !_loadingImage && !_isCropping,
            replacement: const CircularProgressIndicator(),
            child: Stack(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      child: Center(
                        child: _loadingImage
                            ? const CircularProgressIndicator()
                            : Crop(
                                willUpdateScale: (newScale) => newScale < 1,
                                controller: _cropController,
                                image: _imageDataList[_currentImage],
                                onCropped: (image) async {},
                                withCircleUi: false,
                                initialSize: 0.8,
                                aspectRatio: 1 / 1,
                                maskColor: Colors.white,
                                cornerDotBuilder: (size, edgeAlignment) =>
                                    const SizedBox.shrink(),
                                interactive: true,
                                fixCropRect: true,
                                initialRectBuilder: (viewportRect, imageRect) {
                                  return Rect.fromLTRB(
                                    viewportRect.left + 24,
                                    viewportRect.top + 24,
                                    viewportRect.right - 24,
                                    viewportRect.bottom - 24,
                                  );
                                },
                              ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.crop_portrait),
                                onPressed: () {
                                  _cropController.aspectRatio = 3 / 4;
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.crop_5_4),
                                onPressed: () {
                                  _cropController.aspectRatio = 1 / 1;
                                },
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                8, 5, 8, 5),
                            child: ElevatedButton(
                              onPressed: () async {
                                _cropController.cropCircle();
                              },
                              style: ButtonStyle(
                                padding: MaterialStateProperty.all<
                                    EdgeInsetsGeometry>(
                                  EdgeInsets.zero,
                                ),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                    side: BorderSide.none,
                                  ),
                                ),
                              ),
                              child: Container(
                                width: 250,
                                height: 40,
                                alignment: Alignment.center,
                                child: Text(
                                  'Cortar imagem',
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: IconButton(
                    icon: Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Expanded _buildSumbnail(Uint8List data) {
    final index = _imageDataList.indexOf(data);
    return Expanded(
      child: InkWell(
        onTap: () {
          _croppedData = null;
          currentImage = index;
        },
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: index == _currentImage
                ? Border.all(
                    width: 8,
                    color: Colors.blue,
                  )
                : null,
          ),
          child: Image.memory(
            data,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
