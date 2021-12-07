library(tercen)
library(dplyr, warn.conflicts = FALSE)
library(reshape2)

#BiocManager::install("remotes")
#BiocManager::install("sararselitsky/FastPG")
library(FastPG)


ctx <- tercenCtx()

data <- ctx  %>% 
  select(.ci, .ri, .y) %>% 
  reshape2::acast(.ci ~ .ri, value.var = '.y', fill = NaN, fun.aggregate = mean) 

colnames(data) <- paste('c', colnames(data), sep = '')

k <- 30
if(!is.null(ctx$op.value('k'))) k <- as.numeric(ctx$op.value('k'))

seed <- NULL
if(!ctx$op.value('seed') < 0) seed <- as.integer(ctx$op.value('seed'))

set.seed(seed)

num_threads<-1

clusters <- fastCluster( data, k, num_threads )

membership_num <- as.numeric(clusters$communities)
cluster_id <-sprintf(paste0("c%0", max(nchar(as.character(membership_num))), "d"), membership_num)
#modularity_num <- clusters$modularity

data.frame(.ci = seq(from = 0, to = length(cluster_id) - 1), cluster_id) %>% #, membership_label, modularity_num) %>%
  ctx$addNamespace() %>%
  ctx$save()