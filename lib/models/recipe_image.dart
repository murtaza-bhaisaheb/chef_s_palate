// import 'dart:io';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:meals/services/auth_services.dart';
// import 'package:meals/view_models/add_recipe_view_model.dart';
// import 'package:path/path.dart';
// import 'package:provider/provider.dart';
//
// class RecipeImage extends ChangeNotifier {
//   final picker = ImagePicker();
//   File? image;
//
//   Future<File> addImage() async {
//     final pickedFile = await picker.pickImage(source: ImageSource.gallery);
//     image = File(pickedFile!.path);
//     notifyListeners();
//     return image!;
//   }
//
//   Future<bool> uploadImage(BuildContext context, File? imageFile) async {
//     bool isUploaded = false;
//     final auth = AuthService();
//     final currentUserId = auth.getCurrentUID();
//     if (imageFile != null) {
//       String filename = basename(imageFile.path);
//       String uid = currentUserId;
//       Reference firebaseStorageRef =
//       FirebaseStorage.instance.ref().child('user/$uid/$filename');
//       UploadTask uploadTask = firebaseStorageRef.putFile(Provider.of<AddRecipeViewModel>(context, listen: false).image!);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       taskSnapshot.ref.getDownloadURL().then((value) {
//         isUploaded = true;
//         Provider.of<AddRecipeViewModel>(context, listen: false).getImageURL(value);
//         print('Done: $value');
//       });
//     } else {
//       isUploaded = false;
//     }
//     notifyListeners();
//     return isUploaded;
//   }
//
//   void removeImage() {
//     image = null;
//     notifyListeners();
//   }
//
//   bool hasImage() {
//     if (image != null) {
//       notifyListeners();
//       return true;
//     } else {
//       notifyListeners();
//       return false;
//     }
//   }
// }
