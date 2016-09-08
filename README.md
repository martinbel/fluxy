fluxy
=====

InfluxDB client

## Install

Development version from GitHub


```r
devtools::install_github("sckott/fluxy")
```


```r
library("fluxy")
```

## initialize a client


```r
(cli <- flux())
```

```
## <fluxy client>
##   host: 127.0.0.1
##   port: 8086
##   scheme: http
```

## show databases


```r
cli$db_show()
```

```
## $results
##                                                             series
## 1 databases, name, _internal, mydb, farts, tables, stuff, thoughts
```

## Meta

Please note that this project is released with a [Contributor Code of Conduct](CONDUCT.md). By participating in this project you agree to abide by its terms.
