
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simop/model/users.dart';
import 'package:simop/services/auth.dart';

class Users {
  static final _db = FirebaseFirestore.instance;
  static final _storage = FirebaseStorage.instance;

  static Future createUser(
  String email, String name, String nohp) async {
    try {
      await _db.collection("users").add({
        "email": email,
        "name": name,
        "nohp": nohp,
        "imageUrl": ""
      });
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "Akun anda berhasil didaftarkan",
        middleTextStyle: TextStyle(
          fontFamily: "'Poppins",
        ),
        onConfirm: () {
          Get.back();
          Get.back();
        },
        radius: 16,
      );
    } on FirebaseException catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        middleTextStyle: TextStyle(
          fontFamily: "'Poppins",
        ),
        radius: 16,
      );
    } catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        radius: 16,
      );
    }
  }

  static Future deleteUser() async {
    try {
      final email = Auth.getCurrentEmail();
      final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
      final userData = snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
      final idUser = userData.id;
      await _db.collection("users").doc(idUser).delete();
      return true;
    } on FirebaseException catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        middleTextStyle: TextStyle(
          fontFamily: "'Poppins",
        ),
        radius: 16,
      );
      return false;
    } catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        radius: 16,
      );
      return false;
    }
  }

  static Future updateUser(String? name, String? nohp) async {
    try {
      final email = Auth.getCurrentEmail();
      final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
      final userData = snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
      final idUser = userData.id;
      if (name != "" && nohp != "") {
        await _db.collection("users").doc(idUser).update({
          "name": name,
          "nohp": nohp
        });
      } else if (name != "") {
        await _db.collection("users").doc(idUser).update({
          "name": name,
        });
      } else if (nohp != "") {
        await _db.collection("users").doc(idUser).update({
          "nohp": nohp,
        });
      }
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "Akun anda berhasil diperbaharui",
        middleTextStyle: TextStyle(
          fontFamily: "'Poppins",
        ),
        onConfirm: () {
          Get.back();
          Get.back();
          Get.back();
          Get.back();
        },
        radius: 16,
      );
      return true;
    } on FirebaseException catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        middleTextStyle: TextStyle(
          fontFamily: "'Poppins",
        ),
        radius: 16,
      );
      return false;
    } catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        radius: 16,
      );
      return false;
    }
  }

  static Future updateUserImage(XFile imagefile) async {
    try {
      final path = 'files/${imagefile.name}';
      final file = File(imagefile.path);

      final ref = _storage.ref().child(path);
      final snapshotStorage = await ref.putFile(file);
      final imageUrl = await snapshotStorage.ref.getDownloadURL();
      final email = Auth.getCurrentEmail();
      final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
      final userData = snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
      final idUser = userData.id;
      await _db.collection("users").doc(idUser).update({
        "imageUrl": imageUrl,
      });    
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "Foto profil anda berhasil diperbaharui",
        middleTextStyle: TextStyle(
          fontFamily: "'Poppins",
        ),
        onConfirm: () {
          Get.back();
        },
        radius: 16,
      );
      return true;
    } on FirebaseException catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        middleTextStyle: TextStyle(
          fontFamily: "'Poppins",
        ),
        radius: 16,
      );
      return false;
    } catch(e) {
      Get.defaultDialog(
        backgroundColor: Colors.white,
        middleText: "$e",
        radius: 16,
      );
      return false;
    }
  }

  static Future<String> getNameUser() async {
    final email = Auth.getCurrentEmail();
    final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
    final nameUser = userData.name;
    return nameUser;
  }

  static Future<String> getEmailUser() async {
    final email = Auth.getCurrentEmail();
    final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
    final emailUser = userData.email;
    return emailUser;
  }

  static Future<String> getNohpUser() async {
    final email = Auth.getCurrentEmail();
    final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
    final nohpUser = userData.nohp;
    return nohpUser;
  }

  static Future<String> getImageUrlUser() async {
    final email = Auth.getCurrentEmail();
    final snapshot = await _db.collection("users").where("email", isEqualTo: email).get();
    final userData = snapshot.docs.map((e) => UsersModel.fromSnapshot(e)).single;
    final imageUrlUser = userData.imageUrl;
    return imageUrlUser;
  }
}
