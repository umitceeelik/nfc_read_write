// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nfc_read_write/NFC/NFCHomeScreen.dart';
import 'package:validators/validators.dart';
import 'package:http/http.dart' as http;
import 'package:nfc_manager/nfc_manager.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  String? _nameErrorText;
  String? _surnameErrorText;
  String? _professionErrorText;
  String? _phoneErrorText;
  String? _emailErrorText;

  XFile? _imageFile;
  final ImagePicker _picker = ImagePicker();

  final formKey = GlobalKey<FormState>();

  double labelFontSize = 15;
  bool saveButtonEnabled = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController surnameController = TextEditingController();
  TextEditingController professionController = TextEditingController();
  TextEditingController phone1Controller = TextEditingController();
  TextEditingController phone2Controller = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController websiteController = TextEditingController();
  TextEditingController linkedInController = TextEditingController();
  TextEditingController instagramController = TextEditingController();
  TextEditingController xController = TextEditingController();
  TextEditingController facebookController = TextEditingController();
  TextEditingController youtubeController = TextEditingController();

  ValueNotifier<dynamic> result = ValueNotifier(null);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
        color: Colors.white,
        // decoration: const BoxDecoration(
        //   gradient: LinearGradient(
        //     colors: [
        //       Color.fromARGB(255, 33, 37, 41),
        //       Color.fromARGB(255, 33, 37, 41),
        //       // Color.fromARGB(255, 250, 81, 20),
        //       // Color.fromARGB(255, 253, 132, 116),
        //       // Color.fromARGB(255, 240, 177, 185),
        //       // Color.fromARGB(255, 212, 206, 212),
        //       // Color.fromARGB(255, 202, 204, 171),
        //       Colors.white,
        //       Colors.white
        //     ],
        //     stops: [0.0, 0.18, 0.1801, 1.0],
        //     begin: Alignment.topCenter,
        //     end: Alignment.bottomCenter,
        //   ),
        //   shape: BoxShape.rectangle,
        // ),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height / 4.2,
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color.fromARGB(255, 33, 37, 41),
                        Color.fromARGB(255, 33, 37, 41),
                        // Color.fromARGB(255, 250, 81, 20),
                        // Color.fromARGB(255, 253, 132, 116),
                        // Color.fromARGB(255, 240, 177, 185),
                        // Color.fromARGB(255, 212, 206, 212),
                        // Color.fromARGB(255, 202, 204, 171),
                        Colors.white,
                        Colors.white,
                      ],
                      stops: [0.0, 0.6, 0.6001, 1.0],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    shape: BoxShape.rectangle,
                  ),
                ),
                Positioned.fill(
                  top: MediaQuery.of(context).size.width / 10,
                  child:
                      Align(alignment: Alignment.center, child: imageProfile()),
                )
              ],
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Form(
                  key: formKey,
                  child: ListView(
                    children: <Widget>[
                      profileBox(),
                      nameTextfield(),
                      surnameTextfield(),
                      professionTextfield(),
                      phone1Textfield(),
                      phone2Textfield(),
                      emailTextfield(),
                      SizedBox(
                        height: 2,
                      ),
                      Text("*İşaretli alanların doldurulması zorunludur."),
                      SizedBox(
                        height: 40,
                      ),
                      linkBox(),
                      websiteTextfield(),
                      linkedInTextfield(),
                      InstagramTextfield(),
                      XTextfield(),
                      FacebookTextfield(),
                      YoutubeTextfield(),
                      SaveBoxButton(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget profileBox() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0.0, 0.0, MediaQuery.of(context).size.width / 1.5, 0.0),
      child: Container(
        height: 30,
        color: Colors.black,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
          child: Text(
            "PROFİL",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget linkBox() {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(
          0.0, 0.0, MediaQuery.of(context).size.width / 1.5, 0.0),
      child: Container(
        height: 30,
        color: Colors.black,
        alignment: Alignment.centerLeft,
        child: Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 0.0, 0.0),
          child: Text(
            "LİNKLER",
            textAlign: TextAlign.center,
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 16, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget SaveBoxButton() {
    final VoidCallback? onPressed = saveButtonEnabled ? () {} : null;
    return Padding(
        padding: const EdgeInsets.all(20),
        child: FilledButton(
            onPressed: () => _saveFormData(),
            style: FilledButton.styleFrom(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)))),
            child: const Text(
              'DEĞİŞİKLİKLERİ KAYDET',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  color: Colors.white),
            )));
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 81,
            backgroundColor: Color.fromARGB(255, 33, 37, 41),
            child: CircleAvatar(
              radius: 80.0,
              backgroundImage: _imageFile == null
                  ? AssetImage("assets/pp.png")
                  : FileImage(File(_imageFile!.path)) as ImageProvider,
            ),
          ),
          Positioned(
            bottom: 22.0,
            right: 22.0,
            child: InkWell(
              onTap: () {
                showModalBottomSheet(
                    context: context, builder: ((builder) => bottomSheet()));
              },
              child: Icon(
                Icons.camera_alt,
                color: Colors.teal,
                size: 28,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget bottomSheet() {
    return Container(
      height: 100,
      width: MediaQuery.of(context).size.width,
      margin: EdgeInsets.symmetric(
        horizontal: 20,
        vertical: 20,
      ),
      child: Column(children: [
        Text(
          "Choose Profile photo",
          style: TextStyle(
            fontSize: 20.0,
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton.icon(
              onPressed: () {
                takePhoto(ImageSource.camera);
              },
              icon: Icon(Icons.camera, color: Colors.black87),
              label: Text("Camera", style: TextStyle(color: Colors.black87)),
            ),
            TextButton.icon(
              onPressed: () {
                takePhoto(ImageSource.gallery);
              },
              icon: Icon(Icons.image, color: Colors.black87),
              label: Text("Gallery", style: TextStyle(color: Colors.black87)),
            ),
          ],
        )
      ]),
    );
  }

  void takePhoto(ImageSource source) async {
    final xFile = await _picker.pickImage(
      source: source,
    );
    setState(() {
      if (_imageFile != null && xFile == null) return;

      _imageFile = xFile;
    });
  }

  Widget nameTextfield() {
    return TextFormField(
      controller: nameController,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "İsim*",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        // helperText: "İsim boş b",
        // errorText: _nameErrorText,

        // hintText: "Your Name",
      ),
      onTap: () => {
        setState(() {
          // _nameErrorText = null;
          labelFontSize = 18;
        })
      },
      validator: (value) {
        if (value!.length < 3) return "İsim alanı en az 3 karakter oluşmalıdır";
        return null;
      },
      // onSaved: (data) => isim = data,
    );
  }

  Widget surnameTextfield() {
    return TextFormField(
      controller: surnameController,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "Soyisim*",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        //errorText: _surnameErrorText,
        hintText: "Soyadınız",
      ),
      onTap: () => {
        setState(() {
          labelFontSize = 18;
          // _surnameErrorText = null;
        })
      },
      validator: (value) {
        if (value!.length < 3)
          return "Soyisim alanı en az 3 karakter oluşmalıdır";
        return null;
      },
    );
  }

  Widget professionTextfield() {
    return TextFormField(
      controller: professionController,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "Görev*",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        //errorText: _professionErrorText,
        hintText: "Full Stack Developer",
      ),
      onTap: () => {
        setState(() {
          labelFontSize = 18;
          //_professionErrorText = null;
        })
      },
      validator: (value) {
        if (value!.length < 3)
          return "Görev alanı en az 3 karakter oluşmalıdır";
        return null;
      },
    );
  }

  Widget phone1Textfield() {
    return TextFormField(
      controller: phone1Controller,
      autovalidateMode: AutovalidateMode.always,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),

        labelText: "Cep Telefonu 1*",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        // errorText: _phoneErrorText,
        hintText: "0537 777 77 77",
      ),
      onTap: () => {
        setState(() {
          // _phoneErrorText = null;
          labelFontSize = 18;
        })
      },
      validator: (value) {
        String pattern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
        RegExp regExp = new RegExp(pattern);
        if (value!.length == 0) {
          return 'Cep Telefonu kısmı boş bırakılamaz';
        } else if (!regExp.hasMatch(value)) {
          return 'Geçersiz Cep Telefonu Numarası';
        }
        return null;
      },
    );
  }

  Widget phone2Textfield() {
    return TextFormField(
      controller: phone2Controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "Cep Telefonu 2",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        errorText: null,
        hintText: "0537 777 77 77",
      ),
    );
  }

  Widget emailTextfield() {
    return TextFormField(
      controller: emailController,
      autovalidateMode: AutovalidateMode.always,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        labelText: "E-mail*",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        // errorText: _emailErrorText,
        hintText: "aa123@gmail.com",
      ),
      onTap: () => {
        setState(() {
          // _emailErrorText = null;
          labelFontSize = 18;
        })
      },
      validator: (value) {
        bool emailValid = false;
        if (value != null)
          emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(value);
        if (!emailValid) return "Geçersiz Email Address";
        return null;
      },
    );
  }

  Widget websiteTextfield() {
    return TextFormField(
      controller: websiteController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "Website",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        errorText: null,
        hintText: "https://www.google.com/",
      ),
    );
  }

  Widget linkedInTextfield() {
    return TextFormField(
      controller: linkedInController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "LinkedIn",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        errorText: null,
        hintText: "LinkedIn Kullanıcı Adınız",
      ),
    );
  }

  Widget InstagramTextfield() {
    return TextFormField(
      controller: instagramController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "Instagram",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        errorText: null,
        hintText: "Instagram Kullanıcı Adınız",
      ),
    );
  }

  Widget XTextfield() {
    return TextFormField(
      controller: xController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "X",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        errorText: null,
        hintText: "X Kullanıcı Adınız",
      ),
    );
  }

  Widget FacebookTextfield() {
    return TextFormField(
      controller: facebookController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "Facebook",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        errorText: null,
        hintText: "Facebook Kullanıcı Adınız",
      ),
    );
  }

  Widget YoutubeTextfield() {
    return TextFormField(
      controller: youtubeController,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(146, 33, 37, 41),
            width: 2,
          ),
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.orange,
          width: 2,
        )),
        errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )),
        // prefixIcon: Icon(
        //   Icons.person,
        //   color: Colors.green,
        // ),
        labelText: "Youtube",
        labelStyle: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: labelFontSize,
            color: Colors.black),
        errorText: null,
        hintText: "Youtube Kanalınız",
      ),
    );
  }

  String? validateEmail(String? value) {
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);

    return value!.isNotEmpty && !regex.hasMatch(value)
        ? 'Enter a valid email address'
        : null;
  }

  Map<String, dynamic> getFormDataAsJson() {
    return {
      'name': nameController.text,
      'surname': surnameController.text,
      'title': professionController.text,
      'email': emailController.text,
      'tel1': phone1Controller.text,
      'tel2': phone2Controller.text,
      'website': websiteController.text,
      'facebook': facebookController.text,
      'x': xController.text,
      'instagram': instagramController.text,
      'linkedIn': linkedInController.text,
      'youtube': youtubeController.text,
      "imgExt": "jpeg",
    };
  }

  void _saveFormData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
    }

    Map<String, dynamic> formData = getFormDataAsJson();
    String jsonFormData = json.encode(formData);
    // Now you have the JSON representation of the form data
    print(jsonFormData);

    try {
      await submitSubscription(File(_imageFile!.path), jsonFormData);
    } catch (error) {
      print('Error submitting form data: $error');
    }

    _ndefWrite("https://id.atlas.space/spdo/index.html?id=20");
  }

  Future<void> submitSubscription(
      File file, String jsonString /*, String path*/) async {
    String endpoint =
        'https://o3n3xclrqvl5xye44kcvjsv6kq0bxhtg.lambda-url.eu-west-1.on.aws/api/uploadfileaws';
    var request = http.MultipartRequest('POST', Uri.parse(endpoint));
    request.headers['Content-Type'] = 'multipart/form-data';

    // Convert JSON string to bytes
    List<int> jsonData = utf8.encode(jsonString);

    // Add json file to the request directly from bytes
    var multipartJsonFile =
        http.MultipartFile.fromBytes('files', jsonData, filename: '20.json');
    request.files.add(multipartJsonFile);

    // Add file to the request
    var fileStream = http.ByteStream(file.openRead());
    var length = await file.length();
    var multipartImgFile = http.MultipartFile('files', fileStream, length,
        filename: file.path.split('/').last);
    request.files.add(multipartImgFile);

    // Add other fields to the request
    request.fields['bucketname'] = 'atlas-prod-id-origin';
    request.fields['path'] = 'spdo/user/id20/id20';

    try {
      var response = await request.send();
      if (response.statusCode == 400) {
        var responseBody = await response.stream.bytesToString();
        print('Bad Request. Response Body: $responseBody');
      }
      if (response.statusCode == 200) {
        print('File uploaded successfully');
      } else {
        print('Failed to upload file. Status code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error uploading file: $error');
    }
  }

  void _ndefWrite(String url) {  // https://id.atlas.space/spdo/index.html?id=20
    NfcManager.instance.startSession(onDiscovered: (NfcTag tag) async {
      var ndef = Ndef.from(tag);
      if (ndef == null || !ndef.isWritable) {
        result.value = 'Tag is not ndef writable';
        NfcManager.instance.stopSession(errorMessage: result.value);
        return;
      }

      NdefMessage message = NdefMessage([
        NdefRecord.createUri(Uri.parse(url)),
        // NdefRecord.createText('Hello World!'),
        // NdefRecord.createMime(
        //     'text/plain', Uint8List.fromList('Hello'.codeUnits)),
        // NdefRecord.createExternal(
        //     'com.example', 'mytype', Uint8List.fromList('mydata'.codeUnits)),
      ]);

      try {
        await ndef.write(message);
        result.value = 'Success to "Ndef Write"';
        NfcManager.instance.stopSession();
      } catch (e) {
        result.value = e;
        NfcManager.instance.stopSession(errorMessage: result.value.toString());
        return;
      }
    });
  }
}
