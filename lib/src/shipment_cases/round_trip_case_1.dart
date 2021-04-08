import 'package:flutter/cupertino.dart';
import 'package:posta_courier/models/registered_captain_model.dart';
import 'package:posta_courier/models/ride_model.dart';
import 'package:posta_courier/src/blocs/home_blocs/approved_captain_bloc.dart';
import 'package:posta_courier/src/blocs/home_blocs/order_bloc.dart';
import 'package:posta_courier/src/ui/home/payment/payment_with_cod_sheet.dart';
import 'package:posta_courier/src/ui/home/payment/payment_without_cod_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/delivered_item_sheet_ii.dart';
import 'package:posta_courier/src/ui/home/sheets/finding_order_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/go_to_pick_up_item_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/new_order_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/picked_up_item_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/ready_to_pick_up_item_sheet.dart';
import 'package:posta_courier/src/ui/home/sheets/go_to_new_location_sheet.dart';
import 'package:posta_courier/src/ui/widgets/dialog_loading.dart';

class RoundTripCase {
  static selectSheetRoundTrip(String state, context, String orderStatus) {
    switch (orderStatus) {
      case "PROCESSING_FORWARD":
        {
          switch (state) {
            case "ACCEPTED":
              {
                return GoToPickUpItemSheet();
              }
              break;
            case "STARTED":
              {
                return ReadyToPickUpItemSheet();
              }
              break;
            case "ARRIVED":
              {
                return PickedUpItemSheet(
                  shipmentCase: "PICKED_UP_CASE_1",
                );
              }
              break;
            case "PICKED_UP":
              {
                return DeliveredItemSheet(
                  shipmentCase: "DELIVERED_UP_CASE_1",
                );
              }
              break;
            case "DONE":
              {
                print("test000");
                return StreamBuilder(
                    stream: orderBloc.ride,
                    builder: (BuildContext context,
                        AsyncSnapshot<RideModel> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot
                                .data
                                .data
                                .bookings[orderBloc.getOrderIndex()]
                                .order
                                .cashOnDeliveryOption ==
                            "NONE") {
                          return PaymentWithoutCODSheet(
                            shipmentCase: "CASE_1",
                          );
                        } else {
                          return PaymentWithCODSheet(
                            shipmentCase: "CASE_1",
                          );
                        }
                      } else {
                        orderBloc.getRide3();
                        orderBloc.bookingAction();

                        return LoadingDialogWidget();
                      }
                    });
              }
              break;
            case "GO_TO_NEW_LOCATION":
              {
                print("test");
                return GoToNewLocationSheet();
              }
              break;
            default:
              {
                print("test0");
                // orderBloc.getRoundBackward();
                return StreamBuilder(
                  stream: approvedCaptainBloc.checkUser,
                  builder: (BuildContext context,
                      AsyncSnapshot<LogInModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.activeSuggestion != null) {
                        return NewOrderSuggestionSheet();
                      } else {
                        return FindingOrdersSheet();
                      }
                    } else {
                      return FindingOrdersSheet();
                    }
                  },
                );
              }
          }
        }
        break;
      case "PROCESSING_BACK":
        {
          switch (state) {
            case "ARRIVED":
              {
                return GoToNewLocationSheet();
              }
              break;
            case "PICKED_UP":
              {
                return DeliveredItemSheet(
                  shipmentCase: "ROUND_TRIP",
                );
              }
              break;
            case "DONE":
              {
                print("test1");
                // orderBloc.bookingAction();
                return StreamBuilder(
                    stream: orderBloc.ride,
                    builder: (BuildContext context,
                        AsyncSnapshot<RideModel> snapshot) {
                      if (snapshot.hasData) {
                        return PaymentWithoutCODSheet(
                          shipmentCase: "CASE_1",
                        );
                      } else {
                        orderBloc.getRide3();
                        orderBloc.bookingAction();

                        return LoadingDialogWidget();
                      }
                    });
              }
              break;
            case "GO_TO_NEW_LOCATION":
              {
                return GoToNewLocationSheet();
              }
              break;

            default:
              {
                print("test1");
                return StreamBuilder(
                  stream: approvedCaptainBloc.checkUser,
                  builder: (BuildContext context,
                      AsyncSnapshot<LogInModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.activeSuggestion != null) {
                        return NewOrderSuggestionSheet();
                      } else {
                        return FindingOrdersSheet();
                      }
                    } else {
                      return FindingOrdersSheet();
                    }
                  },
                );
              }
              break;
          }
        }
        break;

      case "GO_TO_NEW_LOCATION":
        {
          return GoToNewLocationSheet();
        }
        break;

      default:
        {
          print("test");
          return StreamBuilder(
            stream: approvedCaptainBloc.checkUser,
            builder:
                (BuildContext context, AsyncSnapshot<LogInModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data.activeSuggestion != null) {
                  return NewOrderSuggestionSheet();
                } else {
                  return FindingOrdersSheet();
                }
              } else {
                return FindingOrdersSheet();
              }
            },
          );
        }
    }
  }

  static selectSheetRoundTripShipperPay(String state, context,
      String orderStatus, int pay) {
    switch (orderStatus) {
      case "PROCESSING_FORWARD":
        {
          switch (state) {
            case "ACCEPTED":
              {
                return GoToPickUpItemSheet(
                  shipmentCase: "SHIPPER_PAY",
                );
              }
              break;
            case "STARTED":
              {
                return ReadyToPickUpItemSheet(shipmentCase: "SHIPPER_PAY");
              }
              break;
            case "ARRIVED":
              {
                return pay != null
                    ? PickedUpItemSheet(
                        shipmentCase: "CASE_1",
                      )
                    : PaymentWithoutCODSheet(
                        shipmentCase: "SHIPPER_PAY",
                      );
              }
              break;
            case "READY_TO_PICK_UP":
              {
                return PickedUpItemSheet(
                  shipmentCase: "CASE_1",
                );
              }
              break;

            case "PICKED_UP":
              {
                return StreamBuilder(
                    stream: orderBloc.ride,
                    builder: (BuildContext context,
                        AsyncSnapshot<RideModel> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot
                            .data
                            .data
                            .bookings[orderBloc.getOrderIndex()]
                            .order
                            .cashOnDeliveryOption ==
                            "NONE") {
                          return DeliveredItemSheet(
                            shipmentCase: "SHIPPER_PAY",
                          );
                        } else {
                          return DeliveredItemSheet(
                            shipmentCase: "SHIPPER_PAY_COD",
                          );
                        }
                      } else {
                        orderBloc.getRoundBackward();
                        return LoadingDialogWidget();
                      }
                    });
              }
              break;

            case "PAID":
              {
                // orderBloc.getRoundBackward();
                return PickedUpItemSheet(
                  shipmentCase: "ROUND_TRIP",
                );
              }
              break;

            case "PAYMENT":
              {
                return PaymentWithoutCODSheet(shipmentCase: "SHIPPER_PAY");
              }
              break;

            case "NULL":
              {
                return FindingOrdersSheet();
              }
              break;
            case "DONE":
              {
                return StreamBuilder(
                    stream: orderBloc.ride,
                    builder: (BuildContext context,
                        AsyncSnapshot<RideModel> snapshot) {
                      if (snapshot.hasData) {
                        if (snapshot
                            .data
                            .data
                            .bookings[orderBloc.getOrderIndex()]
                            .order
                            .cashOnDeliveryOption ==
                            "NONE") {
                          return PaymentWithoutCODSheet(
                            shipmentCase: "CASE_1",
                          );
                        } else {
                          return PaymentWithCODSheet(shipmentCase: "CASE_1",);
                        }
                      } else {
                        // orderBloc.bookingAction();
                        orderBloc.getRide3();

                        return LoadingDialogWidget();
                      }
                    });
              }
              break;
            case "GO_TO_NEW_LOCATION":
              {
                return GoToNewLocationSheet(orderStatus: orderStatus,);
              }
              break;
            default:
              {
                print("test2");
                return StreamBuilder(
                  stream: approvedCaptainBloc.checkUser,
                  builder: (BuildContext context,
                      AsyncSnapshot<LogInModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.activeSuggestion != null) {
                        return NewOrderSuggestionSheet();
                      } else {
                        return FindingOrdersSheet();
                      }
                    } else {
                      return FindingOrdersSheet();
                    }
                  },
                );
              }
          }
        }
        break;
      case "PROCESSING_BACK":
        {
          switch (state) {
            case "ARRIVED":
              {
                return PickedUpItemSheet(
                  shipmentCase: "ROUND_TRIP",
                );
              }
              break;
            case "PICKED_UP":
              {
                return GoToNewLocationSheet(
                  orderStatus: orderStatus,
                );
              }
              break;
            case "READY_TO_DELIVERY":
              {
                return DeliveredItemSheet(
                  shipmentCase: "ROUND_TRIP",
                );
              }
              break;
            case "DONE":
              {
                return StreamBuilder(
                    stream: orderBloc.ride,
                    builder: (BuildContext context,
                        AsyncSnapshot<RideModel> snapshot) {
                      if (snapshot.hasData) {
                        return PaymentWithoutCODSheet(
                          shipmentCase: "CASE_1",
                        );
                      } else {
                        orderBloc.getRide3();
                        orderBloc.bookingAction();
                        return LoadingDialogWidget();
                      }
                    });
              }
              break;
            case "GO_TO_NEW_LOCATION":
              {
                return GoToNewLocationSheet();
              }
              break;

            default:
              {
                print("test22");
                return StreamBuilder(
                  stream: approvedCaptainBloc.checkUser,
                  builder: (BuildContext context,
                      AsyncSnapshot<LogInModel> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.data.activeSuggestion != null) {
                        return NewOrderSuggestionSheet();
                      } else {
                        return FindingOrdersSheet();
                      }
                    } else {
                      return FindingOrdersSheet();
                    }
                  },
                );
              }
              break;
          }
        }
        break;

      case "GO_TO_NEW_LOCATION":
        {
          return GoToNewLocationSheet();
        }
        break;

      default:
        {
          print("test22");
          return StreamBuilder(
            stream: approvedCaptainBloc.checkUser,
            builder:
                (BuildContext context, AsyncSnapshot<LogInModel> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data.data.activeSuggestion != null) {
                  return NewOrderSuggestionSheet();
                } else {
                  return FindingOrdersSheet();
                }
              } else {
                return FindingOrdersSheet();
              }
            },
          );
        }
    }
  }
}
