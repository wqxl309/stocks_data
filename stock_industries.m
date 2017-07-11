function[industry_codes]=stock_industries(stkinfomat)
w = windmatlab;
if w.isconnected()
    display('Wind connected successfully !');
else
    display('Wind connected faied !');
end

load(stkinfomat)
stknum = length(stkinfo);
last_trddates = w.wss(stkinfo(:,1),'lastradeday_s');
industry_codes = zeros(stknum,5);
for dumi = 1:stknum
    stkcd = stkinfo{dumi,1};
    lasttrd = datestr(last_trddates{dumi},'yyyymmdd');
    swcode = cell2mat(w.wss(stkcd,'industry_swcode',['tradeDate=' lasttrd],'industryType=4'));
    industry_codes(dumi,1) = str2double(stkcd(1:6));
    industry_codes(dumi,2) = str2double(lasttrd);
    if isnan(swcode) 
        industry_codes(dumi,3:end)= NaN;
        continue;
    else
        swcodes = strsplit(swcode,'-');
        for dumk = 1:length(swcodes)
            industry_codes(dumi,2+dumk) = str2double(swcodes{dumk});
        end
        display([stkcd '''s swcodes updated'])
    end
end