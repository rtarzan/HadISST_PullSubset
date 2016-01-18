%Function processtemp calls function gettemp to obtain the temperature data
%called for by the function, and then plots the temperature for the desired
%month/season and location over the specified year range. Data are from the
%txt files of Hadley temperature data. The temperatures provided in the txt
%file are formatted in monthly grids of absolute temperatures and the
%temperatures are converted in this function to anomalies based on the
%long-term averages of the temperature data.
%
%Usage - month is an integer 1-17. 1-12 correspond to the 12 months of the
%year and 13-17 correspond to the season/annual data where
%           13 = spring         14 = summer
%           15 = fall           16 = winter
%           17 = annual
%        startyr indicates the start date at which the timeseries is to be
%        plotted, a year between 1870 and 2010
%        endyr indicates the last date at which the timeseries is to be
%        plotted, a year between 1871 and 2011
%        lat is the latitude - between -90 and 90 in form of 0.5 + n
%        long is longitude - between -180 and 180 in form of 0.5 + n
%        txt is the cell array of temperature data that can be accessed
%        with a properly formatted file and the following three lines of
%        code: 
%fid = fopen('Hadley.txt');  %open the file (.txt)
%S = fscanf(fid,'%c');   %scan the file into S - long string
%txt = regexp(S,'[\f\n\r]','split'); %turn into cell array of lines of file
%        name is the name of the dataset, will be printed in the graph
%        title
%
%Usage example - processtemp(12,1880,2011,0.5,0.5,'Data 1') 
%plots the december temperatures from 1880-2011 at location 0.5 N 0.5 E

function [yrs,ATemp] = processtemp( month,startyr,endyr,lat,long,txt,name )

%deg = gettemp(lat,long,12*(2013-1870+1),txt);
deg = gettemp(lat,long,1725,txt);
deg(1726:1728) = zeros([1,3]);
%moseq = zeros(endyr-1870+1);
yr = 1869;
if month < 13
    %the first number in the matrix corresponds to January 1870
    mindex = month;
    ct = 1;
    while mindex < length(deg)
        if deg(mindex) ~= -32768 && deg(mindex) ~= -1000
            moseq(ct) = deg(mindex);
            mindex = mindex +12;
            yrs(ct) = yr+ct;
            ct = ct+1;
        elseif deg(mindex) == -32768
            moseq(ct) = NaN; %marks land squares
            mindex = mindex+12;
            yrs(ct) = yr+ct;
            ct = ct+1;
        elseif deg(mindex) == -1000
            moseq(ct) = NaN; %marks ice-covered squares
            mindex = mindex+12;
            yrs(ct) = yr+ct;
            ct = ct+1;
        end
    end
    if month == 1
        mt = 'January';
    elseif month == 2
        mt = 'February';
    elseif month == 3
        mt = 'March';
    elseif month == 4
        mt = 'April';
    elseif month == 5
        mt = 'May';
    elseif month == 6
        mt = 'June';
    elseif month == 7
        mt = 'July';
    elseif month == 8
        mt = 'August';
    elseif month == 9
        mt = 'September';
    elseif month == 10
        mt = 'October';
    elseif month == 11
        mt = 'November';
    elseif month == 12
        mt = 'December';
    end
elseif month == 13
    mindex = 3;
    ct = 1;
    
    while mindex < length(deg)
        if deg(mindex) ~= -32768 && deg(mindex+1) ~= -32768 && deg(mindex+2) ~= -32768
       moseq(ct) = (deg(mindex)+deg(mindex+1)+deg(mindex+2))/3;
       mindex = mindex +12;
       yrs(ct) = yr+ct;
       ct = ct+1;
        else
            mindex = mindex+12;
            ct = ct+1;
        end
    end
    
    mt = 'Spring';
elseif month == 14
    mindex = 6;
    ct = 1;
     while mindex < length(deg)
        if deg(mindex) ~= -32768 && deg(mindex+1) ~= -32768 && deg(mindex+2) ~= -32768
       moseq(ct) = (deg(mindex)+deg(mindex+1)+deg(mindex+2))/3;
       mindex = mindex +12;
       yrs(ct) = yr+ct;
       ct = ct+1;
        else
            mindex = mindex+12;
            ct = ct+1;
        end
    end
    mt = 'Summer';
elseif month == 15
    mindex = 9;
    ct = 1;
    
    while mindex < length(deg)
        if deg(mindex) ~= -32768 && deg(mindex+1) ~= -32768 && deg(mindex+2) ~= -32768
       moseq(ct) = (deg(mindex)+deg(mindex+1)+deg(mindex+2))/3;
       mindex = mindex +12;
       yrs(ct) = yr+ct;
       ct = ct+1;
        else
            mindex = mindex+12;
            ct = ct+1;
        end
    end
    
    mt = 'Fall';
elseif month == 16
    mindex = 12;
    ct = 1;
    while mindex < length(deg)
        if deg(mindex) ~= -32768 && deg(mindex+1) ~= -32768 && deg(mindex+2) ~= -32768
       moseq(ct) = (deg(mindex)+deg(mindex+1)+deg(mindex+2))/3;
       mindex = mindex +12;
       yrs(ct) = yr+ct;
       ct = ct+1;
        else
            mindex = mindex+12;
            ct = ct+1;
        end
    end
    mt = 'Winter';
elseif month == 17
    mindex = 1;
    ct = 1;
    
    while mindex < length(deg)
        if deg(mindex) ~= -32768 && deg(mindex+1) ~= -32768 && deg(mindex+2) ~= -32768 && deg(mindex+3) ~= -32768 && deg(mindex+4) ~= -32768 && deg(mindex+5) ~= -32768 && deg(mindex+6) ~= -32768 && deg(mindex+7) ~= -32768 && deg(mindex+8) ~= -32768 && deg(mindex+9) ~= -32768 && deg(mindex+10) ~= -32768 && deg(mindex+11) ~= -32768
       moseq(ct) = (deg(mindex)+deg(mindex+1)+deg(mindex+2)+deg(mindex+3)...
           +deg(mindex+4)+deg(mindex+5)+deg(mindex+6)+deg(mindex+7)...
           +deg(mindex+8)+deg(mindex+9)+deg(mindex+10)+deg(mindex+11))/12;
       mindex = mindex +12;
       yrs(ct) = yr+ct;
       ct = ct+1;
        else
            mindex = mindex+12;
            ct = ct+1;
        end
    end
    mt = 'Annual';
end

%convert from absolute temperatures to temperature anomalies
%mave = sum(moseq)/length(moseq);
%tempanom = moseq - ones(size(moseq))*mave;
%plot(yrs,moseq/100,'-b.','LineWidth',3);
%str = [mt ' Temperature at ' num2str(lat) ', ' num2str(long) ' from '...
    %num2str(startyr) ' - ' num2str(endyr) ' '];
%title({name,str},'FontSize',16);
%xlabel('Year','FontSize',15);
%ylabel('Temperature (C)','FontSize',14);
%set(gca,'XLim',[startyr endyr]);

% subplot(2,1,2)
% plot(yrs,tempanom/100,'-b.','LineWidth',3);
% str = [mt ' Temperature Anomaly at ' num2str(lat) ', '...
%     num2str(long) ' from ' num2str(startyr) ' - ' num2str(endyr) ' '];
% title({name,str},'FontSize',15);
% xlabel('Year','FontSize',14);
% ylabel('Temperature Anomaly (C)','FontSize',14);
% set(gca,'XLim',[startyr endyr]);

% TAnom = tempanom/100;
ATemp = moseq/100;

return

