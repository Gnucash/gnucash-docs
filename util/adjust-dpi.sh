#! /bin/bash
# make a list file of all the png figures
ls *.png > list

for figure in $(cat list);
do
  # get width in pixels of the figure              1 inch = 2,54 centimeters
  width=$(identify -format "%w" "$figure")
  if [ "$width" -lt 496 ]; then
    # width is less than 90x14cm/2,54
    dpi=90
  else
    if [ "$width" -gt 793 ]; then
      # width is more than 144x14cm/2,54
      # set the new dpi to function of the image size
      # use awk to round to 0 decimals (note awk, bc + identify ignore
      #  locale decimal separator and use ".")
      dpi=$(echo "scale=8; $width*2.54/14" | bc | awk '{ printf("%.0f",$1); }' )
    else
      # width between 496px and 793px
      dpi=144
    fi
  fi
  # convert dpi from pixelsperinch to pixelspercentimeter
  #  Note: bc truncates to scale decimals so use awk to round to 2 decimals
  dpi_cm=$(echo "scale=8; $dpi/2.54" | bc | awk '{ printf("%.2f",$1); }')
  # get the existing dpi from figure as XX PixelsPerCentimeter
  existing_dpi=$(identify -format "%x" "$figure")
  # some vers of identify suffix the returned dpi with " PixelsPerCentimeter"
  #  and/or do not round the return value of identify -format "%x"
  existing_dpi=$( echo "$existing_dpi" | awk '{ printf("%.2f",$1); }')
  # set the future dpi figure to XX.XX (PixelsPerCentimeter)
  future_dpi="$dpi_cm"
  # apply new dpi only if it's changed from the existing by more than 0.02
  abs_diffx100=$( echo "scale=4; ($existing_dpi - $future_dpi) * 100" | bc | tr -d - | awk '{ printf("%.0f",$1); }')
  if [ "$abs_diffx100" -gt 2 ]; then	# really .02
    convert -units PixelsPerInch -density "$dpi" "$figure" "$figure"
    echo "File $figure PixelsPerCentimeter converted from $existing_dpi to $future_dpi (dpi=$dpi)"
  fi
done
rm list
echo "Done!"
