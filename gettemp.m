%function gettemp takes in the lat and long of interest and pulls the data
%from the inputted .txt temp grid file for the given lat and long for the
%number of months requested - note that in this function you cannot request
%processing of a particular month's data. 
%
%lat = 0.5 + n where n is an integer and lat goes from -89.5 to 89.5
%long = 0.5 + n where n is an integer and long goes from -179.5 to 179.5
%month = scalar number of months (12 months in a year...)
%
%example - deg = gettemp(9.5,90.5,60) returns vector deg with 60 months
%(5 yrs) worth of temperature data from lat/long 9.5 N and 90.5 E, this
%data can be further processed in processtemp to produce figures of
%seasonal and monthly temperature trends

function [deg] = gettemp(lat,long,month,txt)
%fid = fopen('HADISST - 1870-2011.txt');  %open the file (.txt)
%S = fscanf(fid,'%c');   %scan the file into S - long string
%txt = regexp(S,'[\f\n\r]','split'); %turn into cell array of lines of file

%note that 1+181n where n is a positive integer represents a header line

temp = ones(20,1)*-99999; %temperature matrix for lat long
%deg = zeros(month,1);

%ri = row index, represents starting row for next temp matrix
ri = 1;

k = 1; %initialize k, represents # data entry in vector temp

%add while loop until end of document
%while ri+180<size(txt,2)

for n = 1:month
    r = 90.5-lat+ri;    %row correspond to lat
    
    %tstr = temp string
    tstr = txt{r};
    %tstr = [tstr '                      '];  %so no out of bounds err
    
    %ci = column index, goes until no more text in column
    ci = 1;
    
    %c is column of interest (should go 0-360) in matrix
    c = 1;
    lo2col = long+180.5;
    
    while c < lo2col+1  %column of interest hasn't been reached
          if str2double(tstr(ci:ci+8)) == -11763790
              temp(c) = -32768;
              c = c+1;
          else
            temp(c) = str2double(tstr(ci:ci+5));
            ci = ci+6;
            c = c+1;
          end
    end
deg(n) = temp(c-1);

ri = ri+181;    %go to corresponding row in next month's matrix
end

return

