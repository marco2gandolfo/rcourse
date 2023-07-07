library(tidyverse)
library(ggplot2)


mylinebarplot <- function(data, x, y, group) { 
  ggplot(data, aes({{x}}, {{y}}, fill = {{x}}, color = {{x}})) +
  stat_summary(geom = "bar", position = position_dodge(), fun = "mean", color = "black", size = 1.8, alpha = 0.6) +
  stat_summary(geom = "errorbar", position = position_dodge(0.9), color = "black", fun.data = "mean_se", size = 1.8, width = 0.5) +
  geom_line(aes(group = {{group}}),color = 'black', alpha = 0.3) +
  geom_point(aes(group = {{group}}, shape = {{x}}),  size = 3, alpha = 0.3) + 
  scale_y_continuous(expand = expand_scale(mult = c(0, .4))) +
  theme_classic() + 
  geom_hline(yintercept = 0, size = 1.8) +  
  scale_fill_brewer(palette = "Dark2") + 
  scale_color_brewer(palette = "Dark2") +  
  theme(strip.text.x = element_text(size = 32, color = "black", face = "bold"), strip.text.y = element_text(size = 32, color = "black", face = "bold"),
        strip.background = element_blank(),axis.title.x = element_blank(),axis.text.x = element_text(size = 28, color = "black", face = "plain"), 
        axis.title.y = element_text(size = 28, face = "bold"), axis.text.y = element_text(size = 24, color = "black", face = "plain"),
        legend.text = element_text(size = 28, face = "bold"),legend.title = element_blank(),legend.position = "right", strip.placement = "outside",
        plot.margin=unit(c(1,1,1,1), "cm"),axis.ticks.x = element_blank(), axis.line = element_line(color = "black", size = 1.5), axis.ticks = element_line(color = "black", size = 1.5), 
        plot.title = element_text(size = 28, colour = "black", face = "bold", hjust = 0.5))
}

mylinebarplot(prova, x = hemisphere, y = difference, group = subject) + facet_wrap(~Site)

