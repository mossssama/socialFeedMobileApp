import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/web.dart';
import 'package:social_feed/core/animations.dart';
import 'package:social_feed/core/constants.dart';

import '../../../../core/get_it.dart';
import '../../../../core/routing.dart';
import '../../../../core/shared_prefs.dart';
import '../../../auth/presentation/controllers/logout_cubit.dart';

import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'dart:convert';

import 'package:hive/hive.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController? nameController;
  TextEditingController? roleController;
  late Box profileBox;

  @override
  void initState() {
    super.initState();

    Hive.openBox(hiveProfileCacheBox).then((box) {
      setState(() {
        profileBox = box;
        nameController = TextEditingController(
          text: profileBox.get('name', defaultValue: ''),
        );
        roleController = TextEditingController(
          text: profileBox.get('role', defaultValue: ''),
        );
      });
    });
  }

  @override
  void dispose() {
    nameController?.dispose();
    roleController?.dispose();
    super.dispose();
  }

  void _saveProfile() {
    profileBox.put('name', nameController?.text);
    profileBox.put('role', roleController?.text);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Profile saved!')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SizedBox(height: 20),
                const CircleAvatarWithPicker(),
                const SizedBox(height: 20),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: nameController,
                    style: const TextStyle(fontSize: 24, color: Colors.black),
                    decoration: const InputDecoration(hintText: 'Enter your name', border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextField(
                    textAlign: TextAlign.center,
                    controller: roleController,
                    style: const TextStyle(fontSize: 24, color: Colors.black),
                    decoration: const InputDecoration(hintText: 'Enter your role', border: InputBorder.none, hintStyle: TextStyle(color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 80),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                  ),
                  onPressed: _saveProfile,
                  child: const Text('Save Profile', style: TextStyle(color: Colors.white)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () {
                    getIt<LogoutCubit>().logoutUser();
                    Navigator.of(context).pushReplacement(
                      AppRouter.loginScreen.slideFromBottom(),
                    );
                  },
                  child: const Text(
                    'Logout',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CircleAvatarWithPicker extends StatefulWidget {
  const CircleAvatarWithPicker({super.key});

  @override
  CircleAvatarWithPickerState createState() => CircleAvatarWithPickerState();
}

class CircleAvatarWithPickerState extends State<CircleAvatarWithPicker> {
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    _loadImageFromPrefs();
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
      await _saveImageToPrefs(File(pickedFile.path));
    }
  }

  Future<void> _saveImageToPrefs(File imageFile) async {
    final bytes = await imageFile.readAsBytes();
    final base64Image = base64Encode(bytes);
    await SharedPrefs.saveString('cached_image', base64Image);
  }

  void _loadImageFromPrefs() async {
    final base64Image = SharedPrefs.getString('cached_image');
    if (base64Image != null && base64Image.isNotEmpty) {
      try {
        final bytes = base64Decode(base64Image);
        final tempDir = Directory.systemTemp;
        final tempFile = File('${tempDir.path}/cached_image.jpg');
        await tempFile.writeAsBytes(bytes);
        setState(() {
          _imageFile = tempFile;
        });
      } catch (e) {
        getIt<Logger>().i("Error in image caching");
      }
    }
  }

  Future<void> _deleteImage() async {
    setState(() {
      _imageFile = null;
    });
    await SharedPrefs.remove('cached_image');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 60,
              backgroundImage: _imageFile != null ? FileImage(_imageFile!) as ImageProvider : const NetworkImage('https://via.placeholder.com/150'),
              child: _imageFile == null
                  ? const Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.white,
                    )
                  : null,
            ),
          ),
          TextButton(
            onPressed: _imageFile != null ? _deleteImage : _pickImage,
            child: Text(_imageFile != null ? "Delete Image" : "Select Image"),
          ),
        ],
      ),
    );
  }
}
