
data {
  int<lower=0> N;         // Number of observations
  int<lower=0> J;         // Number of groups
  int<lower=1, upper=J> group[N];  // Group indicator for each observation
  vector[N] X;            // Predictor variable (bill_depth)
  vector[N] Y;            // Response variable (bill_length)
}

parameters {
  vector[J] alpha;
  vector[J] beta;
  real<lower=0> sigma;
  real<lower=0> sigma_alpha;
  real<lower=0> sigma_beta;
}

model {
  alpha[1]~normal(38.82397	, 2.662597 );
  alpha[2] ~ normal(48.83382, 3.339256);
  alpha[3]~normal(47.56807	, 3.106116);
  beta~normal(0,5);
  sigma ~ cauchy(0, 5);
  // Likelihood
  for (i in 1:N) {
    Y[i] ~ normal(alpha[group[i]] + beta[group[i]] * X[i], sigma);
  }
}

generated quantities {
  vector[N] log_lik;
  vector[N] y_new;  // New predicted values for the same X


  for (j in 1:N) {
    log_lik[j] = normal_lpdf(Y[j] | alpha[group[j]] + beta[group[j]] * X[j], sigma);
    y_new[j] = normal_rng(alpha[group[j]] + beta[group[j]] * X[j], sigma);
  }
}
