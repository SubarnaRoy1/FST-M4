-- Load input file from HDFS
inputFile = LOAD 'hdfs:///user/subarna/file01.txt' AS (line);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage
grpd = GROUP words BY word;
-- Count the occurence of eachord (Reduce)
cntd = FOREACH grpd GENERATE group, COUNT(words);
-- Store the result in HDF
STORE cntd INTO 'hdfs:///user/subarna/results';