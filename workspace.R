library(tercen)
library(dplyr, warn.conflicts = FALSE)
library(reshape2)

#BiocManager::install("remotes")
#BiocManager::install("sararselitsky/FastPG")
library(FastPG)

options("tercen.workflowId" = "64fb41765904c84540e45f1e1800fcb8")
options("tercen.stepId"     = "6ab261c5-acf9-46f5-84ac-9c64302f4323")

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
membership_label <-sprintf(paste0("c%0", max(nchar(as.character(membership_num))), "d"), membership_num)
modularity_num <- clusters$modularity

data.frame(.ci = seq(from = 0, to = length(membership_num) - 1), membership_num, membership_label, modularity_num) %>%
  ctx$addNamespace() %>%
  ctx$save()