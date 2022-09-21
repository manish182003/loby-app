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

const List duelStatuses = [
  'Duel Placed',
  'Seller Accepted',
  'Duel in Progress',
  'Select Winner',
  'Transaction Completed',
  'Loby Protection Period',
  'Order Completed',
];
