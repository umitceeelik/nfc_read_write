import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:validators/validators.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        constraints: BoxConstraints.expand(),
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
              Colors.white
            ],
            stops: [0.0, 0.18, 0.1801, 1.0],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
          shape: BoxShape.rectangle,
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: ListView(
            children: <Widget>[
              imageProfile(),
              SizedBox(
                height: 20,
              ),
              nameTextfield(),
              SizedBox(
                height: 5,
              ),
              surnameTextfield(),
              SizedBox(
                height: 5,
              ),
              professionTextfield(),
              SizedBox(
                height: 5,
              ),
              phone1Textfield(),
              SizedBox(
                height: 5,
              ),
              phone2Textfield(),
              SizedBox(
                height: 5,
              ),
              emailTextfield(),
              SizedBox(
                height: 5,
              ),
              websiteTextfield(),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageProfile() {
    return Center(
      child: Stack(
        children: [
          CircleAvatar(
            radius: 80.0,
            backgroundImage: _imageFile == null
                ? AssetImage("assets/pp.png")
                : FileImage(File(_imageFile!.path)) as ImageProvider,
          ),
          Positioned(
            bottom: 20.0,
            right: 20.0,
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
      _imageFile = xFile;
    });
  }

  Widget nameTextfield() {
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
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
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        // helperText: "İsim boş b",
        errorText: _nameErrorText,
        // hintText: "Your Name",
      ),
      onTap: () => {
        setState(() {
          _nameErrorText = null;
        })
      },
    );
  }

  Widget surnameTextfield() {
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
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
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        errorText: _surnameErrorText,
        hintText: "Soyadınız",
      ),
      onTap: () => {
        setState(() {
          _surnameErrorText = null;
        })
      },
    );
  }

  Widget professionTextfield() {
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
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
        labelText: "Görev",
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        errorText: _professionErrorText,
        hintText: "Full Stack Developer",
      ),
      onTap: () => {
        setState(() {
          _professionErrorText = null;
        })
      },
    );
  }

  Widget phone1Textfield() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
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
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        errorText: _phoneErrorText,
        hintText: "0537 777 77 77",
      ),
      onTap: () => {
        setState(() {
          _phoneErrorText = null;
        })
      },
    );
  }

  Widget phone2Textfield() {
    return TextFormField(
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
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
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        errorText: null,
        hintText: "0537 777 77 77",
      ),
    );
  }

  Widget emailTextfield() {
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
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
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        errorText: _emailErrorText,
        hintText: "aa123@gmail.com",
      ),
      onTap: () => {
        setState(() {
          _emailErrorText = null;
        })
      },
    );
  }

  Widget websiteTextfield() {
    return TextFormField(
      decoration: InputDecoration(
        border: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.teal,
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
        labelStyle: TextStyle(fontWeight: FontWeight.w700, color: Colors.black),
        errorText: null,
        hintText: "https://www.google.com/",
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
}
