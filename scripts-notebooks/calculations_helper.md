# Carbon stocks modelling helper functions

This [stocks_helper_functions.R](stocks_helper_functions.R) is a script file containing three simple functions:

1. `interpolate_slice(data, x_val)`

1. `predict_val(data, x_val)`

1. `impute_regression(df, y_var, x_var)`

## The functions are written for implementation within a tidyverse pipe workflow.

### Example: interpolations of dry bulk density:

We start by the required libraries. For our purpose will require the, my favourite, [tidyverse](https://www.tidyverse.org/), a collection of R packages 


```







```


