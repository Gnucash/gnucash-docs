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
        ch_Finance-Quote.xml
        fdl-appendix.xml
        legal.xml
        para-assist-buttons.xml
        chartofaccts.xml
        chtacctseg.xml
        para-assist-intro.xml
        txf-categories.xml
        tips-appendix.xml)

add_gnc_doc_targets(${docname} "${entities}")
