set (entities
        Help_ch_Intro.xml
        Help_ch_GettingHelp.xml
        Help_ch_GettingStarted.xml
        Help_ch_GUIMenus.xml
        Help_ch_Account-Actions.xml
        Help_ch_Transactions.xml
        Help_ch_Business.xml
        Help_ch_Tools_Assistants.xml
        Help_ch_Reports.xml
        Help_ch_Customize.xml
        ch_Finance-Quote.xml
        Help_chtacctseg.xml
        Help_chartofaccts.xml
        Help_legal.xml
        Help_txf-categories.xml
        Help_fdl-appendix.xml
        Help_tips-appendix.xml)

add_gnc_doc_targets(${docname} "${entities}")
