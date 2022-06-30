import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_form_builder/flutter_form_builder.dart';
// import 'package:form_builder_file_picker/form_builder_file_picker.dart';
import 'package:provider/provider.dart';

import 'package:sirmo/components/app-decore.dart';

import '../../components/personal_alert.dart';
import '../../models/zem.dart';
import '../../services/zem.sevice.dart';
import '../../utils/app-util.dart';
import '../../utils/request-exception.dart';
import '../home/home.screen.dart';

class BecomeZemFileScreen extends StatefulWidget {
  BecomeZemFileScreen({Key? key}) : super(key: key);

  @override
  State<BecomeZemFileScreen> createState() => _BecomeZemFileScreenState();
}

class _BecomeZemFileScreenState extends State<BecomeZemFileScreen> {
  final _formKey = GlobalKey<FormState>();
  String? errorMessage;

  ScrollController _scrollController = ScrollController();

  Zem zem = Zem();
  RequestExcept? validation;
  bool _useCustomFileViewer = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppDecore.appBar(context, "Documents"),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Card(
          elevation: 10.0,
          margin: EdgeInsets.all(8),
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // FormBuilderFilePicker(
                  //   name: 'images',
                  //   decoration: const InputDecoration(labelText: 'Attachments'),
                  //   maxFiles: null,
                  //   allowMultiple: true,
                  //   previewImages: true,
                  //   onChanged: (val) => debugPrint(val.toString()),
                  //   selector: Row(
                  //     children: const <Widget>[
                  //       Icon(Icons.file_upload),
                  //       Text('Upload'),
                  //     ],
                  //   ),
                  //   onFileLoading: (val) {
                  //     debugPrint(val.toString());
                  //   },
                  //   customFileViewerBuilder:
                  //       _useCustomFileViewer ? customFileViewerBuilder : null,
                  // ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        child: const Text('Submit'),
                        onPressed: () {
                          _formKey.currentState!.save();
                          // debugPrint(_formKey.currentState!.value.toString());
                        },
                      ),
                      const Spacer(),
                      ElevatedButton(
                        child: Text(_useCustomFileViewer
                            ? 'Use Default File Viewer'
                            : 'Use Custom File Viewer'),
                        onPressed: () {
                          setState(() =>
                              _useCustomFileViewer = !_useCustomFileViewer);
                        },
                      ),
                    ],
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.5,
                      child:
                          AppDecore.submitButton(context, "Valider", onSubmit))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget customFileViewerBuilder(
    List<PlatformFile>? files,
    FormFieldSetter<List<PlatformFile>> setter,
  ) {
    return ListView.separated(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final file = files![index];
        return ListTile(
          title: Text(file.name),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              files.removeAt(index);
              setter.call([...files]);
            },
          ),
        );
      },
      separatorBuilder: (context, index) => const Divider(
        color: Colors.blueAccent,
      ),
      itemCount: files!.length,
    );
  }

  onSubmit() async {
    if (_formKey.currentState != null && _formKey.currentState!.validate()) {
      PersonalAlert.showLoading(context);
      context.read<ZemService>().becomeZem(zem).then((value) {
        PersonalAlert.showSuccess(context,
                message: "Vous demander est enregistrées evac succès")
            .then((value) {
          AppUtil.goToScreen(context, HomeScreen());
        });
        context.read<ZemService>().zem = value;
      }).onError((error, stackTrace) {
        if (error is RequestExcept) {
          setState(() {
            validation = error;
          });
        } else if (error is String) {
          PersonalAlert.showError(context, message: "$error");
        }
      });
    }
  }
}
