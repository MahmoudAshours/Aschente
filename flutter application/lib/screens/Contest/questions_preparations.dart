import 'dart:convert';
import 'dart:math';
import 'package:animate_do/animate_do.dart';
import 'package:aschente/helpers/auth_provider.dart';
import 'package:aschente/helpers/clock_ticker.dart';
import 'package:aschente/screens/Contest/contest_arena.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class OnlineQuestionsPreparations extends StatefulWidget {
  final subject;

  OnlineQuestionsPreparations({Key? key, @required this.subject})
      : super(key: key);

  @override
  _OnlineQuestionsPreparationsState createState() =>
      _OnlineQuestionsPreparationsState();
}

class _OnlineQuestionsPreparationsState
    extends State<OnlineQuestionsPreparations> {
  List _pickedQuestions = [];
  late Stream<QuerySnapshot> _readyStream;

  @override
  void didChangeDependencies() {
    final _authProvider = Provider.of<AuthProvider>(context);

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final _authProvider = Provider.of<AuthProvider>(context);
    return Scaffold(
      body: Stack(
        children: [
          buildBackground(),
          StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('contest')
                .where('topic_name', isEqualTo: widget.subject)
                .where('firstplayer_uid',
                    isNotEqualTo:
                        '${_authProvider.firebaseAuth.currentUser!.uid}')
                .snapshots(),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                    child: Container(child: SpinKitCircle(color: Colors.pink)));
              }
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                print('${snapshot.data!.docs}');
                return buildQuestions(context, _authProvider);
              }
              Future.delayed(
                Duration(seconds: 6),
                () async {
                  final _contestId = await _joinAsSecondPlayer(_authProvider);
                  print(_contestId);
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (_) => ContestArena(contestId: _contestId),
                    ),
                  );
                },
              );
              return BounceInUp(
                child: Center(
                  child: Container(
                    width: 400,
                    height: 400,
                    child: ClockTicker(3),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  FutureBuilder<String> buildQuestions(
      BuildContext context, AuthProvider provider) {
    late List _questions;
    return FutureBuilder(
      future: DefaultAssetBundle.of(context)
          .loadString('assets/${widget.subject}.json'),
      builder: (BuildContext context, snapshot) {
        if (snapshot.data != null ||
            snapshot.connectionState == ConnectionState.done) {
          _questions = json.decode(snapshot.data.toString());
          for (var i = 0; i < 10; i++) {
            final random = Random().nextInt(_questions.length);
            _pickedQuestions.add(_questions[random]);
          }
        }
        return FutureBuilder<DocumentSnapshot>(
            future: _createContest(provider, _questions),
            builder: (context, docSnapshot) {
              if (docSnapshot.data == null ||
                  docSnapshot.connectionState != ConnectionState.done) {
                return Center(
                  child: Container(
                    child: SpinKitCircle(color: Colors.pink),
                  ),
                );
              }
              if (docSnapshot.data!.get('secondplayer_uid') != null) {
                Future.delayed(
                  Duration(seconds: 6),
                  () async {
                    final _contestId = await _joinAsSecondPlayer(provider);
                    print(_contestId);
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (_) => ContestArena(contestId: _contestId),
                      ),
                    );
                  },
                );
              }
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      child: SpinKitCircle(color: Colors.pink),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Container(
                        child: Text(
                          'Preparing your questions',
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            });
      },
    );
  }

  Future<DocumentSnapshot> _createContest(
      AuthProvider provider, List questions) async {
    final _username = await _getUsername(provider);
    Map<String, dynamic> _contestData = {
      "topic_name": "${widget.subject}",
      "firstplayer_name": "${_username.get('name')}",
      "firstplayer_uid": "${provider.firebaseAuth.currentUser!.uid}",
      "secondplayer_uid": null,
      "secondplayer_name": null,
      "questions": questions,
      "firstplayer_score": 0,
      "secondplayer_score": 0
    };
    final DocumentReference _createdContest =
        FirebaseFirestore.instance.collection('contest').doc();
    _createdContest.set(_contestData);
    return _createdContest.get();
  }

  Future<DocumentSnapshot> _joinAsSecondPlayer(AuthProvider provider) async {
    QuerySnapshot _openGame = await FirebaseFirestore.instance
        .collection('contest')
        .where('topic_name', isEqualTo: widget.subject)
        .where('firstplayer_uid',
            isNotEqualTo: '${provider.firebaseAuth.currentUser!.uid}')
        .snapshots()
        .first;

    final _username = await _getUsername(provider);
    Map<String, dynamic> _contestData = {
      "secondplayer_name": "${_username.get('name')}",
      "secondplayer_uid": "${provider.firebaseAuth.currentUser!.uid}",
    };
    final DocumentReference _joinedContest = FirebaseFirestore.instance
        .collection('contest')
        .doc('${_openGame.docs[0].id}');
    _joinedContest.update(_contestData);

    return _joinedContest.get();
  }

  Future<DocumentSnapshot> _getUsername(AuthProvider provider) {
    return FirebaseFirestore.instance
        .collection('users')
        .doc('${provider.firebaseAuth.currentUser!.uid}')
        .get();
  }

  Container buildBackground() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          colors: [Color(0xff2a1434), Color(0xff160d20), Color(0xff142332)],
        ),
      ),
    );
  }
}
