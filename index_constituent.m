function[constdata] = index_constituent(index,startdate,enddate)
w = windmatlab;
if w.isconnected()
    display('Wind connected successfully !');
else
    display('Wind connected faied !');
end

if startdate==0
    ipodict = [{'000001.SH','19901219'};{'000300.SH','20050104'};{'000905.SH','20050104'};{'000016.SH','20040102'}];
    for dumi=1:length(ipodict)
        if strcmp(ipodict{dumi,1},index)
            ipodate = ipodict{dumi,2};
            break;
        end
    end
    startdate = ipodate;
end
if enddate==0
    enddate = datestr(today(),'yyyymmdd');
end

dates = w.tdays(startdate,enddate,'Period=M');
datenum = length(dates);

constdata = struct();
for dumi=1:datenum
    date = dates{dumi};
    id = ['M' num2str(year(date)*100+month(date))];
    [data,~,~,~,~,~] = w.wset('IndexConstituent',['date=' date],['windcode=' index]);
    newdata = trans_constdata(data);
    constdata.(id) = newdata;
end