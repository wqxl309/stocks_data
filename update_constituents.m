clc;
clear;

indices = {'000300.SH','000905.SH','000016.SH'};

load('index_constituents.mat');
load('last_update_date.mat');

w = windmatlab;
if last_update_date==0
    startdate = 0;
else
    startdate = w.tdaysoffset(1,last_update_date);
end
enddate = datestr(today,'yyyy/mm/dd');
nextdate = w.tdaysoffset(1,enddate);
if month(nextdate)==month(enddate)
    enddate = datestr(w.tdaysoffset(-1,num2str(year(enddate)*10000+month(enddate)*100+1),'Days=Alldays'),'yyyymmdd');
end
if startdate<=enddate
    for dumi = 1:length(indices)
        index = indices{dumi};
        constdata = index_constituent(index,startdate,enddate);
        dataname = ['const_' index(1:6)];
        last_constdata = evalin('base',dataname);
        newfields = fieldnames(constdata);
        for dumj = 1:length(newfields)
            field = newfields{dumj};
            last_constdata.(field) = constdata.(field);
        end
        assignin('base',dataname,last_constdata);
        save('index_constituents.mat',dataname,'-append');
        display([index ' updated!']);
    end
    last_update_date = enddate;
    save('last_update_date.mat','last_update_date');
else
    display('No data to update');
end


%% ¾É¸ñÊ½×ª»»
% datanames = {'const_000016','const_000300','const_000905'};
% 
% for dumi = 1:length(datanames)
%     dataname = datanames{dumi};
%     constdata = evalin('base',dataname);
%     fields = fieldnames(constdata);
%     new_constdata = struct;
%     for dumj = 1:length(fields)
%         field = fields{dumj};
%         data = constdata.(field);
%         newdata = trans_constdata(data);
%         new_constdata.(field) = newdata;
%     end
%     assignin('base',dataname,new_constdata);
%     save('index_constituents.mat',dataname,'-append');
% end








