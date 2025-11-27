# exam 2013, q1

# 1.1) use the formula from 6.8 theorm:

n=109
n_ev=6
geo_mean= 0.22461
avg= 0.10749

# insert in forumla

n*log((geo_mean)^(n_ev)/(avg)^(n_ev))

# check with all solutions to see which one matches.
-n*6*(log(0.10749)-log(0.22461)) # 

# 1.2) use the formula from theorem 6.8

k=7 # 7 eigenvalues in total
n_small=6# we test for the 6 smallest
m=k-n_small # we test the smallest 6 of theses -> m=7-6= 1

df_total= 0.5*(k-m+2)*(k-m-1)  # insert into the formula for the DFs
df_total

# 1.3) we do not have the data so we go look in the tables in the exam appendix

# test all the statements

# A) The factor basically represents the mean level of all stations

# holt is small (0.27) compared to the rest so no!

# B) The factor basically represents the mean level of all stations east of the power plant

# stations easts of power plants: (all but ager) - no ager is also high!

# C) The factor basically represents a contrast between the measurements west and east of the power plant

# no there is no sign difference

# D) The factor basically represents the mean level of all stations except the one closest to the power plant
# yes as holt is small (for factor 1)

# E) The factor basically represents the mean level at the station closest to the power pl
# yes as holt is large (for factor 2) as the only one!


# 1.4) look at variance explained by each factor:

# we know that since we use the correlation (type corr in sas) that V(X)=1, so

# (4.9643460+1.3730299)/7=0.905339

# 1.5) What fraction of the variation at the station closest to the power plant (holt) is explained by the first VARIMAX rotated factor

# this is equvient to the squared corr from the factors:
# 0.27020^2 =0.073





