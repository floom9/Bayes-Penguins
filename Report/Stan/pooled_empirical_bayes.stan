data {
  int<lower=0> J;  // Number of observations
  vector[J] X;  // Predictor
  vector[J] Y;  // Response
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}

model {
  // Empirical Bayes Prior
  alpha ~ normal(54.89085 , 2.567342);
  beta ~ normal(-0.6349052 , 0.1485978);
  sigma ~ cauchy(0, 5);
  
  // Likelihood
  Y ~ normal(alpha + beta * X, sigma);
}

generated quantities {
  vector[J] log_lik;
  vector[J] y_new;  // New predicted values for the same X


  for (j in 1:J) {
    log_lik[j] = normal_lpdf(Y[j] | alpha + beta * X[j], sigma);
    y_new[j] = normal_rng(alpha + beta * X[j], sigma);
  }
}
