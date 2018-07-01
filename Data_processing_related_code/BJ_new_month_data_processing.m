clear
tic
%BJ=readtable('bj_meteorology_2018-03-04-12_clean.csv');
%BJ=readtable('beijing_201802_201804_me.csv');%%%��������������
%BJ=readtable('bj_meo_2018-04-30-05-11.csv');%%%��������������
BJ=readtable('bj_meo_2018-05-11-20.csv');%%%��������������
toc

tic
temp_station_id=table2cell(BJ(1,1)); %��ʼ����һ�����ڷ����staion_id
BJ_data=cell(10,8,17);%��ʼ����άԪ������, ע���һ��λ�õ�ֵҪ����һ�£���ÿ��Ԫ��������
BJ_num=1;%վ����Ŀ
j=1;%��¼ѭ����ÿ����άԪ�����������к�
for i = 1:size(BJ,1)
      if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
      end
      if isequal(temp_station_id, table2cell(BJ(i,1)))
           BJ_data(j,1:8,BJ_num)=table2cell(BJ(i,1:8));
           j=j+1;
      else
           temp_station_id=table2cell(BJ(i,1));
           BJ_num=BJ_num + 1;
           BJ_data(1,1:8,BJ_num)=table2cell(BJ(i,1:8));
           j=2;
      end
end
toc

%%����������վ�ľ�γ�Ȱ���վ�㸴�Ƶ�BJ_data��ÿһ���ӱ�����

% tic
% BJ_new=BJ_data(:,:,1);
% for j=2:BJ_num
%        j     
%     BJ_new=cat(1,BJ_new,BJ_data(:,:,j));
% end
% 
% toc

%%�������۲�վ�����Ƽ��뵽BJ_data��ĵ�8,9��
[d,e,f]=xlsread('station_meo');%��������۲�վ�ľ�γ������
for i=1:size(BJ_data,3)
   
     BJ_data(1:size(BJ_data(:,:,i),1),9:10,i)=repmat(f(i+1,2:3),size(BJ_data(:,:,i),1),1);
    
end

tic
BJ_new=BJ_data(:,:,1);
for j=2:BJ_num
       j     
    BJ_new=cat(1,BJ_new,BJ_data(:,:,j));
end

toc

%%%�������о�γ�ȵı���4�·����ݱ�
BJ_new=cell2table(BJ_new);
BJ_new = BJ_new(:,[1 9 2:8 end]);
BJ_new = BJ_new(:,[1:2 10 3:9]);
BJ_new = BJ_new(:,[1:4 6:10 5]);

tic
%writetable(BJ_new,'BJ_new_month_data_with_location.csv','Delimiter',',','QuoteStrings',true)
writetable(BJ_new,'bj_meo_2018-05-11-20_with_location_weather.csv','Delimiter',',','QuoteStrings',true)
toc

%%% ������ع�ϵ�����5�ű��

%%% ʪ�ȣ��¶�

BJ_humidity=BJ_new;
BJ_humidity=cell2table(BJ_humidity);


BJ_humidity(:,{'BJ_humidity6','BJ_humidity7'}) = [];
BJ_humidity(:,'BJ_humidity4') = [];
BJ_humidity = BJ_humidity(:,[1 5 2:4 end]);
BJ_humidity = BJ_humidity(:,[1:2 6 3:5]);
toc

%%% ѹǿ���¶ȣ�����

BJ_pressure=BJ_new;
BJ_pressure=cell2table(BJ_pressure);

BJ_pressure = BJ_pressure(:,[1 8 2:7 end]);
BJ_pressure = BJ_pressure(:,[1:2 9 3:8]);
BJ_pressure(:,'BJ_pressure7') = [];
BJ_pressure(:,'BJ_pressure5') = [];
BJ_pressure = BJ_pressure(:,[1:5 7 6]);

tic
writetable(BJ_pressure,'BJ_pressure_new_month.csv','Delimiter',',','QuoteStrings',true)
toc

%%% �¶ȣ�ѹǿ��ʪ��

BJ_new=BJ_new;
BJ_new=cell2table(BJ_new);
BJ_new = BJ_new(:,[1 8 2:7 end]);
BJ_new = BJ_new(:,[1:2 9 3:8]);
BJ_new(:,{'BJ_temperature6','BJ_temperature7'}) = [];
BJ_new = BJ_new(:,[1:4 6:7 5]);

tic
writetable(BJ_new,'BJ_temperature_new_month.csv','Delimiter',',','QuoteStrings',true)
toc

%%% ����ѹǿ

BJ_winddirection=BJ_new;
BJ_winddirection=cell2table(BJ_winddirection);
BJ_winddirection = BJ_winddirection(:,[1 8 2:7 end]);
BJ_winddirection = BJ_winddirection(:,[1:2 9 3:8]);
BJ_winddirection(:,'BJ_winddirection6') = [];
BJ_winddirection(:,'BJ_winddirection5') = [];
BJ_winddirection(:,'BJ_winddirection3') = [];

tic
writetable(BJ_winddirection,'BJ_winddirection_new_month.csv','Delimiter',',','QuoteStrings',true)
toc

%%% ���٣��¶ȣ�ѹǿ

BJ_windspeed=BJ_new;
BJ_windspeed=cell2table(BJ_windspeed);
BJ_windspeed = BJ_windspeed(:,[1 8 2:7 end]);
BJ_windspeed = BJ_windspeed(:,[1:2 9 3:8]);
BJ_windspeed(:,'BJ_windspeed5') = [];
BJ_windspeed(:,'BJ_windspeed7') = [];

tic
writetable(BJ_windspeed,'BJ_windspeed_new_month.csv','Delimiter',',','QuoteStrings',true)
toc