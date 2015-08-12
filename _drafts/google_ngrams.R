if(!require(rvest)){
  install.packages("rvest")
}
library(stringr)

Sys.setenv(http_proxy="http.boe.bankofengland.co.uk:8080");

term = 'Germany';
start = 1800;
end = 2000;
corpus = 'eng_2012';

url = sprintf("https://books.google.com/ngrams/graph?content=%s&year_start=%i&year_end=%i&corpus=%s&smoothing=0",
              term,
              start,
              end,
              corpus);

download_folder <- "C://dev//DataLab"
tempFileName = "temp.html";
localPath = paste0(download_folder,tempFileName)

download.file(url,localPath)

html <- html(localPath)
rawtext = html_text(html);

pattern = 'var data = \\[.*"timeseries": \\[(.*)\\], "parent'
regexpresult = str_match(rawtext,pattern);
group = regexpresult[[1,2]]

years = seq(start,end)
dataVector = t(read.table(text=group, sep=',',colClasses = 'numeric'))
rownames(dataVector) = NULL

output = as.data.frame(cbind(years,dataVector));
colnames(output) = c("year",term);

plot(output,type = 'l')

file.remove(localPath);

