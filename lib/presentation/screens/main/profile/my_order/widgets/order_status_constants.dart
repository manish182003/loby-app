const String orderPlaced = "ORDER_PLACED";
const String sellerAccepted = "SELLER_ACCEPTED";
const String sellerRejected = "SELLER_REJECTED";
const String orderInProgress = "ORDER_IN_PROGRESS";
const String sellerDeliveryConfirmed = "SELLER_DELIVERY_CONFIRMED";
const String buyerDeliveryConfirmed = "BUYER_DELIVERY_CONFIRMED";
const String buyerDeliveryRejected = "BUYER_DELIVERY_REJECTED";
const String transactionCompleted = "TRANSACTION_COMPLETED";
const String lobyProtectionPeriod = "LOBY_PROTECTION_PERIOD";
const String orderCompleted = "ORDER_COMPLETED";

const List statuses = [
  'ORDER_PLACED',
  'SELLER_ACCEPTED',
  'SELLER_REJECTED',
  'ORDER_IN_PROGRESS',
  'SELLER_DELIVERY_CONFIRMED',
  'BUYER_DELIVERY_CONFIRMED',
  'BUYER_DELIVERY_REJECTED',
  'TRANSACTION_COMPLETED',
  'LOBY_PROTECTION_PERIOD',
  'ORDER_COMPLETED',
];



const Map<String, dynamic> statusesName = {
  'ORDER_PLACED': 'Order Placed',
  'SELLER_ACCEPTED': 'Seller Accepted',
  'SELLER_REJECTED': 'Seller Rejected',
  'ORDER_IN_PROGRESS': 'Order In Progress',
  'SELLER_DELIVERY_CONFIRMED': 'Seller Delivery Confirmed',
  'BUYER_DELIVERY_CONFIRMED': 'Buyer Delivery Confirmed',
  'BUYER_DELIVERY_REJECTED': 'Buyer Delivery Rejected',
  'TRANSACTION_COMPLETED': 'Transaction Completed',
  'LOBY_PROTECTION_PERIOD': 'Loby Protection Period',
  'ORDER_COMPLETED': 'Order Completed'
};

const Map<String, dynamic> duelStatusesName = {
  'ORDER_PLACED': 'Duel Placed',
  'SELLER_ACCEPTED': 'Seller Accepted',
  'SELLER_REJECTED': 'Seller Rejected',
  'ORDER_IN_PROGRESS': 'Duel In Progress',
  'SELLER_DELIVERY_CONFIRMED': 'Seller Selected Winner',
  'BUYER_DELIVERY_CONFIRMED': 'Buyer Selected Winner',
  'BUYER_DELIVERY_REJECTED': 'Buyer Delivery Rejected',
  'TRANSACTION_COMPLETED': 'Transaction Completed',
  'LOBY_PROTECTION_PERIOD': 'Loby Protection Period',
  'ORDER_COMPLETED': 'Order Completed'
};


const List buyerStatuses = [
  'Order Placed',
  'Seller Accepted',
  'Order in Progress',
  'Seller Delivery Confirmed',
  'Buyer Delivery Confirmed',
  'Transaction Completed',
];

const List sellerStatuses = [
  'Order Placed',
  'Seller Accepted',
  'Order in Progress',
  'Seller Delivery Confirmed',
  'Buyer Delivery Confirmed',
  'Transaction Completed',
  'Loby Protection Period',
  'Order Completed',
];

List duelStatuses = [
  'Duel Placed',
  'Seller Accepted',
  'Duel in Progress',
  'Seller Selected Winner',
  'Buyer Selected Winner',
  'Transaction Completed',
  'Loby Protection Period',
  'Order Completed',
];
