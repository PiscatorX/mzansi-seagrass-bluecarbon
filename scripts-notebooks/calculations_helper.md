---

# 📦 Regression-Based Prediction & Imputation Helpers

A set of **tidyverse-friendly** functions for regression-based prediction, interpolation, and imputation.
Designed to drop right into a `mutate()` pipeline without exposing low-level implementation details.

---

## ✨ Functions

### `predict_val(data, x_val)`

Predict a **single value** from a fitted regression using a two-column dataset.

```r
predict_val(data, x_val)
```

**Arguments:**

* **`data`** – Two-column data frame or tibble, where the first column is `x` and the second is `y`.
* **`x_val`** – Numeric value (scalar) to predict for.

**Returns:**
Numeric prediction from a simple linear regression.

**Example in pipeline:**

```r
library(dplyr)

df <- tibble(
  dist = c(2, 4, 6, 8),
  speed = c(1, 3, 5, 7)
)

df %>%
  summarise(pred_5 = predict_val(select(cur_data(), dist, speed), 5))
#> pred_5 = 5
```

---

### `impute_regression(df, y_var, x_var)`

Impute missing values in a column using linear regression on another column.

```r
impute_regression(df, y_var, x_var)
```

**Arguments:**

* **`df`** – Data frame or tibble.
* **`y_var`** – Unquoted name of the dependent variable.
* **`x_var`** – Unquoted name of the independent variable.

**Returns:**
Numeric vector with missing values in `y_var` filled.

**Example in mutate:**

```r
df <- tibble(
  height = c(150, 160, NA, 180, NA),
  age    = c(10, 12, 13, 15, 16)
)

df %>%
  mutate(height = impute_regression(cur_data(), height, age))
```

---

### `interpolate_slice(data, x_val)`

Predict or interpolate a value **but avoid extrapolation above the maximum observed `x`**.

```r
interpolate_slice(data, x_val)
```

**Arguments:**

* **`data`** – Two-column data frame (`x`, `y`).
* **`x_val`** – Numeric value to interpolate.

**Returns:**
Predicted numeric value, or `NA` if:

* `x_val` is `NA`
* No complete `(x, y)` pairs
* `x_val` is greater than the max observed `x`

**Example in mutate:**

```r
df <- tibble(
  time = c(1, 2, 3, 4),
  value = c(10, 20, 30, 40)
)

df %>%
  mutate(pred_2_5 = interpolate_slice(select(cur_data(), time, value), 2.5))
```

---

## 🧩 Workflow Example

```r
library(dplyr)

measurements <- tibble(
  temp = c(15, 20, NA, 25, NA),
  day  = c(1, 2, 3, 4, 5)
)

measurements %>%
  mutate(
    temp_filled = impute_regression(cur_data(), temp, day),
    pred_day3   = interpolate_slice(select(cur_data(), day, temp_filled), 3)
  )
```

---



## 📜 Notes

* Fully **pipe-friendly**: pass `cur_data()` inside `mutate()` to supply the current data frame.
* Uses **tidyselect-style** column naming — no quotes needed.
* Consistent output types: always returns numeric or `NA_real_`.
* Internal regression fitting logic is hidden, keeping your code declarative.