


## Submitted


- [tidy data set [format = .Rda]](https://github.com/idcrook/SR_Foundations_DS_Fall_2015/blob/master/part4_data_wrangling/project/tidydata.Rda?raw=true)
- [github repos path](https://github.com/idcrook/SR_Foundations_DS_Fall_2015/tree/master/part4_data_wrangling/project)
- [CodeBook [format = .Rmd]](https://github.com/idcrook/SR_Foundations_DS_Fall_2015/blob/master/part4_data_wrangling/project/CodeBook.Rmd)  output: [CodeBook.html](http://github.crookster.org/SR_Foundations_DS_Fall_2015/part4_data_wrangling/project/CodeBook.html) 


Notes and development R code is found in the `CodeBook.Rmd` file.


## File description

``` {text}
.
├── CodeBook.Rmd    R + Markdown file 
├── CodeBook.html   Output from .Rmd
├── CodeBook.md -> CodeBook.Rmd (symlink)
├── README.md       This file
├── UCI_HAR_Dataset     <-\ 
│   ├── README.txt        -  Input  
...                       -  Data
│   ├── test              -  Sources
│   └── train             - 
├── UCI_HAR_Dataset.zip   /
├── run_analysis.R     R script
├── run_analysis.Rout  Output of .R batch run
└── tidydata.Rda       Saved copy of the tidy data
```



### To run .R script

``` {bash}
$ R CMD BATCH ./run_analysis.R
```


## Original source(s)

- http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
