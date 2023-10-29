class CustomerTicketDetails {
  final String locationLogo;
  final String locationName;
  final int invoiceId;
  final String parkingSpotNumber;
  final String parkingSectionDescription;
  final String parkingFloorDescriptions;
  final DateTime invoiceDateTime;
  final double ticketPeriod;
  final double parkingSpotCostPerHour;
  final double subTotal;
  final double taxAmount;
  final double totalCost;
  final String invoicePaymentStatus;
  final int customerNo;
  final int invoiceNo;


  CustomerTicketDetails({
    required this.locationLogo,
    required this.locationName,
    required this.invoiceId,
    required this.parkingSpotNumber,
    required this.parkingSectionDescription,
    required this.parkingFloorDescriptions,
    required this.invoiceDateTime,
    required this.ticketPeriod,
    required this.parkingSpotCostPerHour,
    required this.subTotal,
    required this.taxAmount,
    required this.totalCost,
    required this.invoicePaymentStatus,
    required this.customerNo,
    required this.invoiceNo


  });

}
class CustomerTickets {
  final String locationLogo;
  final String locationName;
  final String parkingSpotNumber;
  final DateTime ticketDateTime;
  final int customerNo;

  CustomerTickets({
    required this.locationLogo,
    required this.locationName,
    required this.parkingSpotNumber,
    required this.ticketDateTime,
    required this.customerNo


  });
}