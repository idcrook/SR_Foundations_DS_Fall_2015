

## Original source(s)

- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## File description

``` {text}
.
├── CodeBook.Rmd    R + Markdown file 
├── CodeBook.html   Output from .Rmd
├── CodeBook.md -> CodeBook.Rmd (symlink)
├── README.md       This file
├── UCI_HAR_Dataset
│   ├── README.txt
...
│   ├── test
│   └── train
├── UCI_HAR_Dataset.zip
├── run_analysis.R     R script
├── run_analysis.Rout  Output of .R batch run
└── tidydata.Rda       Saved copy of the tidy data
```


Notes and development R code is found in the `CodeBook.Rmd` file.

### To run .R script

``` {bash}
$ R CMD BATCH ./run_analysis.R
```

