import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../widgets/inline_form_field.dart';
import '../models/setting.dart';

class Setting extends StatefulWidget {
  const Setting({super.key, required this.params});

  final SettingParams params;

  @override
  State<StatefulWidget> createState() => SettingState();
}

class SettingState extends State<Setting> {
  late SettingParams params;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    params = widget.params;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return PopScope(
        onPopInvoked: (bool state) {
          Navigator.pop<SettingParams>(context, params);
        },
        child: Scaffold(
          appBar: AppBar(title: const Text('设置')),
          backgroundColor: Colors.grey[200],
          body: ListView(
            children: [
              InlineFormField(
                title: '版本',
                formWidget: DropdownMenu<int>(
                  initialSelection: params.version,
                  dropdownMenuEntries: [
                    const DropdownMenuEntry(value: -1, label: '自动'),
                    ...List<DropdownMenuEntry<int>>.generate(
                        40, (index) => DropdownMenuEntry(value: index + 1, label: (index + 1).toString()))
                  ],
                  onSelected: (int? value) {
                    params.version = value ?? -1;
                  },
                ),
              ),
              InlineFormField(
                title: '容错级别',
                formWidget: DropdownMenu<int>(
                  initialSelection: params.errorCorrectionLevel,
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: QrErrorCorrectLevel.L, label: '低'),
                    DropdownMenuEntry(value: QrErrorCorrectLevel.M, label: '中'),
                    DropdownMenuEntry(value: QrErrorCorrectLevel.Q, label: '较高'),
                    DropdownMenuEntry(value: QrErrorCorrectLevel.H, label: '高')
                  ],
                  onSelected: (int? value) {
                    params.errorCorrectionLevel = value ?? -1;
                  },
                ),
              ),
              InlineFormField(
                title: '无间隙的',
                formWidget: Switch(
                    value: params.gapLess,
                    onChanged: (bool value) {
                      setState(() {
                        params.gapLess = value;
                      });
                    }),
              ),
            ],
          ),
        ));
  }
}
