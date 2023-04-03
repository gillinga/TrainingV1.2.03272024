#install packages
library(tidyverse) #install.packages("tidyverse")
library(readxl) #install.packages("readxl")
library(readr) #install.packages("readr")
library(here) #install.packages("here")
library(dplyr) #install.packages("dplyr")
library(ggtern) #install.packages("ggtern")
library(here) #install.packages("here")
options(dplyr.summarise.inform=F)

#upload lobster data, remember to use "read_xlsx", not "read.xlsx"
lobsters <- read_xlsx(here("data/lobsters.xlsx"), skip=4)

pivot_plot <- lobsters %>% group_by("Site"=site, "Year"=year) %>% summarize("Mean"=mean(size_mm, na.rm=T)) 

graph_base <- ggplot(data=pivot_plot, aes(x=Year, y=Mean, color=Site))

graph_base + geom_line(aes(color=Site))+labs(y="Mean Size (mm)", title="Mean Lobster Size by Site", subtitle="(2012 - 2016)")

ggsave(here("figures", "mean_size_line.jpg"), dpi=180, width=8, height=7)

graph_base2 <- graph_base+labs(y="Mean Size (mm)", title="Mean Lobster Size by Site", subtitle="(2012 - 2016)")

graph_base2 + geom_line()
graph_base2 + geom_col(aes(fill=Site))+facet_wrap(~Site)+theme(axis.text.x=element_text(angle=90))
ggsave(here("figures", "mean_size_col_wrap.jpg"), dpi=180, width=8, height=7)

