import 'package:surf_flutter_study_jam_2023/features/ticket_storage/data/TicketsRepository.dart';
import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/model/ticket.dart';

class TicketsRepositoryImpl extends TicketsRepository{
  final List<Ticket> tickets = [];

  Future<List<Ticket>> getTickets() async {
    return tickets;
  }

  Future<String> addTicket(Ticket ticket) async {
    final id = DateTime.now().toString(); // todo change
    tickets.add(ticket.copyWith(
      id: id,
    ));
    return id;
  }

  updateTicket(Ticket ticket) {
    final index = tickets.indexWhere((element) => element.id == ticket.id);
    if (index == -1) return;
    tickets[index] = ticket;
  }

  deleteTicket(String id) {
    final index = tickets.indexWhere((element) => element.id == id);
    if (index == -1) return;
    tickets.removeAt(index);
  }
}
