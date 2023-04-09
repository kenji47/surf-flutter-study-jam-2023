import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/TicketsRepository.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/tickets/tickets_cubit.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/presentation/ticket_storage_page.dart';
import 'package:surf_flutter_study_jam_2023/getit_service_locator.dart';


void main() async{
  await setupGetIt();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: BlocProvider(
        create: (context) => TicketsCubit(getIt<TicketsRepository>()),
        child: TicketStoragePage(),
      ),
    );
  }
}
