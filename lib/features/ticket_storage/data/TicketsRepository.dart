import 'package:surf_flutter_study_jam_2023/features/ticket_storage/logic/model/ticket.dart';

abstract class TicketsRepository {
  Future<List<Ticket>> getTickets();

  Future<String> addTicket(Ticket ticket);

  updateTicket(Ticket ticket);

  deleteTicket(String id);
}