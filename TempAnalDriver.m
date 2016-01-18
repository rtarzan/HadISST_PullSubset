% Example of a script to pull the HadISST temperature data for all the locations in a proxy excel spreadsheet

[num,name] = xlsread('ProxyLocations2.xls');
Lat = num(:,1);
Long = num(:,2);
Month = num(:,3);

for gr = 1:length(Lat)
   figure(gr)
   st = name{gr};
   [yrs,ATemp,TAnom] = processtemp(Month(gr),1880,2011,Lat(gr),Long(gr),txt,st);
   A = [yrs' ATemp' TAnom'];
   xlswrite(st,A);
end

