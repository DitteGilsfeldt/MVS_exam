library(readr)
dat=read_delim("C:/Users/dasth/Downloads/reflexes.cor.csv", 
               delim = ";", escape_double = FALSE, trim_ws = TRUE)

dat[] <- lapply(dat, function(x) gsub(",", ".", x))
dat[] <- lapply(dat, function(x) {
  if (is.character(x)) as.numeric(gsub(",", ".", x)) else x
})

cor_mat=dat[,-1]

# 1.1) given the correlation matrix (not the acutal data!) we wish to find required number of PCs

eig <- eigen(cor_mat)$values # eigenvalues

cum_var <- cumsum(eig) / sum(eig)

cum_var>0.90 # so 4 comps is needed to be higher than 90 %


# 1.2) find the degrees of freedom for eigenvalue significance test: teorem 6.8.

k=length(eig) # 10 eigenvalues in total
m=3 # we test the smallest 7 of theses -> m=10-7= 3

df_total= 0.5*(k-m+2)*(k-m-1)  # insert into the formula for the DFs

# 1.3) lets construct our PCs from the eigen command!

eig <- eigen(cor_mat) # Remeber that the following decompostion applies for R (cor_matrix) R=QΛQ^T, with Q=eigenvalues and Λ= eigenvalues

eig$values # eigenvalues
eig$vector # eigenvectors

# make a small loadings table from the eigenvectors

loading_table <- data.frame(
  Loadings = eig$vectors
  
)
# name it so its easy to read
rownames(loading_table)=names(cor_mat)

loading_table # we see comp 8 has the highest loadings for AnkR and AnkL (-0.709 and 0.702) -> even opppiste signs to caputre diff!

# 1.4 ) we have the correlation matrix and works from there!
library(psych)
fa_res <- principal(cor_mat,nfactors = 3)  # do the factor analysis

# extract commu
commu <- fa_res$communality
commu

# 1.5)  maximal correlation between the right wrist reflex and a rotated factor

fa_res$loadings # to make it easier to read name the rows
rownames(fa_res$loadings)=names(cor_mat)
fa_res$loading # 0.857 is the maximum

# 1.6) lets look at the options

# 1) Rotated factor 1 is mainly an average of the arm reflexes, rotated factor 2 the average of the knee reflexes, and rotated factor 3 the average of the ankle reflexe

fa_res$loading # fa1 mostly arm (tri, bi and wri), fa2 (high only in kne), fa3 (high only in ankel)

# 2) Unrotated factor 1 is basically the overall average, unrotated factor 2 is a contrast between the arm and the leg reflexes, and unrotated factor 3 is the average ankle refl
fa_res <- principal(cor_mat,nfactors = 3, rotate = "none")  # do the factor analysis (none = unrotated)

rownames(fa_res$loadings)=names(cor_mat)

fa_res$loadings # fa1 overall average - ok ish, fa2 ok (opp signs), fa3 no here knee is also high

# 3) Rotated factor 1 is basically the overall average, rotated factor 2 is a contrast between knee and ankle reflexes, and rotated factor 3 is the average of the ankle reflexe
fa_res <- principal(cor_mat,nfactors = 3)  # do the factor analysis
rownames(fa_res$loadings)=names(cor_mat)
fa_res$loading # fa1 overall avg - no!, fa2 contrast between knee and ankle reflexes - no!, fa3 yes

# 4) The unrotated factor 3 show the differences between the left and the right refl measurements.

fa_res <- principal(cor_mat,nfactors = 3, rotate = "none")  # do the factor analysis (none = unrotated)

rownames(fa_res$loadings)=names(cor_mat)

fa_res$loadings # fa3 no! signs are not oppiste between all L and R

# 5)  Unrotated factor 1 is an overall average, unrotated factor 2 is the average leg reflex, and unrotated factor 3 is a contrast between the leg and the arm reflexe
fa_res$loadings # Fa1 overall avg - ok! , fa2 ok! , fa3 no! (signs are not - and + in each category)


