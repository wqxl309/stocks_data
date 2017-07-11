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
    if isnan(swcode)
        industry_codes(dumi,1) = str2double(stkcd(1:6));
        industry_codes(dumi,2) = str2double(lasttrd);
        industry_codes(dumi,3:end)= NaN;
        continue;
    else
        swcodes = strsplit(swcode,'-');
    end
    if length(swcodes)<3
        display([stkcd '''s swcodes is wrong'])
    else
        industry_codes(dumi,1) = str2double(stkcd(1:6));
        industry_codes(dumi,2) = str2double(lasttrd);
        industry_codes(dumi,3) = str2double(swcodes{1});
        industry_codes(dumi,4) = str2double(swcodes{2});
        industry_codes(dumi,5) = str2double(swcodes{3});
        display([stkcd '''s swcodes updated'])
    end
end