import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:enxolist/domain/entities/product/product_entity.dart';
import 'package:enxolist/infra/constants/constants_images.dart';
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
                          imageUrl: widget.product?.image == ''
                              ? ConstantsImage.withoutPhoto
                              : widget.product!.image!,
                        )
                      : Text(
                          'Nenhuma imagem!',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.onSecondary),
                        ),
            ),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Adicione uma imagem:',
              style:
                  TextStyle(color: Theme.of(context).colorScheme.onSecondary),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: _pickerImage,
                  icon: Icon(Icons.camera,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
                IconButton(
                  onPressed: _pickerImageGallery,
                  icon: Icon(Icons.image,
                      color: Theme.of(context).colorScheme.onSecondary),
                ),
              ],
            ),
          ],
        )
      ],
    );
  }
}
