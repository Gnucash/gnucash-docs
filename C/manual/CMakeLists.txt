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
        chtacctseg.docbook
        chartofaccts.docbook
        legal.docbook
        txf-categories.docbook
        fdl-appendix.docbook
        tips-appendix.docbook)

set (figures
        figures/AccountReg_Screen.png
        figures/AccountTree_Screen.png
        figures/Book_Options_Accounts.png
        figures/Book_Options_Budgeting.png
        figures/Book_Options_Business.png
        figures/Book_Options_Counters.png
        figures/CSV_Import_transactions_Preview.png
        figures/CSV_Transaction_Import_Assistant.png
        figures/Choose_Export_Settings.png
        figures/Icon_Delete.png
        figures/Icon_Save.png
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
        figures/Report_Screen.png
        figures/Report_Investment_Lots_Bar.png
        figures/Report_Investment_Lots_StackedBar.png
        figures/Report_Investment_Lots.png
        figures/Tool_LotsBus.png
        figures/Tool_LotsStk.png
        figures/Tool_Lots_h_double_arrow.png
        figures/Tool_Lots_v_double_arrow.png
        figures/Trans_Assoc_Dialog.png
        figures/Trans_Assoc_Symbols.png
        figures/TxRptOpt_Screen.png
        figures/welcome-cancel.png
        figures/welcome.png
        figures/window-main-empty.png
        figures/window-tip.png
)

set (xslt_files "")

add_gnc_doc_targets(${lang} "${entities}" "${figures}" "${xslt_files}")
