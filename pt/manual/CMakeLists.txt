set (entities
        ch_Intro.xml
        ch_GettingHelp.xml
        ch_GettingStarted.xml
        ch_GUIMenus.xml
        ch_Account-Actions.xml
        ch_Transactions.xml
        ch_Business.xml
        ch_Tools_Assistants.xml
        ch_Reports.xml
        ch_Customize.xml
        chtacctseg.xml
        chartofaccts.xml
        legal.xml
        txf-categories.xml
        fdl-appendix.xml
        tips-appendix.xml)

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
