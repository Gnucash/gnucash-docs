# Create CHM help files for Win32
# Procedure translated to cmake from make_chm() in gnucash-on-windows.git:install-impl.sh,
# originally written by Andreas Köhler.


set(chmfile "${docname}.chm")
set(mapfile "${docname}.hhmap")
set(htmlhelpdir "${CURRENT_BIN_DIR}/htmlhelp")

#string(REPLACE ";" " " xlstprocflagslst "${XSLTPROCFLAGS}")
#message(STATUS "XSLTPROCFLAGS: ${XSLTPROCFLAGS}\nxlstprocflagslst: ${xlstprocflagslst}")

set(htmlhelp_xsl "http://docbook.sourceforge.net/release/xsl/current/htmlhelp/htmlhelp.xsl")

execute_process(
    # FIXME Reusing ${XSLTPROCFLAGS} fails as xsltproc gets this as one single parameter instead of 3...
    COMMAND ${XSLTPROC} --path "${SRC_DIR}/docbook" --xinclude
                        --stringparam htmlhelp.chm ${chmfile}
                        "${SRC_DIR}/xsl/1.79.2/htmlhelp/htmlhelp.xsl"
                        "${CURRENT_SRC_DIR}/${docname}.xml"
    WORKING_DIRECTORY "${htmlhelpdir}")

file(COPY "${CURRENT_SRC_DIR}/figures" DESTINATION "${htmlhelpdir}")

set(count 0)
set(HPP "")
list(APPEND HHP "" "[ALIAS]" "IDH_0=index.html")
set(MAP "")
list(APPEND MAP "" "[MAP]" "#define IDH_0 0")
set(HHMAP "[MAP]")
message(STATUS "Searching for anchors...")

file(GLOB allhtml RELATIVE "${htmlhelpdir}" "${htmlhelpdir}/*.html")
foreach(src_xml ${entities})
    file(STRINGS "${CURRENT_SRC_DIR}/${src_xml}" sectlines REGEX "sect.*id=[\"'][^\"']*[\"']")
    foreach(sectline ${sectlines})
        string(REGEX REPLACE ".*sect.*id=[\"']([^\"']*)[\"'].*" "\\1" sectid ${sectline})
        #message(STATUS "allhtml: ${allhtml}\nsectline: ${sectline}\nsrc_xml: ${sectid}")
        unset(html_id_file)
        foreach(htmlfile ${allhtml})
            file(STRINGS "${htmlhelpdir}/${htmlfile}" searchresult REGEX "[\"']${sectid}[\"']")
            if(searchresult)
                set(html_id_file ${htmlfile})
                break()
            endif()
        endforeach()
        if(html_id_file)
            MATH(EXPR count "${count}+1")
            list(APPEND HHP "IDH_${count}=${html_id_file}#${sectid}")
            list(APPEND MAP "#define IDH_${count} ${count}")
            list(APPEND HHMAP "${sectid}=${count}")
        endif()
    endforeach()
endforeach()

set(HHP "${HHP};${MAP}")
string(REPLACE ";" "\n" HHP_OUT "${HHP}")
string(REPLACE ";" "\n" HHMAP_OUT "${HHMAP}")
file(APPEND "${htmlhelpdir}/htmlhelp.hhp" ${HHP_OUT})
file(WRITE "${BUILD_DIR}/${mapfile}" ${HHMAP_OUT})

execute_process(
    COMMAND ${HHC} htmlhelp.hhp
    WORKING_DIRECTORY "${htmlhelpdir}"
    OUTPUT_QUIET
    ERROR_QUIET
)

file(COPY "${htmlhelpdir}/${docname}.chm" DESTINATION "${BUILD_DIR}")
