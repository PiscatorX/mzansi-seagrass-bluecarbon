# Carbon stocks modelling helper functions

This [stocks_helper_functions.R](stocks_helper_functions.R) is a script file containing three simple functions:

1. **Function Name:** `interpolate_slice`
   1. **Signature:** `interpolate_slice(data, x_val)`

1. **Function Name:** `predict_val`
   1. **Signature:** `predict_val(data, x_val)`

1. **Function Name:** `impute_regression`
   1. **Signature:** `impute_regression(df, y_var, x_var)`

## The functions are written for implementation within a tidyverse pipe workflow.

### Example: interpolations of dry bulk density:

We start by the required libraries. Four our purpose will require the, my favourite, [tidyverse](https://www.tidyverse.org/), a collection of R packages 


```







```


