data {
  int<lower=1> N; // Number of observations
  int<lower=1> S; // Number of species
  int<lower=1> G; // Number of genders (sexes)
  vector[N] X; // Bill depth measurements
  vector[N] Y; // Bill length measurements
  int<lower=1,upper=S> species_id[N]; // Species index for each observation
  int<lower=1,upper=G> sex_id[N]; // Sex index for each observation
}

parameters {
  // Population-level intercepts
  real alpha;
  // Population-level slope
  real beta;
  
  // Species-level adjustments
  vector[S] alpha_species;
  vector[S] beta_species;
  
  // Sex-level adjustments
  vector[G] alpha_sex;
  vector[G] beta_sex;
  
  // Standard deviations
  real<lower=0> sigma_species;
  real<lower=0> sigma_sex;
  real<lower=0> sigma_obs; // Standard deviation of observations
}

transformed parameters {
  vector[N] mu;
  
  for (n in 1:N) {
    mu[n] = alpha + alpha_species[species_id[n]] + alpha_sex[sex_id[n]] +
      (beta + beta_species[species_id[n]] + beta_sex[sex_id[n]]) * X[n];
  }
}

model {
  // Priors
  alpha ~ normal(31.73067 , 1.486399);
  beta ~ normal(0.6114413 ,0.1312772 );
  alpha_species ~ normal(0, sigma_species);
  beta_species ~ normal(0, sigma_species);
  alpha_sex ~ normal(0, sigma_sex);
  beta_sex ~ normal(0, sigma_sex);
  sigma_species ~ cauchy(0.5459231, 0.3861264);
  sigma_sex ~ cauchy(0.3676995 , 0.3097724 );
  sigma_obs ~ cauchy(2.24937, 0.0863137);
  
  // Likelihood
  Y ~ normal(mu, sigma_obs);
}

generated quantities {
  vector[N] log_lik;
  vector[N] y_new;
  for (n in 1:N) {
    log_lik[n] = normal_lpdf(Y[n] | mu[n], sigma_obs);
    y_new[n] = normal_rng(mu[n], sigma_obs);
  }
}
