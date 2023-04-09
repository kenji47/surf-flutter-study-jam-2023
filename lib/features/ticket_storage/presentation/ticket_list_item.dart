import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/file_downloader/file_downloader_cubit.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/file_downloader/file_downloader_state.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/model/ticket.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/tickets/tickets_cubit.dart';

class TicketListItem extends StatelessWidget {
  final Ticket ticket;

  const TicketListItem({Key? key, required this.ticket}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TicketsCubit ticketsCubit = BlocProvider.of<TicketsCubit>(context);
    return BlocProvider(
      create: (_) => FileDownloaderCubit(ticket.downloaded),
      child: Builder(builder: (context) {
        return BlocConsumer<FileDownloaderCubit, FileDownloaderState>(
          listener: (prev, current) {
            if (current.status == FileDownloaderStatus.completed) {
              ticketsCubit.updateTicket(
                ticket.copyWith(
                  downloaded: true,
                  filePath: current.filePath,
                ),
              );
            }
          },
          builder: (context, state) {
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                color: Colors.grey.withOpacity(0.2),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(5),
                title: Text(
                  ticket.name,
                  overflow: TextOverflow.ellipsis,
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: _getTicketTypeIcon(ticket.ticketType),
                ),
                subtitle: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      LinearProgressIndicator(
                        value: _getProgress(state),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: _getStatusWidget(state),
                      ),
                    ],
                  ),
                ),
                trailing: Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: _getTrailingIcon(
                    state,
                    context.read<FileDownloaderCubit>(),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Icon _getTicketTypeIcon(TicketType ticketType) {
    switch (ticketType) {
      case TicketType.bus:
      case TicketType.train:
      case TicketType.plane:
        return Icon(Icons.airplanemode_active_outlined);
    }
  }

  Widget _getStatusWidget(FileDownloaderState state) {
    switch (state.status) {
      case FileDownloaderStatus.initial:
        return Text('Ожидает начала загрузки');
      case FileDownloaderStatus.downloading:
        return Text('Загружается: ${state.progressString}');
      case FileDownloaderStatus.completed:
        return Text('Файл загружен');
      case FileDownloaderStatus.failure:
        return Text('Ошибка: ${state.errorMessage}');
    }
  }

  double _getProgress(FileDownloaderState state) {
    switch (state.status) {
      case FileDownloaderStatus.initial:
        return 0.0;
      case FileDownloaderStatus.downloading:
        return state.progress;
      case FileDownloaderStatus.completed:
        return 1.0;
      case FileDownloaderStatus.failure:
        return state.progress;
    }
  }

  // refactor
  Widget _getTrailingIcon(
      FileDownloaderState state, FileDownloaderCubit cubit) {
    switch (state.status) {
      case FileDownloaderStatus.initial:
        return IconButton(
          icon: Icon(Icons.cloud_queue),
          onPressed: () {
            cubit.downloadFile(ticket.url);
          },
        );
      case FileDownloaderStatus.downloading:
        return IconButton(
          icon: Icon(Icons.cancel_outlined),
          onPressed: () {
            cubit.cancelDownload();
            //bloc.add(DownloadFileEvent(ticket.url));
          },
        );
      case FileDownloaderStatus.completed:
        return IconButton(
          icon: Icon(Icons.cloud_download_rounded),
          onPressed: () {
            //bloc.add(DownloadFileEvent(ticket.url));
          },
        );
      case FileDownloaderStatus.failure:
        return IconButton(
          icon: Icon(Icons.cloud_queue),
          onPressed: () {
            // download again
            cubit.downloadFile(ticket.url);
          },
        );
    }
  }
}
