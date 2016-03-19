#! /bin/bash
# make a list file of all the png figures
ls *.png > list

for figure in `cat list`;
do
# read width in pixel for the figure
width=$(identify -format "%w" "$figure")
# if the width is less than 90x14cm/2,54
if [ "$width" -lt 496 ]; then
  dpi=90
  # convert dpi from pixelsperinch to pixelspercentimeter
  dpi_cm=$(echo "scale=2; $dpi/2.54" | bc)
  # read the existing dpi from figure as XX PixelsPerCentimeter
  existing_dpi=$(identify -format "%x" "$figure")
  # set the future dpi of figure as XX PixelsPerCentimeter
  future_dpi="$dpi_cm PixelsPerCentimeter"
  # apply new dpi only if it's changed from the existing
  if [ "$existing_dpi" != "$future_dpi" ]; then
    convert -units PixelsPerInch -density "$dpi" "$figure" "$figure"
    echo "File $figure converted to $dpi dpi"
  fi
# if the width is more than 144x14cm/2,54
else
  if [ "$width" -gt 793 ]; then
    # set the new dpi in function of the image size
    dpi=$(echo "scale=0; $width*2.54/14" | bc)
    # convert dpi from pixelsperinch to pixelspercentimeter
    dpi_cm=$(echo "scale=2; $dpi/2.54" | bc)
    # read the existing dpi from figure as XX PixelsPerCentimeter
    existing_dpi=$(identify -format "%x" "$figure")
    # set the future dpi of figure as XX PixelsPerCentimeter
    future_dpi="$dpi_cm PixelsPerCentimeter"
    # apply new dpi only if it's changed from the existing
    if [ "$existing_dpi" != "$future_dpi" ]; then
      convert -units PixelsPerInch -density "$dpi" "$figure" "$figure"
      echo "File $figure converted to $dpi dpi"
    fi
# for figures with width between 496px and 793px use a dpi of 144
  else
    dpi=144
    # convert dpi from pixelsperinch to pixelspercentimeter
    dpi_cm=$(echo "scale=2; $dpi/2.54" | bc)
    # read the existing dpi from figure as XX PixelsPerCentimeter
    existing_dpi=$(identify -format "%x" "$figure")
    # set the future dpi of figure as XX PixelsPerCentimeter
    future_dpi="$dpi_cm PixelsPerCentimeter"
    # apply new dpi only if it's changed from the existing
    if [ "$existing_dpi" != "$future_dpi" ]; then
      convert -units PixelsPerInch -density 144 "$figure" "$figure"
      echo "File $figure converted to 144 dpi"
    fi
  fi
fi
done
rm list
echo "Done!"
