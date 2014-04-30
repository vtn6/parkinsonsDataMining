library(plyr)
library(ggplot2)
library(gplots)

rm(list = ls())
setwd("~/Dropbox//ORIE 4740 - Final Project/heatPlot/")
ppmi.raw.data = read.csv("pichu.csv",header=TRUE)

#when we include 4:66 we get an errorr message that the std is 0
ppmi.data = ppmi.raw.data[,c(4:64)]

cor.ppmi = cor(ppmi.data,use = "pairwise.complete.obs")

heatmap.2(cor.ppmi)
# ppmi.data = as.matrix(ppmi.data)
# 
# heatmap.2( ppmi.data,
#            col = colorpanel(100,"red","yellow","green"),
#            margins = c(12, 22),
#            trace = "none", 
#            xlab = "Comparison",
#            lhei = c(2, 8),
#            scale = c("none"),
#            symbreaks = min(ppmi.data, na.rm=TRUE),
#            na.color="blue",
#            cexRow = 0.5, cexCol = 0.7,
#            main = "ppmi Testr", 
#            dendrogram = "row", 
#            Colv = FALSE )

# Test Code ---------------------------------------------------------------

# library(gplots)
# mat = matrix( rnorm(25), 5, 5)
# mat[c(1,6,8,11,15,20,22,24)] = NA
# 
# mat = as.m

#mat = as.matrix(ppmi.data)

# heatmap.2( mat,
#            col = colorpanel(100,"red","yellow","green"),
#            margins = c(12, 22),
#            trace = "none", 
#            xlab = "Comparison",
#            lhei = c(2, 8),
#            scale = c("none"),
#            symbreaks = min(mat, na.rm=TRUE),
#            na.color="blue",
#            cexRow = 0.5, cexCol = 0.7,
#            main = "DE genes", 
#            dendrogram = "row", 
#            Colv = FALSE )


# foo testing -------------------------------------------------------------
# rm(list = ls())
# a = c(1,2,3)
# b = c(14,5,6)
# c = c(1,2,3)
# foo1 = data.frame(a,b,c)
# 
# #foo1[c(1),c(1:3)] = NA
# 
# foo1 = as.matrix(foo1)
# heatmap.2(foo1)

# 
# heatmap.2( foo1,
#            col = colorpanel(100,"red","yellow","green"),
#            margins = c(12, 22),
#            trace = "none", 
#            xlab = "Comparison",
#            lhei = c(2, 8),
#            scale = c("none"),
#            symbreaks = min(foo1, na.rm=TRUE),
#            na.color="blue",
#            cexRow = 0.5, cexCol = 0.7,
#            main = "foo1 Testr", 
#            dendrogram = "row", 
#            Colv = FALSE )
# generating fake data ----------------------------------------------------

