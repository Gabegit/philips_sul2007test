# manage the penn data ----------------------------------------------------------------

library(XLConnect)
setwd("E:/data/pwt71_07262012version")
wb111=read.csv("pwt71_w_country_names.csv")
v=c(2,3,23)
y=wb111[,v]
head(y)

yy=na.omit(y) #delete the missing obs

#way from stackoverflow:Remove rows of a data set belonging to a factor of specified length
lens=tapply(yy$year,yy$isocode,function(x) length(unique(x)))
yy2=yy[yy$isocode %in% names(lens)[lens==41], ] # 41=1970-2010
# another way also from above
tab <- table(yy$isocode)==41
yy3=yy[yy$isocode %in% names(tab)[tab], ]

library(foreign)
write.dta(y,"test-balanced.dta")

# transform the balanced panel data ---------------------------------------
## the dta is a balanced papel data via stata transformation

library(foreign)
ybal=read.dta("test-balanced.dta")
y1=matrix(ybal[,3],nrow=41,byrow=FALSE)
na=as.factor(ybal$isocode)
nam=levels(na)

y2=ybal[,1]
unique(y2)
na2=y2[!duplicated(y2)]
levels(na2)
namm=c("AFG","AGO","ALB","ARG","ATG","AUS","AUT","BDI","BEL","BEN","BFA",
       "BGD","BGR","BHR","BHS","BLZ","BMU","BOL","BRA","BRB","BRN","BTN",
       "BWA","CAF","CAN","CH2","CHE","CHL","CHN","CIV","CMR","COG","COL",
       "COM","CPV","CRI","CUB","CYP","DJI","DMA","DNK","DOM","DZA","ECU",
       "EGY","ESP","ETH","FIN","FJI","FRA","FSM","GAB","GBR","GER","GHA",
       "GIN","GMB","GNB","GNQ","GRC","GRD","GTM","GUY","HKG","HND","HTI",
       "HUN","IDN","IND","IRL","IRN","IRQ","ISL","ISR","ITA","JAM","JOR",
       "JPN","KEN","KHM","KIR","KNA","KOR","LAO","LBN","LBR","LCA","LKA",
       "LSO","LUX","MAC","MAR","MDG","MDV","MEX","MHL","MLI","MLT","MNG",
       "MOZ","MRT","MUS","MWI","MYS","NAM","NER","NGA","NIC","NLD","NOR",
       "NPL","NZL","OMN","PAK","PAN","PER","PHL","PLW","PNG","POL","PRI",
       "PRT","PRY","ROM","RWA","SDN","SEN","SGP","SLB","SLE","SLV","SOM",
       "STP","SUR","SWE","SWZ","SYC","SYR","TCD","TGO","THA","TON","TTO",
       "TUN","TUR","TWN","TZA","UGA","URY","USA","VCT","VEN","VNM","VUT",
       "WSM","ZAF","ZAR","ZMB","ZWE")
names(y1)=namm
write.csv(y1,"test-balanced.csv")