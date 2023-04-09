enum TicketType { bus, train, plane }

class Ticket {
  final String? id;
  final String name;
  final String url;
  final String? filePath;
  final TicketType ticketType;
  final bool downloaded;

  Ticket(
      {this.id,
      required this.name,
      required this.url,
      required this.ticketType,
      required this.downloaded,
      required this.filePath});

  Ticket copyWith({
    String? id,
    String? name,
    String? url,
    String? filePath,
    TicketType? ticketType,
    bool? downloaded,
  }) {
    return Ticket(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
      filePath: filePath ?? this.filePath,
      ticketType: ticketType ?? this.ticketType,
      downloaded: downloaded ?? this.downloaded,
    );
  }
}
