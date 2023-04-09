
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/TicketsRepository.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/directories_handler.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/file_downloader.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/file_downloader_impl.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/tickets_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupGetIt() async {
  getIt.registerFactory<Dio>(() => Dio());
  getIt.registerFactory<FileDownloader>(() => FileDownloaderImpl());
  getIt.registerFactory<DirectoriesHandler>(() => DirectoriesHandler());
  getIt.registerSingleton<TicketsRepository>(TicketsRepositoryImpl());
}

