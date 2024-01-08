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
        chtacctseg.docbook
        chartofaccts.docbook
        legal.docbook
        txf-categories.docbook
        fdl-appendix.docbook
        tips-appendix.docbook)

set (figures
        figures/AccountReg_Screen.png
        figures/AccountTree_Screen.png
        figures/Main-window-callouts.png
        figures/Pref_AccntPeriod.png
        figures/Pref_Accnts.png
        figures/Pref_Business.png
        figures/Pref_DateTime.png
        figures/Pref_General.png
        figures/Pref_OnlineBanking.png
        figures/Pref_Printing.png
        figures/Pref_Register.png
        figures/Pref_RegisterDefaults.png
        figures/Pref_Reports.png
        figures/Pref_Sched.png
        figures/Pref_Windows.png
        figures/Report_Screen.png
        figures/TxRptOpt_Screen.png
        figures/icons/split_transaction.png
)

set (xslt_files "")

add_gnc_doc_targets(${lang} "${entities}" "${figures}" "${xslt_files}")
