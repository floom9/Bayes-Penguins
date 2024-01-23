data {
  int<lower=0> J;  // Number of observations
  vector[J] X;  // Predictor
  vector[J] Y;  // Response
}

parameters {
  real chatgpt_mean;
  real chatgpt_sd;
  real alpha;
  real beta;
  real<lower=0> sigma;
}

model {
  // Non Informative priors
  alpha ~ normal(chatgpt_mean, chatgpt_sd);
  beta ~ normal(1,0.5);
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
