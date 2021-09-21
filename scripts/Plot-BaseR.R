cpl_teamtotal_2021 <- read.csv("data/CPLTeamTotals2021.csv")

select_vars <- c('ShotsTotal', 'xGPerShot', "GM", "Team", "NonPenxG", "PenTaken")

cpl_teamtotal_2021 <- cpl_teamtotal_2021[select_vars]

cpl_teamtotal_2021$NonPenShotsTotal <- cpl_teamtotal_2021$ShotsTotal - cpl_teamtotal_2021$PenTaken
cpl_teamtotal_2021$NonPenXGPerShot <- cpl_teamtotal_2021$NonPenxG / cpl_teamtotal_2021$NonPenShotsTotal
cpl_teamtotal_2021$NonPenShotsP90 <- cpl_teamtotal_2021$NonPenShotsTotal / (cpl_teamtotal_2021$GM * 90) * 90
cpl_teamtotal_2021$NonPenxGP90 <- cpl_teamtotal_2021$NonPenxG / (cpl_teamtotal_2021$GM * 90) * 90

# barplot
bar_df <- cpl_teamtotal_2021[order(cpl_teamtotal_2021$NonPenxGP90, decreasing = FALSE),]

barplot(height = bar_df$NonPenxGP90, names = bar_df$Team , 
        density = 10, angle = 45, 
        col = "red2", horiz = TRUE , las = 1,
        xlab = "Non-Penalty xG per 90")

# plot.new()
# plot.window(xlim = c(1, 8), ylim = range(bar_df$NonPenxGP90))
# par(mar = c(0, 10, 0 , 0))
# rect(bar_df$NonPenxGP90 - 4, 0, bar_df$NonPenxGP90 + 4, bar_df$Team)

title(main = "Non-Penalty xG per 90", 
      adj = 0, col.main = "red2")
mtext(side = 3, line = 0.25, at = 1, adj = -2, text = "Canada Premier League: 2021 Season")

axis(1, lwd = 0, las = 1, cex.axis = 0.7, font.axis = 2)
