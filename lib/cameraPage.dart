import 'dart:io';

import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class cameraPage extends StatefulWidget {
  const cameraPage({ Key key }) : super(key: key);

  @override
  State<cameraPage> createState() => _cameraPageState();
}

class _cameraPageState extends State<cameraPage> {
  List <CameraDescription> camera = [];
  CameraController controller;
  XFile imagem;
  Size size;

  @override
  void initState(){
    super.initState();
    _loadCameras();
  }

  _loadCameras() async {
    try{
      camera = await availableCameras();
      startCameras();
    } on CameraException catch (e) {
      print(e.description);
    }
  }

  startCameras(){
    if(camera.isEmpty){
      print("Camera não encontrada");
    }else{
      _previlCamera(camera.first);
    }
  }

  _previlCamera(CameraDescription Camera) async{
    final CameraController cameraController = CameraController(
      Camera,
      ResolutionPreset.high,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg
    );
    controller = cameraController;

    try {
      await cameraController.initialize();
    } on CameraException catch (e){
      print(e.description);
    } 

    if (mounted) {
      setState(() {
        
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("Documento Oficial"),
        backgroundColor: Colors.grey,
        centerTitle: true,
        elevation: 0,
      ),
      body: Container(
        color: Colors.grey,
        child: Center(
          child: _arquivoWidget(),
        ), 
      ),
      floatingActionButton: (imagem != null) ? FloatingActionButton.extended(
        onPressed: () => Navigator.pop(context),
        label: Text("finalizar"),
      ):null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  _arquivoWidget(){
    return Container(
      width: size.width - 50,
      height: size.height - (size.height / 3),
      child: imagem == null 
      ? _cameraPrevilWidget() 
      : Image.file(
        File(imagem.path),
        fit: BoxFit.contain,
      ),
    );
  }

  _cameraPrevilWidget(){
    final CameraController cameraController = controller;
    if(cameraController == null || cameraController.value.isInitialized){
      return Text("Falha");
    }else{
      return Stack(
        alignment: Alignment.bottomCenter,
        children: [
          CameraPreview(controller),
          _botonCapturaWidget()
        ],
      );
    }
  }

  _botonCapturaWidget(){
    return Padding(
      padding: EdgeInsets.only(bottom: 24),
      child: CircleAvatar(
        radius: 32,
        backgroundColor: Colors.black.withOpacity(0.5),
        child: IconButton(
          icon: Icon(Icons.camera_alt, color: Colors.white, size: 30,),
          onPressed: titarFoto,
        ),
      ),
    );
  }

  titarFoto() async {
    final CameraController cameraController = controller;

    if (cameraController != null && cameraController.value.isInitialized ) {
      try{
        XFile file = await cameraController.takePicture();
        if(mounted) setState(() => imagem = file);
      } on  CameraException catch (e) {
        print(e.description);
      }
      
    }
  }
}