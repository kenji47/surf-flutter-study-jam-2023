part of 'tickets_cubit.dart';

enum TicketsStatus { loading, success, failure }
class TicketsState {
  final TicketsStatus status;
  final List<Ticket> tickets;
  final String? errorMessage;

  TicketsState({this.status = TicketsStatus.loading, this.tickets = const [], this.errorMessage});

  TicketsState copyWith({
    TicketsStatus? status,
    List<Ticket>? tickets,
    String? errorMessage,
  }) {
    return TicketsState(
      status: status ?? this.status,
      tickets: tickets ?? this.tickets,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}