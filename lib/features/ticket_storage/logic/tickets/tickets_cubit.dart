import 'package:bloc/bloc.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/TicketsRepository.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/model/ticket.dart';

part 'tickets_state.dart';

class TicketsCubit extends Cubit<TicketsState> {
  final TicketsRepository _repository;

  TicketsCubit(this._repository) : super(TicketsState()) {
    fetchTickets();
  }

  Future<void> fetchTickets() async {
    final tickets = await _repository.getTickets();
    emit(state.copyWith(
      tickets: tickets,
      status: TicketsStatus.success,
    ));
  }

  Future<void> addTicket(
      {ticketType = TicketType.plane,
      required String name,
      required String url}) async {
    final newTicket = Ticket(
      name: name,
      url: url,
      ticketType: ticketType,
      downloaded: false,
      filePath: null,
    );
    final id = await _repository.addTicket(newTicket);
    // todo change
    fetchTickets();
  }

  Future<void> updateTicket(Ticket ticket) async {
    _repository.updateTicket(ticket);
    // todo change
    fetchTickets();
  }

  Future<void> deleteTicket(String id) async {
    _repository.deleteTicket(id);
    // todo change
    fetchTickets();
  }
}
