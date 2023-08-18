```
  //* Get an image, crop and store
  Future<void> _updateImage(ImageSource source) async {
    //* Pull the img
    File? img = await _pickImage(source);
    //? Exn: bad img, clear state
    if (img == null) return _setState();
    //* Crop the image
    File? croppedFile = await _cropImage(img);
    _setState(img: croppedFile);
  }

  //* Helper to update the state variables
  _setState({File? img}) {
    setState(() => _imageFinal = img);
  }

  //* Pull image from given source using ImagePicker
  Future<File?> _pickImage(ImageSource source) async {
    ImagePicker _picker = ImagePicker();
    XFile? img = await _picker.pickImage(source: source);
    if (img == null) return null; //? Exn
    return File(img.path);
  }

  //* Crops image
  Future<File?> _cropImage(File img) async {
    return await ImageCropper.cropImage(
        sourcePath: img.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.original,
        ],
        androidUiSettings: AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepPurple,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        ));
  }