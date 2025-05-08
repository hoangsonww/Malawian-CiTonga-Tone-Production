library(ggplot2)

# I) Experiment A

# 1. Load the data
df <- read.csv("citonga.csv")
head(df)
# Columns: # Tonga, Gloss, Tone, C1, C2, maxf0, minf0, meanf0, diff.f0, intensity, duration
# Tone꞉ tone of the verb stem (H or L)
# meanf0꞉ average pitch of the vowel of the stem (measured in Hz)
# C1꞉ the first consonant in the verb stem
# C1.class꞉ the class of the first consonant in the verb stem

# 2. Visualize the difference between the measurements of the H tone following 
# a C1.class of sonorants and voiced obstruents by creating boxplots of the groups

# Filter to only H tones and the two C1 classes
df_H <- subset(df, Tone == "H" & (C1.class == "sonorants" | C1.class == "voiced obstruents"))

# Create boxplot
ggplot(df_H, aes(x = C1.class, y = meanf0)) +
  geom_boxplot() +
  labs(
    title = "Mean F0 of H Tone by C1 Class",
    x = "C1 Class",
    y = "Mean F0"
  ) +
  theme_minimal()
# Based on the box plots, we can see a significant difference between the pitch
# of the H tones between Sonorants and Voiced Obstruents (MeanF0 of Sonorants is higher).

# 3. t‑test to determine whether there is a significant difference
# between the mean f0 of the H tones following a C1.class of Sonorants and Voiced Obstruents
sonorants_H <- subset(df, Tone == "H" & C1.class == "sonorants")$meanf0
voicedObs_H  <- subset(df, Tone == "H" & C1.class == "voiced obstruents")$meanf0

t.test(x = sonorants_H, y = voicedObs_H, var.equal = TRUE)
# Result: t = 5.1426, df = 23, p-value = 3.278e-05
# The p-value is less than 0.05, indicating a significant difference between the two groups.

# 4. Conclusions can a linguist make about Malawian CiTonga based on these findings:
# Conclusion 1: The mean F0 of H tones in Malawian CiTonga is significantly higher
# following sonorants than voiced obstruents
# Conclusion 2: There is a significant difference in the pitch of H tones based on the C1 class

# II) Experiment B

# 5. Visualize the tone following these individual sounds when they are C1 before a H tone 
# and before a L tone:
# voiced obstruents are a list of (b, d, j, g, v, z)
voiced_obs <- subset(df, C1 == "b" | C1 == "d" | C1 == "j" | C1 == "g" | C1 == "v" | C1 == "z")

ggplot(voiced_obs, aes(x = C1, y = meanf0, fill = Tone)) +
  geom_boxplot() +
  labs(
    title = "Mean F0 by Individual Voiced Obstruent (C1) and Tone",
    x = "Voiced Obstruent (C1)",
    y = "Mean F0"
  ) +
  theme_minimal()
# Based on the box plots, we can see that the mean F0 of L tones seems to be
# consistently higher than that of H tones across all voiced obstruents.

# 6. t‑test to determine whether there is a significant difference:
# between the mean f0 of the H tones and L tones following each voiced obstruent

# Aggregate to get mean F0 per token by Tone
aggregate(meanf0 ~ Tone, data = df, mean)
H_vo <- subset(df, Tone == "H")$meanf0
L_vo <- subset(df, Tone == "L")$meanf0

t.test(H_vo, L_vo, var.equal = TRUE)
# Result: t = -5.4622, df = 153, p-value = 1.864e-07
# Yes, there is a significant difference between the mean F0 of H and L tones following voiced obstruents.

# 7. Conclusions can a linguist make about Malawian CiTonga based on these findings:
# Conclusion 1: The low p‑value shows that after voiced obstruents, 
# H tones have a significantly lower mean F0 than L tones, which is the opposite 
# of what we’d expect if the contrast were neutralized.
# Conclusion 2: My answer to #5 seems to be correct, as the box plots show that the mean F0 of L 
# tones is consistently higher than that of H tones.
# Follow up Q: What's the reason behind this? And how does this affect the tonal system of Malawian CiTonga?
