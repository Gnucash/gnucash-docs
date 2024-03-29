set (entities
        ch_Intro.docbook
        ch_GettingHelp.docbook
        ch_GettingStarted.docbook
        ch_GUIMenus.docbook
        ch_Account-Actions.docbook
        ch_Transactions.docbook
        ch_Business.docbook
        ch_Tools_Assistants.docbook
        ch_Reports.docbook
        ch_Customize.docbook
        ch_Finance-Quote.docbook
        fdl-appendix.docbook
        legal.docbook
        para-assist-buttons.docbook
        chartofaccts.docbook
        chtacctseg.docbook
        para-assist-intro.docbook
        txf-categories.docbook
        tips-appendix.docbook)

set (figures
        figures/AccountReg_Screen.png
        figures/AccountTreeCascade.png
        figures/AccountTreeCreate.png
        figures/AccountTree_Export_CSV.png
        figures/AccountTree_Export_dbms.png
        figures/AccountTree_Export_file.png
        figures/AccountTree_Import_CSV.png
        figures/AccountTree_Import_CSV_Preview.png
        figures/AccountTree_Screen.png
        figures/AcctCreate_General.png
        figures/AcctCreate_OpenBal.png
        figures/AcctViewOptions-0.png
        figures/AcctViewOptions-1.png
        figures/Book_Options_Accounts.png
        figures/Book_Options_Budgeting.png
        figures/Book_Options_Business.png
        figures/Book_Options_Counters.png
        figures/Book_Options_Tax.png
        figures/Budget_Screen.png
        figures/CSV_Import_transactions_Preview.png
        figures/CSV_Transaction_Import_Assistant.png
        figures/Choose_Export_Settings.png
        figures/GUI_Business_Invoice.png
        figures/GUI_Business_Overview.png
        figures/Import_Map_Editor.png
        figures/Import_MatchPicker.png
        figures/Import_QIF_Druid.png
        figures/Import_Transaction_matcher_1.png
        figures/Main-window-callouts.png
        figures/Pref_AccntPeriod.png
        figures/Pref_Accnts.png
        figures/Pref_Business.png
        figures/Pref_DateTime.png
        figures/Pref_General.png
        figures/Pref_Import.png
        figures/Pref_OnlineBanking.png
        figures/Pref_Printing.png
        figures/Pref_Quotes.png
        figures/Pref_Register.png
        figures/Pref_RegisterDefaults.png
        figures/Pref_Reports.png
        figures/Pref_Sched.png
        figures/Pref_Windows.png
        figures/Reconcile_Screen.png
        figures/Report_Screen.png
        figures/Reset_Warnings.png
        figures/Scheduled_Transactions.png
        figures/Style_Choose.png
        figures/Style_New.png
        figures/Tool_LotsBus.png
        figures/Tool_LotsStk.png
        figures/Tool_Lots_h_double_arrow.png
        figures/Tool_Lots_v_double_arrow.png
        figures/Tools_CloseBook.png
        figures/Tools_Find_bsnss.png
        figures/Tools_Find_bsnss_result.png
        figures/Tools_Find_txn.png
        figures/Tools_PriceDatabase.png
        figures/Tools_PriceEditor_add.png
        figures/Tools_PriceEditor_del.png
        figures/Tools_SecurityEditor.png
        figures/Tools_SecurityEditor_add.png
        figures/Tools_SecurityEditor_edit.png
        figures/Tools_SinceLastRun.png
        figures/Trans_Assoc_Dialog.png
        figures/Trans_Assoc_Symbols.png
        figures/TxRptOpt_Screen.png
        figures/chart_acct_delete_01.png
        figures/chart_acct_delete_02.png
        figures/chart_acct_delete_03.png
        figures/chart_acct_delete_msg.png
        figures/column-selector-0.png
        figures/column-selector-1.png
        figures/splash.png
        figures/summarybar-selector-1.png
        figures/summarybar-selector-2.png
        figures/tip-window.png
        figures/welcome-cancel.png
        figures/welcome.png
        figures/window-main-empty.png
)

set (xslt_files "")

add_gnc_doc_targets(${lang} "${entities}" "${figures}" "${xslt_files}")
