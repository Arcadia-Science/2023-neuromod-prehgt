library(readr)
library(dplyr)
library(ggplot2)

# read in results and filter to HGT candidates of interest ----------------

results <- read_tsv("all_results.tsv")
results_filtered <- results %>%
  filter(method %in% c("blast", "both")) %>%         # only look at BLAST results
  filter(blast_algorithm_type %in% c("kingdom")) %>% # focus on the inter-kingdom algorithms  
  filter(blast_alien_index > 0) %>%                  # filter by alien index
  filter(blast_HGT_score != "0 likely contamination")# remove likely contaminants

# write out results
write_tsv(results_filtered, "results/results_filtered.tsv")

# count HGT candidates ------------------------------------------------------

# how many HGT candidate genes were there, excluding pleurotus?
results_filtered_no_pleurotus <- results_filtered %>%
  filter(genus != "Pleurotus")
length(unique(results_filtered_no_pleurotus$hgt_candidate))

# how many HGT candidate genes were there for pleurotus only?
results_filtered_pleurotus <- results_filtered %>%
  filter(genus == "Pleurotus")
length(unique(results_filtered_pleurotus$hgt_candidate)) 

# how many pleurotus hgt candidates came from salix?
results_filtered_pleurotus_salix <- results_filtered_pleurotus %>%
  filter(grepl(pattern = "Salix suchowensis", x = blast_donor_best_match_full_lineage))
length(unique(results_filtered_pleurotus_salix$hgt_candidate))         

# plot --------------------------------------------------------------------

p <- ggplot(results_filtered %>% filter(genus != "Pleurotus"), 
            aes(x = genus, 
                fill = blast_donor_lineage_at_hgt_taxonomy_level)) +
  geom_bar() +
  scale_x_discrete(limits = rev) +
  coord_flip() +
  theme_classic() +
  labs(fill = "Predicted donor kingdom",
       x = "Genus",
       y = "Number of candidate HGT events") +
  theme(axis.text.y = element_text(face = "italic")) +
  scale_fill_manual(values = c('#5088C5', '#F28360', '#3B9886', '#F7B846', 
                               '#7A77AB', '#F898AE', '#C6E7F4', '#F8C5C1',
                               '#B5BEA4', '#F5E4BE', '#DCBFFC', '#F5CBE4',
                               '#DA9085', '#B6C8D4')) +
  scale_y_continuous(expand = c(0, 0))

# save the plot as a pdf
pdf("figure2.pdf", width = 6, height = 4)
p
dev.off()

# session info ------------------------------------------------------------

sessionInfo()
# R version 4.2.1 (2022-06-23)
# Platform: aarch64-apple-darwin20 (64-bit)
# Running under: macOS Ventura 13.4
# 
# Matrix products: default
# LAPACK: /Library/Frameworks/R.framework/Versions/4.2-arm64/Resources/lib/libRlapack.dylib
# 
# locale:
#   [1] en_US.UTF-8/en_US.UTF-8/en_US.UTF-8/C/en_US.UTF-8/en_US.UTF-8
# 
# attached base packages:
#   [1] stats     graphics  grDevices utils     datasets  methods   base     
# 
# other attached packages:
#   [1] ggplot2_3.4.2 dplyr_1.1.1   readr_2.1.4  
# 
# loaded via a namespace (and not attached):
# [1] rstudioapi_0.14  magrittr_2.0.3   hms_1.1.2        munsell_0.5.0   
# [5] tidyselect_1.2.0 bit_4.0.5        colorspace_2.1-0 R6_2.5.1        
# [9] rlang_1.1.0      fansi_1.0.4      tools_4.2.1      grid_4.2.1      
# [13] parallel_4.2.1   gtable_0.3.3     vroom_1.6.1      utf8_1.2.3      
# [17] cli_3.6.1        withr_2.5.0      ellipsis_0.3.2   bit64_4.0.5     
# [21] tibble_3.2.1     lifecycle_1.0.3  crayon_1.5.2     tzdb_0.3.0      
# [25] vctrs_0.6.1      glue_1.6.2       compiler_4.2.1   pillar_1.9.0    
# [29] scales_1.2.1     generics_0.1.3   pkgconfig_2.0.3 
