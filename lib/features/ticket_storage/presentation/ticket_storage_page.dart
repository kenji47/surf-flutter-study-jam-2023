import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/tickets/tickets_cubit.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/pdf_view_screen.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/ticket_list_item.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/widgets/bottom_sheet.dart';

class TicketStoragePage extends StatefulWidget {
  const TicketStoragePage({Key? key}) : super(key: key);

  @override
  State<TicketStoragePage> createState() => _TicketStoragePageState();
}

class _TicketStoragePageState extends State<TicketStoragePage> {
  @override
  Widget build(BuildContext context) {
    final TicketsCubit ticketsCubit = BlocProvider.of<TicketsCubit>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Хранение билетов'),
        // todo
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(25.0),
                ),
              ),
              builder: (context) {
                return Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: MyBottomSheet(
                    ticketsCubit: ticketsCubit,
                  ),
                );
              });
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: BlocBuilder<TicketsCubit, TicketsState>(
          builder: (context, state) {
            switch (state.status) {
              case TicketsStatus.loading:
                return Center(
                  child: CircularProgressIndicator(),
                );
                break;
              case TicketsStatus.success:
                final tickets = state.tickets;
                if (tickets.isEmpty)
                  return Center(
                    child: Text('Добавьте билет'),
                  );
                return ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      SizedBox(
                    height: 10,
                  ),
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      onDismissed: (direction) {
                        ticketsCubit.deleteTicket(tickets[index].id!);
                      },
                      child: InkWell(child: TicketListItem(ticket: tickets[index]), onTap: (){
                        print('file path ${tickets[index].filePath}');
                        if (tickets[index].filePath != null) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  PDFScreen(path: tickets[index].filePath, title: tickets[index].name,),
                            ),
                          );
                        }

                      }),
                    );
                  },
                  itemCount: tickets.length,
                );
                break;
              case TicketsStatus.failure:
                return Center(
                  child: Text(state.errorMessage!),
                );
                break;
            }
          },
        ),
      ),
    );
  }
}
