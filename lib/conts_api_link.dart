import 'package:gazi_sales_app/sales/constant/app_constants.dart';

class ConstApiLink {
  AppConstants appConstants = AppConstants();

  // final String loginApi =
  //     'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/loginapi.php';
  final String loginApi =
      'http://${AppConstants.baseurl}/salesforce/loginapi.php';

  //approver notifications
  final String poWoApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/po_wo/PO_notification.php';
  final String csApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/CS/cs.php';
  final String srApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/sr/sr.php';
  final String pendingVoucherApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/voucher/pendingVoucher.php';
  final String cashAdvApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/Cash_Adv/cash_adv.php';
  final String depositApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/sales/deposit/deposit.php';
  final String pendingSPRApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/spr/spr_notifications.php';
  final String pendingSpotPurchaseAdvanceApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/spotpurchaseadvance.php';
  final String grnApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/grn.php';
  final String sqcApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/sqclist.php';
  final String prnApi = 'has no data';
  final String soApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/sales/so/so.php';
  final String dealerVisitApi =
      'http://${AppConstants.baseurl}/salesforce/TSO_Daily_Visit.php?id=972';
  final String dcApi =
      'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc.php';
  final String doApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingInvoice.php';
  final String pendingPSRAApi = 'no data present for further proceed';
  final String pendingBOMApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingBOM.php';
  final String pendingBMPApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/preProcessBOM.php';
  final String pendingBATPApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/PendingPreProcessBatch.php';
  final String pendingBATApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingBatch.php';
  final String cusWaitListApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/customer.php';
  final String creditInfoApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/credit_info.php';
  final String specialRateAPi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/special_rate.php';
  final String specialBonusAPi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/special_bonus.php';

  // final String pendingSupplierApi =
  //     'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingBatch.php';
  final String moneyreqapproval =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/moneyreqapproval.php';
  final String moneyreqAdjustAPi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/money_reqapproval_adjust.php';
  final String itemsNotiAPi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/item.php';
  final String serviceNotiAPi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/service.php';
  final String supplierNotiAPi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/supplier.php';

  //approver notifications details
  final String poWoDetailsApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/po_wo/PO_Detail.php';
  final String csDetailsApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/CS/cs_Details.php';
  final String srDetailsApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/sr/srDetails.php';
  final String pendingVoucherDetailsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingVoucherDetails.php';
  final String cashAdvDetailsApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/Cash_Adv/cashAdv_details.php';
  final String pendingSPRDetailsApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/spr/spr_details.php';
  final String pendingSpotPurchaseAdvanceDetails = 'Has no data for test';
  final String grnDetailsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/grndetail.php';
  final String sqcDetailsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/sqcdetails.php';
  final String prnDetailsApi = 'has no data';
  final String soDetailsApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/sales/so/soDetails.php';
  final String dcDetailsApi =
      'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc_Details.php';
  final String doDetailsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingInvoicedetails.php';
  final String pendingPSRADetailsApi = 'no data present for further proceed';
  final String pendingBOMDetailsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingBOMdetails.php';
  final String pendingBMPDetailsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/preProcessBOMdetails.php';
  final String pendingBATPDetailsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/PendingPreProcessBatchdetails.php';
  final String pendingBATDetailsApi =
      'http://${AppConstants.baseurl}/gazi/notification/production/batch/batch_details.php';

  //notification details terms&conditions
  final String poTermsApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/poterms.php';

  //approver notification approve & reject
  final String poApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/poapprove.php';
  final String poRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/poreject.php';

  final String cashAdvApproveApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/deposit/cash_Approve.php';
  final String cashAdvRejectApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/deposit/cash_Reject.php';

  final String csApproveApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/CS/csapprove.php';
  final String csRejectApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/CS/csreject.php';

  final String srApproveApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/sr/srapprove.php';
  final String srRejectApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/sr/srreject.php';

  final String depositApproveApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/deposit/deposit_Approve.php';
  final String depositRejectApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/deposit/deposit_Reject.php';

  final String pendingVoucherApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingVoucherapproval.php';
  final String pendingVoucherRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingVoucherreject.php';

  final String pendingSPRApproveApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/spr/spr_approve.php';
  final String pendingSPRRejectApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/scm/spr/spr_reject.php';

  //pending SPA has issue, details screen not present and api need to test
  final String pendingSpotPurchaseAdvanceApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/spotpurchaseadvanceapprove.php';
  final String pendingSpotPurchaseAdvanceRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/spotpurchaseadvancereject.php';

  final String grnApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/grnapprove.php';
  final String grnRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/grnreject.php';

  final String sqcApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/sqclistapprove.php';
  final String sqcRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/sqclistreject.php';

  final String prnApproveApi = 'has no data';
  final String prnRejectApi = 'has no data';

  final String soApproveApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/so/soApprove.php';
  final String soRejectApi =
      'http://${AppConstants.baseurl}/GAZI/Notification/so/soReject.php';

  final String dcApproveApi =
      'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc_Approve.php';
  final String dcRejectApi =
      'http://${AppConstants.baseurl}/gazi/notification/sales/dc/dc_Reject.php';

  final String doApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingInvoiceApprove.php';
  final String doRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingInvoiceReject.php';

  final String pendingPSRAApproveApi = 'no data present for further proceed';
  final String pendingPSRARejectApi = 'no data present for further proceed';

  final String pendingBOMApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingBOMApprove.php';
  final String pendingBOMRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/pendingBOMreject.php';

  final String pendingBMPApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/preProcessBOMapprove.php';
  final String pendingBMPRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/preProcessBOMreject.php';

  final String pendingBATPApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/PendingPreProcessBatchApprove.php';
  final String pendingBATPRejectApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/PendingPreProcessBatchReject.php';

  final String pendingBATApproveApi =
      'http://${AppConstants.baseurl}/gazi/notification/production/batch/batch_approve.php';
  final String pendingBATRejectApi =
      'http://${AppConstants.baseurl}/gazi/notification/production/batch/batch_reject.php';

  final String moneyReqApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/moneyreqapprovalapprove.php';
  final String moneyReqReject =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/moneyreqapprovalreject.php';

  final String moneyReqAdjApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/moneyreqapprovalapprove_adj.php';
  final String moneyReqAdjReject =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/moneyreqapprovalreject_adj.php';

  final String cusWaitListApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/customer_approve.php';
  final String cusWaitListReject =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/customer_reject.php';

  final String serviceNotiApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/service_approve.php';
  final String serviceNotiReject =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/service_reject.php';

  final String itemsNotiApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/item_approve.php';
  final String itemsNotiReject =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/item_reject.php';

  final String supplierNotiApproveApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/supplier_approve.php';
  final String supplierNotiReject =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/notifications/supplier_reject.php';

  //HR Notification
  final String lateEpmApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/lateemployee.php';
  final String earlyLeaveEpmApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/earlyemployee.php';
  final String leaveTourEpmApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/leaveandtouradmin.php';
  final String absEpmApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/absentemployee.php';
  final String empReqApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/lateemployee.php';
  final String shortLApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/earlyemployee.php';
  final String clearLApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/leaveandtouradmin.php';
  final String settleLApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/absentemployee.php';
  final String hrdLApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/absentemployee.php';

  //HR Approve & Reject
  final String lateEmpApproveApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/lateapprove.php';
  final String lateEmpRejectApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/latereject.php';

  final String earlyLeaveEpmApproveApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/earlyapprove.php';
  final String earlyLeaveEpmRejectApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/earlyreject.php';

  final String leaveTourEpmApproveApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/leaveandtourapprove.php';
  final String leaveTourEpmRejectApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/leaveandtourreject.php';

  final String absEpmApproveApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/absentapprove.php';
  final String absEpmRejectApi =
      'http://${AppConstants.baseurl}/GAZI/HR/Notification/absentreject.php';

  //User absent,late,early,leave Notifications api
  final String uLateEpmApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/HR/employeenotification/early.php';
  final String uEarlyLeaveEpmApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/HR/employeenotification/early.php';
  final String uLeaveTourEpmApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/HR/employeenotification/early.php';
  final String uAbsEpmApi =
      'http://${AppConstants.baseurl}/API_Aygaz/aygaz/HR/employeenotification/early.php';
}

//terms and conditions details screen a approve and reject button ta check kora lagbe.
