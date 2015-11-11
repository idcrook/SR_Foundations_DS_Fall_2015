#!/bin/bash -x

# script to run some imagemagick commands for 


# join the RF gain and lift  charts side-by-side
convert +append rf_gain.png rf2_gain.png both_rf_gain.png
convert +append rf_lift.png rf2_lift.png both_rf_lift.png


# join the logreg gain and lift charts side-by-side
convert +append logreg_gain.png logreg2_gain.png both_logreg_gain.png
convert +append logreg_lift.png logreg2_lift.png both_logreg_lift.png

