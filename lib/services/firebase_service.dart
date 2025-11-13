import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../models/recipe.dart';
import '../models/user_settings.dart';

class FirebaseService {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseStorage _storage = FirebaseStorage.instance;

  // Authentication
  static Future<UserCredential?> signInWithEmail(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<UserCredential?> registerWithEmail(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  static Future<void> signOut() async {
    await _auth.signOut();
  }

  static User? get currentUser => _auth.currentUser;

  static bool get isSignedIn => _auth.currentUser != null;

  // Recipe sync
  static Future<void> syncRecipe(Recipe recipe) async {
    if (!isSignedIn) return;

    final userId = currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('recipes')
        .doc(recipe.id)
        .set(recipe.toJson());
  }

  static Future<void> syncAllRecipes(List<Recipe> recipes) async {
    if (!isSignedIn) return;

    final userId = currentUser!.uid;
    final batch = _firestore.batch();

    for (final recipe in recipes) {
      final docRef = _firestore
          .collection('users')
          .doc(userId)
          .collection('recipes')
          .doc(recipe.id);
      batch.set(docRef, recipe.toJson());
    }

    await batch.commit();
  }

  static Future<List<Recipe>> fetchAllRecipes() async {
    if (!isSignedIn) return [];

    final userId = currentUser!.uid;
    final snapshot = await _firestore
        .collection('users')
        .doc(userId)
        .collection('recipes')
        .get();

    return snapshot.docs.map((doc) => Recipe.fromJson(doc.data())).toList();
  }

  static Future<void> deleteRecipe(String recipeId) async {
    if (!isSignedIn) return;

    final userId = currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('recipes')
        .doc(recipeId)
        .delete();
  }

  // Settings sync
  static Future<void> syncSettings(UserSettings settings) async {
    if (!isSignedIn) return;

    final userId = currentUser!.uid;
    await _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('user_settings')
        .set(settings.toJson());
  }

  static Future<UserSettings?> fetchSettings() async {
    if (!isSignedIn) return null;

    final userId = currentUser!.uid;
    final doc = await _firestore
        .collection('users')
        .doc(userId)
        .collection('settings')
        .doc('user_settings')
        .get();

    if (doc.exists) {
      return UserSettings.fromJson(doc.data()!);
    }
    return null;
  }

  // Photo storage
  static Future<String?> uploadPhoto(String recipeId, String localPath) async {
    if (!isSignedIn) return null;

    try {
      final userId = currentUser!.uid;
      final fileName = localPath.split('/').last;
      final ref = _storage
          .ref()
          .child('users')
          .child(userId)
          .child('recipes')
          .child(recipeId)
          .child(fileName);

      // Note: In actual implementation, read file from localPath
      // await ref.putFile(File(localPath));
      
      return await ref.getDownloadURL();
    } catch (e) {
      return null;
    }
  }

  static Future<void> deletePhoto(String photoUrl) async {
    if (!isSignedIn) return;

    try {
      final ref = _storage.refFromURL(photoUrl);
      await ref.delete();
    } catch (e) {
      // Handle error
    }
  }
}
