import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../pages/setting.dart';
import '../widgets/paper.dart';
import '../tools/define.dart';
import '../models/setting.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends State<Home> {
  FocusNode textFieldFocus = FocusNode();
  TextEditingController textEditingController = TextEditingController(text: '');

  String qrText = '';

  SettingParams settingParams = SettingParams();

  final storage = const FlutterSecureStorage();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    restoreLastGeneration();
    restoreSetting();
  }

  Future<void> restoreLastGeneration() async {
    String? store = await storage.read(key: Keys.lastGeneration);
    if (store != null) {
      textEditingController.text = store;
      createQrcode(store);
    }
  }

  Future<void> restoreSetting() async {
    String? store = await storage.read(key: Keys.settingStorage);
    if (store != null) {
      settingParams = SettingParams.fromJson(store);
    }
  }

  void createQrcode(String text) async {
    if (text.trim().isNotEmpty) {
      qrText = text;
      await storage.write(key: Keys.lastGeneration, value: qrText);
      setState(() {});
    }
  }

  void showSetting() async {
    settingParams = await Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => Setting(params: settingParams)));
    await storage.write(key: Keys.settingStorage, value: settingParams.toJson());
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
          title: const Text(AppConfig.appName),
          actions: [IconButton(onPressed: showSetting, icon: const Icon(Icons.settings))]),
      body: Column(
        children: <Widget>[
          Paper(
            disableBottomMargin: true,
            child: TextField(
              focusNode: textFieldFocus,
              controller: textEditingController,
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), isDense: true, labelText: '文本', hintText: '输入文本内容'),
              spellCheckConfiguration: const SpellCheckConfiguration.disabled(),
              keyboardType: TextInputType.text,
              textInputAction: TextInputAction.send,
              onSubmitted: createQrcode,
              onTapOutside: (PointerDownEvent event) {
                textFieldFocus.unfocus();
              },
            ),
          ),
          Expanded(
            child: Paper(
              child: Center(
                  child: qrText.isNotEmpty
                      ? QrImageView(
                          data: qrText,
                          version: settingParams.version,
                          errorCorrectionLevel: settingParams.errorCorrectionLevel,
                          gapless: settingParams.gapLess,
                          size: 200.0,
                        )
                      : const Text('输入文本生成二维码', style: TextStyle(fontSize: 18, color: Colors.grey))),
            ),
          )
        ],
      ),
    );
  }
}
