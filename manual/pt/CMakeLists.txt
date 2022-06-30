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

add_gnc_doc_targets(${docname} "${entities}")
