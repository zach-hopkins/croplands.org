## Global Food Security-Support Analysis Data

[![Build Status](https://travis-ci.org/justinwp/croplands-web.svg)](https://travis-ci.org/justinwp/croplands-web) [![Coverage Status](https://coveralls.io/repos/justinwp/croplands-web/badge.svg)](https://coveralls.io/r/justinwp/croplands-web)

### Global Croplands Project
The GFSAD30 is a NASA funded project to provide high resolution global cropland data and their water use that
contributes towards global food security in the twenty-first century. The GFSAD30 products are derived through
multi-sensor remote sensing data (e.g., Landsat, MODIS, AVHRR), secondary data, and field-plot data and aims at
documenting cropland dynamics from 1990 to 2017. [USGS](http://geography.wr.usgs.gov/science/croplands/)

### Web Application
This is a [web application](https://croplands.org) for visualizing and interacting with the training and validation
data. The application lives on an Amazon S3 bucket with a Cloudfront layer in front of the bucket.

### The Developers
The web application was originally created by [Justin Poehnelt](https://github.com/justinwp).  Justin left the project
in September 2016.  Currently, the project is handled by [Corryn Smith](https://github.com/clsmit8703) and [Tyler Thatcher](https://github.com/tthatcher95).




### Other
See the companion api at [github.com/croplands-dev/croplands_API](https://github.com/croplands-dev/croplands_API).


### Docker Run Command

```
docker pull justinwp/croplands-web:latest
docker run --net=host --env-file ./config.env -d -p 8000:8000 --restart=always  --name croplands-web justinwp/croplands-web:latest
```
