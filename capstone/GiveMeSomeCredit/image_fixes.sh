#!/bin/bash -x

# script to run some imagemagick commands for chart combining

# needs to be re-run each time the original charts are updated


# Resize the model variable importance plots
convert -resize 40% varImp1a.png varImp1a_resized.png
convert -resize 40% varImp2a.png varImp2a_resized.png


# join the RF gain and lift  charts side-by-side
convert +append rf_gain.png rf2_gain.png both_rf_gain.png
convert +append rf_lift.png rf2_lift.png both_rf_lift.png

# join the logreg gain and lift charts side-by-side
convert +append logreg_gain.png logreg2_gain.png both_logreg_gain.png
convert +append logreg_lift.png logreg2_lift.png both_logreg_lift.png

# join the CART gain and lift charts side-by-side
convert +append cart_gain.png cart2_gain.png both_cart_gain.png
convert +append cart_lift.png cart2_lift.png both_cart_lift.png

# combine and resize ROC plots
#convert +append ROC1a.png ROC2a.png both_ROC.png
#convert -resize 80% both_ROC.png  both_ROC_resized.png

# resize feature discrimination plot grouping

convert -resize 60% feature_bucketed_discr.png feature_bucketed_discr_resized.png
