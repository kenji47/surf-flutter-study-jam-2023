import 'package:flutter/material.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/tickets/tickets_cubit.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/utils.dart';

class MyBottomSheet extends StatefulWidget {
  final TicketsCubit ticketsCubit;

  const MyBottomSheet({super.key, required this.ticketsCubit});

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<MyBottomSheet> {
  late TextEditingController urlController;
  bool isUrlValid = true;

  @override
  void initState() {
    super.initState();
    urlController = TextEditingController();
    urlController.addListener(() {
      if (urlController.text.isNotEmpty && isUrlValid == false) {
        setState(() {
          isUrlValid = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      padding: EdgeInsets.only(
        top: 25,
        right: 25,
        left: 25,
      ),
      child: Column(
        children: [
          TextField(
            controller: urlController,
            decoration: InputDecoration(
              labelText: 'Введите url',
              hintText: 'Введите url',
              errorText: isUrlValid ? null : 'Введите корректный url',
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Colors.grey,
                    width: 1,
                  )),
            ),
          ),
          TextButton(
            onPressed: () {
              if (urlController.text.isEmpty ||
                  !isValidPdfUrl(urlController.text)) {
                setState(() {
                  isUrlValid = false;
                });
                return;
              }
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(
                  SnackBar(
                    content: Text('Билет добавлен'),
                    action: SnackBarAction(
                      label: 'Закрыть',
                      onPressed: () {
                        ScaffoldMessenger.of(context).hideCurrentSnackBar();
                      },
                    ),
                  ),
                );
              Navigator.pop(context);
              widget.ticketsCubit.addTicket(
                name: getFileName(urlController.text),
                url: urlController.text,
              );
            },
            child: Text('Добавить'),
          )
        ],
      ),
    );
  }
}
