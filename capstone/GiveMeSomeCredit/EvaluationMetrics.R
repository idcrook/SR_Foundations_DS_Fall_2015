mse <- function(y_hat, y) {
  mean((y_hat - y) ^ 2)
}


rmse <- function(y_hat, y) {
  sqrt(mse(y_hat, y))
}


bin_class_dev <- function(p_hat, y, tiny=1e-32) {
  if (is.factor(y)) {
    y <- as.integer(y)
  }
  
  if (is.integer(y) || is.numeric(y)) {
    y <- y - min(y)
  }
  
  - 2 * mean(y * log(p_hat + tiny) + (1 - y) * log(1 - p_hat + tiny))
}


bin_classif_eval_hard_pred <- function(hard_predictions, actuals) {
  if (is.factor(hard_predictions)) {
    hard_predictions <- as.integer(hard_predictions)
  }
  if (is.integer(hard_predictions)) {
    hard_predictions <- hard_predictions - min(hard_predictions)
  }
  
  if (is.factor(actuals)) {
    actuals <- as.integer(actuals)
  }
  if (is.integer(actuals)) {
    actuals <- actuals - min(actuals)
  }
  
  opposite_hard_predictions <- ! hard_predictions
  opposite_actuals <- ! actuals
  
  nb_samples <- length(actuals)
  nb_pos <- sum(actuals)
  nb_neg <- sum(opposite_actuals)
  nb_pred_pos <- sum(hard_predictions)
  nb_pred_neg <- sum(opposite_hard_predictions)
  nb_true_pos <- sum(hard_predictions * actuals)
  nb_true_neg <- sum(opposite_hard_predictions * opposite_actuals)
  nb_false_pos <- sum(hard_predictions * opposite_actuals)
  nb_false_neg <- sum(opposite_hard_predictions * actuals)
  
  accuracy <- (nb_true_pos + nb_true_neg) / nb_samples
  sensitivity <- nb_true_pos / nb_pos
  specificity <- nb_true_neg / nb_neg
  precision <- nb_true_pos / nb_pred_pos
  f1_score <- (2 * precision * sensitivity) / (precision + sensitivity)
  
  c(accuracy=accuracy,
    sensitivity=sensitivity,
    specificity=specificity,
    precision=precision,
    f1_score=f1_score)
}


bin_classif_eval <- function(predictions, actuals, thresholds=.5) {
  
  if (is.factor(predictions) || is.integer(predictions) || is.logical(predictions)) {
    bin_classif_eval_hard_pred(predictions, actuals)
  } else {
    
    if (length(thresholds) == 1) {
      
      hard_predictions <- predictions >= thresholds
      
      c(bin_classif_eval_hard_pred(hard_predictions, actuals),
        c(deviance=bin_class_dev(predictions, actuals)))
      
    } else {
      
      library(data.table)
      
      d <- data.table(threshold=thresholds)
      column_names <- c(
        'accuracy',
        'sensitivity',
        'specificity',
        'precision',
        'f1_score',
        'deviance'
      )
      d[, (column_names) := as.list(rep(0, times=6))]
      
      for (i in seq_along(thresholds)) {
        d[i, (column_names) := as.list(
          bin_classif_eval(predictions, actuals, thresholds=thresholds[i]))]
      }
      
      d
    }
  }
}