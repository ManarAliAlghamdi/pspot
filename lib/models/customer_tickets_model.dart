class CustomerInvoiceDetails {
  final String locationLogo;
  final String locationName;
  final int invoiceId;
  final String parkingSpotNumber;
  final String parkingSectionDescription;
  final String parkingFloorDescriptions;
  final String invoiceDateTime;
  final int ticketPeriod;
  final double parkingSpotCostPerHour;
  final double subTotal;
  final double taxAmount;
  final double totalCost;
  final String invoicePaymentStatus;
  // final int customerNo;
  final int invoiceNo;


  CustomerInvoiceDetails({
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
    // required this.customerNo,
    required this.invoiceNo


});

}
class CustomerInvoices{
  final String locationLogo;
  final String locationName;
  final String parkingSpotNumber;
  final String ticketDateTime;
  final int invoiceNo;
  final int customerNo;


  CustomerInvoices({
    required this.locationLogo,
    required this.locationName,
    required this.parkingSpotNumber,
    required this.ticketDateTime,
    required this.invoiceNo,
    required this.customerNo



  });
}
// final int customerId;
// final int parkingSpotId;
// final int sectionNo;
// final int floorNo;
// final int locationNo;
// final int ticketNo;
// final int invoiceNo;
//
// required this.customerId,
// required this.parkingSpotId,
// required this.sectionNo,
// required this.floorNo,
// required this.locationNo,
// required this.ticketNo,
// required this.invoiceNo,