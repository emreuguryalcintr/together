
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';

class AuthService{
  final GoogleSignIn _googleSignIn=GoogleSignIn();
  final FirebaseAuth _auth=FirebaseAuth.instance;
  final Firestore _db=Firestore.instance;

  Observable<FirebaseUser> user;
  Observable<Map<String,dynamic>> profile;
  PublishSubject loading=PublishSubject();

  AuthService(){
    user=Observable(_auth.onAuthStateChanged);

    profile=user.switchMap((FirebaseUser u){
      if(u!=null){
        return _db.collection("users").document(u.uid).snapshots().map((snap)=>snap.data);
      }else{
        return Observable.just({});
      }
    });
  }

  Future<FirebaseUser> signUpEmailAndPassword(String email,String password)async{
    loading.add(true);
    final FirebaseUser user=(await _auth.createUserWithEmailAndPassword(email: email, password: password)).user;

    return user;
  }

  Future<FirebaseUser> signInWithEmailAndPassword(String email,String password)async{
    loading.add(true);
    FirebaseUser user=(await _auth.signInWithEmailAndPassword(email: email, password: password)).user;
    return user;
  }

  Future<FirebaseUser> googleSignIn() async{
    loading.add(true);
    GoogleSignInAccount googleUser=await _googleSignIn.signIn();
    GoogleSignInAuthentication googleAuth=await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );


    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;

    updateUserData(user);
    loading.add(false);
    print("signed in " + user.uid);
    return user;

  }

  void updateUserData(FirebaseUser user) async{
    DocumentReference reference=_db.collection("users").document(user.uid);
    return reference.setData({
      'uid':user.uid,
      'email':user.email,
      'photoUrl':user.photoUrl,
      'displayName':user.displayName,
      'lastSeen':DateTime.now(),
    },merge: true).catchError((e){
      print("the error is: $e");
    });
  }

  void signOut(){
    _auth.signOut();
    _googleSignIn.signOut();
  }


}

final AuthService authService=AuthService();