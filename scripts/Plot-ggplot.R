## Load packages ----
library(ggplot2)

## Read data ----
## normally you should use readr::read_csv() instead
cpl_teamtotal_2021 <- read.csv("data/CPLTeamTotals2021.csv")

## Data cleaning ----
## normally would use {dplyr} but trying to reduce dependencies just for this minimal script example...

## Select a subset of variables
select_vars <- c('ShotsTotal', 'xGPerShot', "GM", "Team", "NonPenxG", "PenTaken")
cpl_teamtotal_2021 <- cpl_teamtotal_2021[select_vars]

## Calculate non penalty variables
cpl_teamtotal_2021$NonPenShotsTotal <- cpl_teamtotal_2021$ShotsTotal - cpl_teamtotal_2021$PenTaken
cpl_teamtotal_2021$NonPenXGPerShot <- cpl_teamtotal_2021$NonPenxG / cpl_teamtotal_2021$NonPenShotsTotal
cpl_teamtotal_2021$NonPenShotsP90 <- cpl_teamtotal_2021$NonPenShotsTotal / (cpl_teamtotal_2021$GM * 90) * 90
cpl_teamtotal_2021$NonPenxGP90 <- cpl_teamtotal_2021$NonPenxG / (cpl_teamtotal_2021$GM * 90) * 90

## Plot ----
basic_plot <- ggplot(data = cpl_teamtotal_2021,
       aes(x = NonPenxGP90, y = reorder(Team, NonPenxGP90))) +
  geom_col() +
  annotate(geom = "text", x = 0.65, y = 4.5, 
           label = 'EXAMPLE', color = 'white', angle = 45, fontface = 'bold',
           size = 30, alpha = 0.5) +
  scale_x_continuous(
    expand = c(0, 0.025),
    limits = c(0, 1.5)
  ) +
  labs(
    title = "Pacific FC leads the league in expected goals for per 90...",
    subtitle = paste0("Canada Premier League 2021 Season (As of ", format(Sys.Date(), '%B %d, %Y'), ")"),
    x = "Non-Penalty xG per 90",
    y = NULL,
    caption = "Data: Centre Circle & StatsPerform\nMedia: @CanPLdata #CCdata #CanPL"
  ) +
  theme_minimal() +
  theme(axis.ticks = element_blank(),
        panel.grid.major.y = element_blank())

## Save in 'basic_plots' folder ----
ggsave(filename = paste0("basic_plots/basic_plot_", Sys.Date(), ".PNG"), plot = basic_plot)
