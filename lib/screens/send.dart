import 'package:flutter/material.dart';
import 'package:project/config/global_state.dart';
import 'package:project/styles/style.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:project/model/professor.dart';
import 'package:project/model/subject.dart';
import 'package:project/model/exam.dart';
import 'package:flutter_document_picker/flutter_document_picker.dart';
import 'dart:io';

StorageReference reference = FirebaseStorage.instance.ref();
final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

class Send extends StatefulWidget {
  @override
  _SendState createState() => _SendState();
}

class _SendState extends State<Send> {
  Professor profSelected;
  Subject subjectSelected;
  String _path = '-', _filename;
  Exam _exam;
  bool _pickFileInProgress = false;
  bool _iosPublicDataUTI = true;
  bool _checkByMimeType = false;
  var _types = ['P1', 'P2', 'P3', 'PF', 'Segunda Chamada'];
  var _currentItemSelected = 'P1';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("Enviar Prova"),
        elevation: 2.0,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.send),
            onPressed: () => sendFile(),
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildDropdown("professor"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              _buildDropdown("subject"),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              DropdownButton<String>(
                items: _types.map((String dropDownStringItem) {
                  return DropdownMenuItem<String>(
                    value: dropDownStringItem,
                    child: Text(dropDownStringItem),
                  );
                }).toList(),
                hint: Text("Selecione o Tipo de Prova"),
                onChanged: (String valueSelected) {
                  _dropDownItemSelected(valueSelected);
                },
                value: _currentItemSelected,
              ),
            ],
          ),
          _path == "-"
              ? MaterialButton(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: Text("Escolher arquivo"),
                  ),
                  color: Style.mainTheme.primaryColor,
                  textColor: Colors.white,
                  onPressed: () => _pickFileInProgress ? null : _pickDocument(),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildDropdown(String selection) {
    return StreamBuilder<QuerySnapshot>(
      stream: firestoreQuery(selection),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return CircularProgressIndicator();

        if (snapshot.data.documents.length == 0) {
          if (selection == "subject")
            return Text("Erro - Não há disciplinas cadastradas");
          else
            return Text("Erro - Não há professores cadastrados");
        }

        return _buildItem(context, snapshot.data.documents, selection);
      },
    );
  }

  Widget _buildItem(
      BuildContext context, List<DocumentSnapshot> data, String selection) {
    return DropdownButton<dynamic>(
      items: data.map((DocumentSnapshot doc) {
        if (selection == "subject") {
          Subject subject = Subject.fromMap(doc.data, reference: doc.reference);

          return DropdownMenuItem<Subject>(
            value: subject,
            child: Text(subject.name),
          );
        } else {
          Professor professor =
              Professor.fromMap(doc.data, reference: doc.reference);

          return DropdownMenuItem<Professor>(
            value: professor,
            child: Text(professor.name),
          );
        }
      }).toList(),
      hint: Text(selection == "subject"
          ? "Escolha uma disciplina"
          : "Escolha um professor"),
      onChanged: (dynamic selected) {
        setState(() {
          if (selection == "subject")
            subjectSelected = selected;
          else
            profSelected = selected;
        });
      },
      //TODO: corrigir erro ao selecionar opção da lista e mostrar em "value"
      value: null,
    );
  }

  Stream firestoreQuery(String selection) {
    if (selection == "subject") {
      return GlobalState.course.reference
          .collection(Subject.collectionName)
          .orderBy("nome")
          .snapshots();
    } else {
      return GlobalState.course.reference
          .collection(Professor.collectionName)
          .orderBy("nome")
          .snapshots();
    }
  }

  _pickDocument() async {
    String result;
    try {
      setState(() {
        _path = '-';
        _pickFileInProgress = true;
      });

      FlutterDocumentPickerParams params = FlutterDocumentPickerParams(
        allowedFileExtensions: ['pdf'],
        allowedUtiTypes: _iosPublicDataUTI
            ? null
            : 'com.yourcompany.project'
                .split(' ')
                .where((x) => x.isNotEmpty)
                .toList(),
        allowedMimeType: _checkByMimeType ? 'application/*' : null,
      );

      result = await FlutterDocumentPicker.openDocument(params: params);
    } catch (e) {
      print(e);
      result = 'Error: $e';
    } finally {
      setState(() {
        _pickFileInProgress = false;
      });
    }

    setState(() {
      print(result);
      _path = result;
    });
  }

  Future sendFile() async {
    sendingFile(true);
    //TODO: manipular o envio de arquivo e as exceções que podem gerar
    if (_path == '-') {
      return;
    }
    //TODO: gerar nome do arquivo a ser salvo no Storage
    _filename = "${profSelected.name}-${subjectSelected.name}";
    File file = File(_path);
    // não é necessário criar variável, mas uploadTask pode ser usado para aprimorar o layout da tela
    StorageUploadTask uploadTask = reference
        .child('${subjectSelected.name}/${profSelected.name}/$_filename')
        .putFile(file);
    uploadTask.onComplete.then((s) {
      sendingFile(false);
      _scaffoldKey.currentState.showSnackBar(SnackBar(
          backgroundColor: Style.mainTheme.primaryColor,
          content: Text(
            "Arquivo enviado com sucesso",
            style: TextStyle(color: Colors.white),
            textAlign: TextAlign.center,
          )));
    });
    setFirestoreData();

    setState(() {
      _path = "-";
    });
    /* comandos necessários para pegar o url de download do arquivo
    (isso poderá ser usado caso o usuário desejar baixar o pdf ao visualizá-lo)
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    String url = (await  downloadUrl.ref.getDownloadURL());
    */
  }

  sendingFile(bool isSending) {
    if (isSending) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: Style.mainTheme.primaryColor,
          content: Row(
            children: <Widget>[
              CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
              Text(
                " Enviando arquivo...",
                textAlign: TextAlign.right,
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
        ),
      );
    } else
      _scaffoldKey.currentState.hideCurrentSnackBar();
  }

  setFirestoreData() {
    //TODO: subjectSelected.reference.documentID está retornando null
    _exam = Exam('2019-1', profSelected.name,
        subjectSelected.reference.documentID, _filename, 'p1');
    GlobalState.course.reference
        .collection(Exam.collectionName)
        .add(_exam.toMap());
  }

  void _dropDownItemSelected(String valueSelected) {
    setState(() {
      this._currentItemSelected = valueSelected;
    });
  }
}
