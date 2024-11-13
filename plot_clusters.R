# Add headers in the first column of the file
""" sed -i '1i X\tY\tCategory' q2_data.tsv """
# Std.in file - q2_data.tsv
""":r! cat q2_data.tsv | head -n 10 | sed 's/^/\/\/ /' """ 
 X	Y	Category
-1118	1.27553239271999	Cl1
-1117	1.27696343296042	Cl1
-1116	1.27829211888462	Cl1
-1115	1.27953030556019	Cl1
-1114	1.28067189848055	Cl1
-1113	1.28170721322425	Cl1
-1112	1.28264434797129	Cl1
-1111	1.28348705960928	Cl1
-1110	1.28422232426115	Cl1

#!/usr/bin/env Rscript

# Load necessary libraries
library(ggplot2)
library(readr)

# Read command-line arguments
args <- commandArgs(trailingOnly = TRUE)
if (length(args) != 4) {
  stop("Usage: Rscript plot_clusters.R <output.png> <x-axis-label> <y-axis-label> <plot-title>")
}

output_file <- args[1]    
x_label <- args[2]       
y_label <- args[3]        
plot_title <- args[4]     

# Read data from standard input
data <- read_tsv(file("stdin"))

# Check if required columns are present
if (!all(c("X", "Y", "Category") %in% colnames(data))) {
  stop("Input data must contain columns named 'X', 'Y', and 'Category'")
}

# Create the line plot with ggplot2
plot <- ggplot(data, aes(x = X, y = Y, color = Category, group = Category)) +
  geom_line() +
  labs(x = x_label, y = y_label, title = plot_title, color = "Category") +
  theme_minimal()

# Save the plot to the specified output file
ggsave("different_clusters.png", plot, width = 8, height = 6)

"""
Final Command - 
cat q2_data.tsv | Rscript plot_clusters.R "different_clusters.png" "Relative from center [bp]" "Enrichment over Mean" "MNase fragment profile"
"""
