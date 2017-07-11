function[newdata]=trans_constdata(data)
if iscell(data)
    date = str2num(datestr(data(:,1),'yyyymmdd'));
    code = cell2mat(data(:,2));
    if strcmp(code(end,:),'T00018.SH')
        code(end,:) = '600018.SH';
    end
    newdata = [date str2num(code(:,1:6)) cell2mat(data(:,4))];
else
    newdata = data;
end