set (entities
        Help_ch_Intro.xml
        Help_ch_GettingStarted.xml
        Help_fdl-appendix.xml
        Help_legal.xml
        Help_chartofaccts.xml
        Help_chtacctseg.xml
        Help_txf-categories.xml
        Help_tips-appendix.xml)

add_gnc_doc_targets(${docname} "${entities}")
