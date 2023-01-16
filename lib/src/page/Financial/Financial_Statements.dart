import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'dart:convert';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:untitled/src/page/Financial/query.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'financial.dart';
import 'financial_chart.dart';
import 'package:http/http.dart' as https;
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:meta/meta.dart';
import 'dart:convert';

import 'opendart/opendart.dart';

String stockCode = '';

class FS extends StatefulWidget {
  @override
  FS_Main createState() => FS_Main();
}

class FS_Main extends State<FS> with AutomaticKeepAliveClientMixin{
  fin_Query query = fin_Query();
  bool isLoading = false;

  @override
  void initState()   {
    // TODO: implement initState
    setState(() {
      isLoading = true;
    });
    super.initState();
    FinancialState fb = FinancialState();
    searchText = fb.name;
    Future<String> Stock_Code;
    Stock_Code = query.Find_Stock_Code(searchText);
    if(fb.name == ""){
      searchText = Get.arguments;
    }
    Stock_Code.then((val) async {
      // 종목코드가 나오면 해당 값을 출력
      print('val: $val');
      stockCode = val;

      String sales = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Revenue' And (sj_div = 'IS' or sj_div = 'CIS');";
      String selling = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_TotalSellingGeneralAdministrativeExpenses' And (sj_div = 'IS' or sj_div = 'CIS');";
      String EBIT = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_OperatingIncomeLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
      String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
      query.Find_state_of_comprehensive_income(sales,selling,EBIT,net_income);

      String Total_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Assets' And sj_div = 'BS';";
      String tangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_PropertyPlantAndEquipment' And sj_div = 'BS';";
      String intangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_IntangibleAssetsOtherThanGoodwill' And sj_div = 'BS';";
      String cash_equivalents="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashAndCashEquivalents' And sj_div = 'BS';";
      String total_capital="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Equity' and (sj_div ='BS' or account_detail =  '연결재무제표 [member]');";
      String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
      query.Find_statement_of_financial_position(Total_assets,tangible_assets,intangible_assets,cash_equivalents,total_capital,Total_Debt);

      String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
      String IACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInInvestingActivities' And sj_div = 'CF';";
      String FACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInFinancingActivities' And sj_div = 'CF';";
      query.Find_cash_flow_statemente(CFO,IACF,FACF);
    }).catchError((error) {
      // error가 해당 에러를 출력
      print('error: $error');
    });
    Future.delayed(Duration(seconds:2), () {
      setState(() {
        super.setState(() {
          isLoading = false;
        });
      });
    });
  }

  final TextEditingController _controller = TextEditingController();
  FocusNode focusNode = FocusNode();

  String searchText = Get.arguments;
  String Search_Stock_Code = '';

  Widget _Search(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              height: 36,
              child: Text("단위 : 억원"),
            ),
            SizedBox(width: 10,),
            ElevatedButton(
              style: Get.isDarkMode ? ElevatedButton.styleFrom(primary: Colors.black12) : ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                setState(() {
                  EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  Future<String> Stock_Code;
                  Stock_Code = query.Find_Stock_Code(searchText);
                  Stock_Code.then((val) {
                    // 종목코드가 나오면 해당 값을 출력
                    print('val: $val');
                    String sales = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Revenue' And (sj_div = 'IS' or sj_div = 'CIS');";
                    String selling = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_TotalSellingGeneralAdministrativeExpenses' And (sj_div = 'IS' or sj_div = 'CIS');";
                    String EBIT = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'dart_OperatingIncomeLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
                    String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And (sj_div = 'IS' or sj_div = 'CIS');";
                    query.Find_state_of_comprehensive_income(sales,selling,EBIT,net_income);

                    String Total_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Assets' And sj_div = 'BS';";
                    String tangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_PropertyPlantAndEquipment' And sj_div = 'BS';";
                    String intangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_IntangibleAssetsOtherThanGoodwill' And sj_div = 'BS';";
                    String cash_equivalents="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashAndCashEquivalents' And sj_div = 'BS';";
                    String total_capital="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Equity' and (sj_div ='BS' or account_detail =  '연결재무제표 [member]');";
                    String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
                    query.Find_statement_of_financial_position(Total_assets,tangible_assets,intangible_assets,cash_equivalents,total_capital,Total_Debt);

                    String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
                    String IACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInInvestingActivities' And sj_div = 'CF';";
                    String FACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM c__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInFinancingActivities' And sj_div = 'CF';";
                    query.Find_cash_flow_statemente(CFO,IACF,FACF);
                  }).catchError((error) {
                    // error가 해당 에러를 출력
                    print('error: $error');
                  });
                });
                Future.delayed(Duration(seconds: 3), () {
                  setState(() {
                    super.setState(() {
                      EasyLoading.showSuccess('Success');
                    });
                  });
                });
              },
              child: Text("연결 재무제표 검색", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(width: 10,),
            ElevatedButton(
              style: Get.isDarkMode ? ElevatedButton.styleFrom(primary: Colors.black12) : ElevatedButton.styleFrom(primary: Colors.blue),
              onPressed: () {
                setState(() {
                  EasyLoading.show(
                    status: 'loading...',
                    maskType: EasyLoadingMaskType.black,
                  );
                  Future<String> Stock_Code;
                  Stock_Code = query.Find_Stock_Code(searchText);
                  Stock_Code.then((val) {
                    // 종목코드가 나오면 해당 값을 출력
                    print('val: $val');
                    String sales = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Revenue' And sj_div = 'CIS';";
                    String selling = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'dart_TotalSellingGeneralAdministrativeExpenses' And sj_div = 'CIS';";
                    String EBIT = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'dart_OperatingIncomeLoss' And sj_div = 'CIS';";
                    String net_income = "SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_ProfitLoss' And sj_div = 'CIS' ;";
                    query.Find_state_of_comprehensive_income(sales,selling,EBIT,net_income);

                    String Total_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Assets' And sj_div = 'BS';";
                    String tangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_PropertyPlantAndEquipment' And sj_div = 'BS';";
                    String intangible_assets="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where (account_id = 'ifrs-full_IntangibleAssetsOtherThanGoodwill' or account_nm LIKE "+'"%'+"무형자산"+'%"'+") And sj_div = 'BS';";
                    String cash_equivalents="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashAndCashEquivalents' And sj_div = 'BS';";
                    String total_capital="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Equity' And sj_div = 'BS';";
                    String Total_Debt="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_Liabilities' And sj_div = 'BS';";
                    query.Find_statement_of_financial_position(Total_assets,tangible_assets,intangible_assets,cash_equivalents,total_capital,Total_Debt);

                    String CFO="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInOperatingActivities' And sj_div = 'CF';";
                    String IACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInInvestingActivities' And sj_div = 'CF';";
                    String FACF="SELECT thstrm_amount,frmtrm_amount,bfefrmtrm_amount FROM o__financialstatements.fs${val} Where account_id = 'ifrs-full_CashFlowsFromUsedInFinancingActivities' And sj_div = 'CF';";
                    query.Find_cash_flow_statemente(CFO,IACF,FACF);
                  }).catchError((error) {
                    // error가 해당 에러를 출력
                    print('error: $error');
                  });
                });
                Future.delayed(Duration(seconds: 3), () {
                  setState(() {
                    super.setState(() {
                      EasyLoading.showSuccess('Success');
                    });
                  });
                });
              },
              child: Text("별도 재무제표 검색", style: TextStyle(color: Colors.white),),
            ),
            SizedBox(width: 3,),
          ],
        ),
      ),
    );
  }
  Widget _SOCI() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        child: DataTable(
          horizontalMargin: 12.0,
          columnSpacing: 45.0,
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                '손익계산서',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2021/12',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2020/12',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2019/12',style: TextStyle(fontSize: 12),
              ),
            ),
          ],
          rows: <DataRow>[

            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['매출액', query.sales1, query.sales2, query.sales3]);
                },
                  child:
                  Text("매출액",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_sales1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_sales2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_sales3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['판매비와 관리비', query.selling1, query.selling2, query.selling3]);
                },
                  child: Text("판매비와 관리비",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_selling1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_selling2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_selling3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['영업이익', query.EBIT1, query.EBIT2, query.EBIT3]);
                },
                  child: Text("영업이익",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_EBIT1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_EBIT2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_EBIT3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['당기순이익', query.net_income1, query.net_income2, query.net_income3]);
                },
                  child: Text("당기순이익",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_net_income1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_net_income2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_net_income3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _B_Sheet() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        child:
        DataTable(
          horizontalMargin: 12.0,
          columnSpacing: 45.0,
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                '재무상태표',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2021/12',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2020/12',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2019/12',style: TextStyle(fontSize: 12),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['자산총계', query.Total_assets1, query.Total_assets2, query.Total_assets3]);
                },
                  child: Text("자산총계",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_Total_assets1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_Total_assets2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_Total_assets3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['유형자산', query.tangible_assets1, query.tangible_assets2, query.tangible_assets3]);
                },
                  child: Text("유형자산",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_tangible_assets1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_tangible_assets2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_tangible_assets3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['무형자산', query.intangible_assets1, query.intangible_assets2, query.intangible_assets3]);
                },
                  child: Text("무형자산",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_intangible_assets1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_intangible_assets2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_intangible_assets3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['현금및현금성자산', query.cash_equivalents1, query.cash_equivalents2, query.cash_equivalents3]);
                },
                  child: Text("현금및현금성자산",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_cash_equivalents1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_cash_equivalents2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_cash_equivalents3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['자본총계', query.total_capital1, query.total_capital2, query.total_capital3]);
                },
                  child: Text("자본총계",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_total_capital1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_total_capital2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_total_capital3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['부채총계', query.Total_Debt1, query.Total_Debt2, query.Total_Debt3]);
                },
                  child: Text("부채총계"),)),
                DataCell(Text(query.d_Total_Debt1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_Total_Debt2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_Total_Debt3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _SCF() {
    return Card(
      shape: RoundedRectangleBorder(  //모서리를 둥글게 하기 위해 사용
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Container(
        margin: EdgeInsets.all(5),
        child: DataTable(
          horizontalMargin: 12.0,
          columnSpacing: 43.0,
          columns: <DataColumn>[
            DataColumn(
              label: Text(
                '현금흐름표',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2021/12',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2020/12',style: TextStyle(fontSize: 12),
              ),
            ),
            DataColumn(
              label: Text(
                '2019/12',style: TextStyle(fontSize: 12),
              ),
            ),
          ],
          rows: <DataRow>[
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['영업활동현금흐름', query.CFO1, query.CFO2, query.CFO3]);
                },
                  child: Text("영업활동현금흐름",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_CFO1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_CFO2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_CFO3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['투자활동현금흐름', query.IACF1, query.IACF2, query.IACF3]);
                },
                  child: Text("투자활동현금흐름",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_IACF1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_IACF2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_IACF3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
            DataRow(
              cells: <DataCell>[
                DataCell(TextButton(onPressed: () {
                  Get.to(() => Fin_Chart(), arguments: ['재무활동현금흐름', query.FACF1, query.FACF2, query.FACF3]);
                },
                  child: Text("재무활동현금흐름",style: TextStyle(fontSize: 12)),)),
                DataCell(Text(query.d_FACF1.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_FACF2.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
                DataCell(Text(query.d_FACF3.toStringAsFixed(0).toString(),style: TextStyle(fontSize: 12))),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget build(BuildContext context) {
    return isLoading
        ? Center(child: Container(child: CircularProgressIndicator(),),)
        : ListView(
      children: [
        _Search(context),
        _SOCI(),
        _B_Sheet(),
        _SCF(),
      ],
    );
  }
  @override
// TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
