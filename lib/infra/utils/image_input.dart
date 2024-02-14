import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerForm extends StatefulWidget {
  final void Function(File image) onImagePick;
  final ProductEntity? product;

  const ImagePickerForm({
    Key? key,
    required this.onImagePick,
    this.product,
  }) : super(key: key);

  @override
  State<ImagePickerForm> createState() => _ImagePickerFormState();
}

class _ImagePickerFormState extends State<ImagePickerForm> {
  File? _image;

  Future<void> _pickerImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 150,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  Future<void> _pickerImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });

      widget.onImagePick(_image!);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 150,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
              ),
              alignment: Alignment.center,
              child: _image != null
                  ? Image.file(
                      _image!,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    )
                  : (widget.product != null && widget.product!.image != null)
                      ? CachedNetworkImage(
                          imageUrl: widget.product!.image!,
                        )
                      : const Text('Nenhuma imagem!'),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Adicione uma imagem:'),
            Row(
              children: [
                IconButton(
                  onPressed: _pickerImage,
                  icon: const Icon(Icons.camera),
                ),
                IconButton(
                  onPressed: _pickerImageGallery,
                  icon: const Icon(Icons.image),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
