clear;
tic
[a,b,c]=xlsread('meo_170106_16');%��������վ�ľ�γ�����ꡢ���ٷ��������
y=readtable('beijing_17_01_18_05-20_aq.csv');%���뱱����ʷ�����������ݣ�����NO2��CO��SO2
aqi_time_index=table2cell(unique(y(:,2)));
x=readtable('beijing_17_01_18_05-20_meo_with_weather.csv');%���뱱����ʷ�������ݣ���������
x=table2cell(x);
meo_time_index=unique(x(:,4));%��ȡΨһ��utc_timeʱ���
toc

k=1;
g=1;
j=1;
tic
aqi_utc_time=x(2,4);%��ʼ����һ��ƥ���utc_time
L=cell(18,11,100);%����8782��18�У�11�е�Ԫ�����ݣ�ע������Ҫ�����������У��У�Ԫ��������
for i=2:size(x,1) %��17-18�������۲�վ���ݱ�����ÿһ�����趨��utc_time����ƥ��
    if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
    end
    if strcmp(cell2mat(x(i,4)),cell2mat(aqi_utc_time)) %������е�4�е�utc_time��Ԥ���趨�õ�utc_timeƥ���ϣ���ִ�����²���
        L(j,1:10,k)=x(i,1:10); %��ʱ���ƥ���ϵļ�¼���Ƶ���k��Ԫ����������Ǽ�¼�����ǲ�ͬ��������utc_time,station��
        j=j+1;%��¼ѭ����������������ÿ��Ԫ�����Ǵӵ�һ�п�ʼȻ�󵽵�ʮ���У�����j���ڿ��Ƹ��Ƶļ�¼��Ԫ�������е�λ��
    else %���ƥ�䲻��
        %L(i-1,1:10,k)=x(i,1:10);
        aqi_utc_time=x(i,4);%���ƥ�䲻�ϣ�������ǰ�Ѿ���utc_time�������������˵���������µ�ʱ�������ʱ��Ҫ����֮ǰutc��Ĭ��ֵ
        k=k+1;%���ڳ������µ�ʱ��������Ҫ��һ���µĶ�άԪ���������½��м�¼
        L(1,1:10,k)=x(i,1:10);%��������¼���õ��µĶ�άԪ���������棬������һ���ǵ�һ����¼������ǡ�1��
        j=2;%�����ÿһ���µ�ƥ���¼���Ǵ�2��ʼ¼��
    end
    
end
toc

temp_L_1=L(:,:,1);

%%%%%%%%����ǿ�����Ŀ



%%�ǵô�knn_interplote_weather��m�ļ�����ΪҪ�����������
tic
[d,~,~]=xlsread('station_AQI');%�����������վ�ľ�γ������
O=cell(35,6,size(L,3)-7);
for i=1:size(L,3)
      
            i  
       
       if i~=8226&&i~=8955&&i~=10724&&i~=10741&&i~=10780 ... 
               &&i~=10903&&i~=10987%%�����Сʱ���������ݲ�����
           %temp_meo=[cell2mat(L(:,2,i)) cell2mat(L(:,3,i)) cell2mat(L(:,10,i)) cell2mat(L(:,5,i)) cell2mat(L(:,6,i)) cell2mat(L(:,7,i)) cell2mat(L(:,8,i)) cell2mat(L(:,9,i))];
           temp_meo=[L(:,2,i) L(:,3,i) L(:,10,i) L(:,5,i) L(:,6,i) L(:,7,i) L(:,8,i) L(:,9,i)];
           W=knn_interplote_weather_without_encoding(temp_meo,d);
           O(1:35,2:10,i)=W(1:35,1:9,1); %%%����Сʱ������״����ֵ��ÿһ�����������۲�վ
       end
end
toc

%%��utc_timeʱ�������˳���L���Ƶ�P��ĵ�һ�е�һ��
 P=O;
for i=1:size(L,3)
P(1,1,i)=L(1,4,i);
end

%%�������۲�վ�����Ƽ��뵽P��ĵ�11��
[d,e,f]=xlsread('station_AQI');%�����������վ�ľ�γ������
for i=1:size(L,3)
    if i~=8226&&i~=8955&&i~=10724&&i~=10741&&i~=10780 ... 
               &&i~=10903&&i~=10987%%�����Сʱ���������ݲ�����
     P(:,11,i)=e(2:size(P(:,:,i),1)+1,1);
    end
end

%%�Ա���aqi ��ʷ���ݵ��ܱ���ʱ������з���
k=1;
g=1;
j=1;

aqi_utc_time=y(1,2);%��ʼ����һ��ƥ���utc_time
aqi=cell(35,size(y,2),200);%����6511��35�У�12�е�Ԫ�����ݣ�ע������Ҫ�����������У��У�Ԫ��������
tic
 for i=1:size(y,1) %��17-18�������۲�վ���ݱ�����ÿһ�����趨��utc_time����ƥ��
  
    if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
    end
    if isequal(table2cell(y(i,2)),table2cell(aqi_utc_time)) %������е�4�е�utc_time��Ԥ���趨�õ�utc_timeƥ���ϣ���ִ�����²���
        aqi(j,1:size(y,2),k)=table2cell(y(i,1:size(y,2))); %��ʱ���ƥ���ϵļ�¼���Ƶ���k��Ԫ����������Ǽ�¼�����ǲ�ͬ��������utc_time,station��
        j=j+1;%��¼ѭ����������������ÿ��Ԫ�����Ǵӵ�1�п�ʼȻ�󵽵�35�У�����j���ڿ��Ƹ��Ƶļ�¼��Ԫ�������е�λ��
    else %���ƥ�䲻��
        %L(i-1,1:10,k)=x(i,1:10);
        aqi_utc_time=y(i,2);%���ƥ�䲻�ϣ�������ǰ�Ѿ���utc_time�������������˵���������µ�ʱ�������ʱ��Ҫ����֮ǰutc��Ĭ��ֵ
        k=k+1;%���ڳ������µ�ʱ��������Ҫ��һ���µĶ�άԪ���������½��м�¼
        aqi(1,1:size(y,2),k)=table2cell(y(i,1:size(y,2)));%��������¼���õ��µĶ�άԪ���������棬������һ���ǵ�һ����¼������ǡ�1��
        j=2;%�����ÿһ���µ�ƥ���¼���Ǵ�2��ʼ¼��
    end
    
end
toc

% %%%�ҳ��ظ��˵�aqi_without_winter ��¼
% tic
% multiple_aqi=[];
% multiple_aqi_location=[];
% for j=1:size(aqi,3)%����aqi�����ÿһ����άԪ������
%      for w=36:70%���������36-70��ÿһ�ж����в�ѯ
%      if ~isempty(cell2mat(aqi(w,1,j)))%������еĵ�һ��Ԫ�����ǿգ���˵����Сʱ�����35��վ��ļ�¼�ظ�
%          multiple_aqi=cat(1,multiple_aqi,w); %������е��к�
%          multiple_aqi_location=cat(1,multiple_aqi_location,j); %���Ԫ������λ��
%      end
%      end
% end
% toc
% 
%  %%%ɾ���ظ���¼
%  for j=1:size(aqi,3)
%      if mod(i,1000)==0 %�۲��㷨�������ٶ�
%        j     
%     end
%       for w1=1:size(aqi(:,:,j),1)
%           for w2=1:size(aqi(:,:,j),1)  
%               if w2 ~=w1
%                 if strcmp(cell2mat(aqi(w1,1,j)),cell2mat(aqi(w2,1,j)))
%                    for w3=1:size(aqi,2)
%                     aqi{w2,w3,j}=[];%%��Ԫ������ɾ�����ݵ�ʱ��ֻ����һ����ð�����������ֻ���ֶ�ѭ��
%                    end
%                 end
%               end
%            end
%       end
%  end
% 

%%��P�����ʷaqi���Ȱ���СʱȻ����վ�����ƥ��
tic
t1=1;
s1=1;
for i=1:size(aqi,3)
    if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i     
    end
    for j=t1:size(P,3)
        if isequal(aqi(1,2,i),P(1,1,j))
            for q=1:size(aqi(:,:,i),1)
                for r=1:size(P(:,:,j),1)
                    if isequal(aqi(q,1,i),P(r,size(P,2),j))
                        aqi(q,size(y,2)+1:size(y,2)+size(P,2),i)=P(r,1:size(P,2),j);
                    end
                end
            end
        end
    end
end
toc

tic
beijing_aqi_full=aqi(:,:,1);
for j=2:size(aqi,3)
    if mod(j,1000)==0 %�۲��㷨�������ٶ�
       j     
    end
    beijing_aqi_full=cat(1,beijing_aqi_full,aqi(:,:,j));
end
toc

    beijing_aqi_full=cell2table(beijing_aqi_full);
    
%     %%%%ֻ����beijing_aqi_full����ķǿ���
%     beijing_aqi_full_new(1,:)=beijing_aqi_full(1,:);
%     k=1;
%     for i=1:size(beijing_aqi_full,1)
%         if mod(i,1000)==0 %�۲��㷨�������ٶ�
%         i;    
%          end
%          if ~isequal(cell2mat(table2array(beijing_aqi_full(i,1))),[])
%                 beijing_aqi_full_new(k,:)=beijing_aqi_full(i,:);
%                 k=k+1;
%          end
%     end
% beijing_aqi_full(:,{'beijing_aqi_full6','beijing_aqi_full12','beijing_aqi_full13','beijing_aqi_full15'}) = [];
% beijing_aqi_full = beijing_aqi_full(:,[1:2 6 3:5 7:end]);
% beijing_aqi_full = beijing_aqi_full(:,[1:3 7 4:6 8:end]);
% beijing_aqi_full = beijing_aqi_full(:,[1:4 8 5:7 9:end]);
% beijing_aqi_full = beijing_aqi_full(:,[1:5 9 6:8 10:end]);
% beijing_aqi_full = beijing_aqi_full(:,[1:6 10 7:9 end]);
% beijing_aqi_full = beijing_aqi_full(:,[1:7 11 8:10]);

tic
writetable(beijing_aqi_full,'beijing_17_01_18_05-20_all_aqi_meo_weather_75_model_without_encoding.csv','Delimiter',',','QuoteStrings',true)
toc



%%%%%%%����������ʷ����aqi-meo�ܱ��ڵ�18�����ӷ���Ȼ����ת����table�Ժ󣬽�PM2.5��PM10��O3
%%%%%%%�ƶ��������ǰ�棬�����Ƶ�������档Ȼ�����ʱ����з��飬����BJ_knn_aqi�������пռ��ֵ
%%%%%%%����ٸ���վ����飬����ʱ�����Բ�ֵ

clear
tic
BJ=readtable('beijing_17_01_18_05-20_all_aqi_meo_weather_75_model_without_encoding_new.csv'); %%���뱱��aqi-meo�ܱ�����ǰҪ����հ�
toc

BJ=table2cell(BJ);

%%��������ӵ�BJ��18��
tic
for i=1:size(BJ,1)
            if mod(i,1000)==0 %�۲��㷨�������ٶ�
            i    
            end
            if cell2mat(BJ(i,14))>0 && cell2mat(BJ(i,15))>0
            BJ(i,18)=num2cell((atan(cell2mat(BJ(i,14))/cell2mat(BJ(i,15)))/pi)*180);
            elseif cell2mat(BJ(i,14))>0 && cell2mat(BJ(i,15))<0
            BJ(i,18)= num2cell((atan(cell2mat(BJ(i,14))/cell2mat(BJ(i,15)))/pi)*180+180);
            elseif cell2mat(BJ(i,14))<0 && cell2mat(BJ(i,15))<0
            BJ(i,18)=num2cell((atan(cell2mat(BJ(i,14))/cell2mat(BJ(i,15)))/pi)*180+180);
            elseif cell2mat(BJ(i,14))<0 && cell2mat(BJ(i,15))>0 
            BJ(i,18)=num2cell((atan(cell2mat(BJ(i,14))/cell2mat(BJ(i,15)))/pi)*180+360);
            elseif cell2mat(BJ(i,14))==0 && cell2mat(BJ(i,15))>0
            BJ(i,18)=num2cell(0);
            elseif cell2mat(BJ(i,14))==0 && cell2mat(BJ(i,15))<0
            BJ(i,18)=num2cell(180);  
            elseif cell2mat(BJ(i,14))>0 && cell2mat(BJ(i,15))==0
            BJ(i,18)=num2cell(90);
            elseif cell2mat(BJ(i,14))<0 && cell2mat(BJ(i,15))==0
            BJ(i,18)=num2cell(270);
            else
            BJ(i,18)=num2cell(NaN);
            end
end
toc

BJ=cell2table(BJ);

% tic
% writetable(BJ,'beijing_historical_month_aqi_meo_full_75_model_with_wind_direction.csv','Delimiter',',','QuoteStrings',true)
% toc

%%%%%%%%%%%%����˳��ɾ��u��v����ķ��٣���PM2.5��PM10��O3��NO2��CO��SO2�Ƶ������ǰ�棬����
%%%%%%%%%%%%����������Ƶ�������棬������һ��

BJ(:,{'BJ14','BJ15'}) = [];%%ɾ��u��v����ķ���
BJ = BJ(:,[1:14 16 15]);%����������Ƶ�������棬������һ��
BJ = BJ(:,[1:2 4:14 3 15:end]);%%��PM2.5�Ƶ������ǰ��
BJ = BJ(:,[1:2 4:14 3 15:end]);%%��PM10�Ƶ������ǰ��
BJ = BJ(:,[1:2 4:14 3 15:end]);%%��O3�Ƶ������ǰ��
BJ = BJ(:,[1:2 4:14 3 15:end]);%%��NO2�Ƶ������ǰ��
BJ = BJ(:,[1:2 4:14 3 15:end]);%%��CO�Ƶ������ǰ��
BJ = BJ(:,[1:2 4:14 3 15:end]);%%��SO2�Ƶ������ǰ��


%%%%%%%%%%%%��BJ�����ʱ����飬Ȼ���ÿһ����пռ��ֵ�NaN

%%�Ա�������utc_time�����飬�γ���άԪ������
tic
temp_utc_time=table2cell(BJ(1,2)); %��ʼ����һ�����ڷ����utc_time
BJ_data=cell(5,size(BJ,2),10);%��ʼ����άԪ������
BJ_num=1;%վ����Ŀ
j=1;%��¼ѭ����ÿ����άԪ�����������к�
for i = 1:size(BJ,1)
      if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
      end
      if isequal(temp_utc_time, table2cell(BJ(i,2)))
           BJ_data(j,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
           j=j+1;
      else
           temp_utc_time=table2cell(BJ(i,2));
           BJ_num=BJ_num + 1;
           BJ_data(1,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
           j=2;
      end
end
toc

temp_BJ_data_1=BJ_data(:,:,1);

%%�Ա�����PM2.5��PM10��O3���տռ�����ڽ��з������Ȩ��ֵ
temp_BJ_data_new=cell(size(BJ_data));
tic
for i=1:size(BJ_data,3)
        if mod(i,1000)==0 %�۲��㷨�������ٶ�
         i  
        end
        temp_BJ_data_new(:,1:14,i)=BJ_knn_aqi_full(BJ_data(:,1:14,i));
        temp_BJ_data_new(:,15:16,i)=BJ_data(:,15:16,i);
end
toc

temp_BJ_data_test=temp_BJ_data_new(:,:,1);



%%��temp_BJ_data_new����ʱ��ϲ�

%%�ϲ�
tic
BJ_temperature=temp_BJ_data_new(:,:,1);
for j=2:BJ_num
    if mod(j,1000)==0 %�۲��㷨�������ٶ�
       j     
    end
    BJ_temperature=cat(1,BJ_temperature,temp_BJ_data_new(:,:,j));
end

toc


BJ_temperature=cell2table(BJ_temperature);

tic
writetable(BJ_temperature,'beijing_17_01_18_05-20_all_aqi_meo_weather_75_model_without_encoding_space_interplote.csv','Delimiter',',','QuoteStrings',true)
toc

%BJ_temperature = sortrows(BJ_temperature,'BJ_temperature1','ascend');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
tic
BJ=readtable('beijing_17_01_18_05-20_all_aqi_meo_weather_75_model_without_encoding_space_interplote_new.csv');%%���밴��վ������ı��
toc


%%�Ա�������aqiվ�������飬�γ���άԪ������
tic
temp_aqi_station=table2cell(BJ(1,1)); %��ʼ����һ�����ڷ����aqi_station
BJ_data=cell(200,size(BJ,2),10);%��ʼ����άԪ������
BJ_num=1;%վ����Ŀ
j=1;%��¼ѭ����ÿ����άԪ�����������к�
for i = 1:size(BJ,1)
      if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
      end
      if isequal(temp_aqi_station, table2cell(BJ(i,1)))
           BJ_data(j,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
           j=j+1;
      else
           temp_aqi_station=table2cell(BJ(i,1));
           BJ_num=BJ_num + 1;
           BJ_data(1,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
           j=2;
      end
end
toc

temp_BJ_data_1=BJ_data(:,:,1);
temp_BJ_data_6=BJ_data(:,:,6);
BJ_data_beta=BJ_data;
BJ_data=BJ_data_beta; %%�������⣬�������лָ�

%%����ǡ��ա�������������sizeȥ��ǡ��ա��е�Ԫ������������Ϊ�����ռ���Ԫ������ǿգ�����޷������ʵ�ķǡ��ա���
BJ_empty=double(BJ_num);
k=0;
 for i=1:BJ_num
     for j=1:size(BJ_data(:,:,i),1)
         if isempty(BJ_data{j,1,i})~=1
         k=k+1;
         end
     end
     BJ_empty(i,1)=k;
     k=0;
 end
 
%%%%%��ÿ��aqiվ�㣬����ʱ�䷢չ˳������������7��PM2.5��PM10��O3��NaN��ʱ��
%%%%%�������Բ�ֵ�ķ�ʽ���в�ֵ���NaN
h=1;
tic
for i=1:size(BJ_data,3)
    i
        for j=1:size(BJ_data(:,:,i),1)
            if isnan(cell2mat(BJ_data(j,9,i)))%%�ж�PM2.5�Ƿ�ΪNaN
               if j+1<size(BJ_data(:,:,i),1) && j~=1 %%�߽��жϣ����ں��������j-1,Ϊ�˱�֤������Ϊ0�����j���ܵ���1
                   if ~isnan(cell2mat(BJ_data(j+1,9,i))) || ~isnan(cell2mat(BJ_data(j+2,9,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+3,9,i))) || ~isnan(cell2mat(BJ_data(j+4,9,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+5,9,i))) || ~isnan(cell2mat(BJ_data(j+6,9,i))) || ~isnan(cell2mat(BJ_data(j+7,9,i)))
                     %����ڰ˸�����NaN��Ҳ��������NaN�������7,ע��������������ǰ��մ����ҵ�˳��ִ�еģ�һ��Ҫ��С����ȥд
                        for k=1:6
                            if isnan(cell2mat(BJ_data(j+k,9,i)))
                                h=h+1;
                            else
                                break
                            end
                        end
                        for k=1:h
                            BJ_data(j+k-1,9,i)=num2cell(((cell2mat(BJ_data(j+h,9,i))-cell2mat(BJ_data(j-1,9,i)))/(h+1))*k+cell2mat(BJ_data(j-1,9,i)));
                        end
                   end
               end
            end
            h=1;
        end
        
        h=1;
        
        for j=1:size(BJ_data(:,:,i),1)
            if isnan(cell2mat(BJ_data(j,10,i)))%%�ж�PM10�Ƿ�ΪNaN
               if j+1<size(BJ_data(:,:,i),1) && j~=1 %%�߽��жϣ����ں��������j-1,Ϊ�˱�֤������Ϊ0�����j���ܵ���1
                 if ~isnan(cell2mat(BJ_data(j+1,10,i))) || ~isnan(cell2mat(BJ_data(j+2,10,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+3,10,i))) || ~isnan(cell2mat(BJ_data(j+4,10,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+5,10,i))) || ~isnan(cell2mat(BJ_data(j+6,10,i))) || ~isnan(cell2mat(BJ_data(j+7,10,i)))
                     %%r����ڰ˸�����NaN��Ҳ��������NaN�������7
                        for k=1:6
                            if isnan(cell2mat(BJ_data(j+k,10,i)))
                                h=h+1;
                            else
                                break
                            end
                        end
                        for k=1:h
                            BJ_data(j+k-1,10,i)=num2cell(((cell2mat(BJ_data(j+h,10,i))-cell2mat(BJ_data(j-1,10,i)))/(h+1))*k+cell2mat(BJ_data(j-1,10,i)));
                        end
                 end
               end
            end
            h=1;
        end
            h=1;
            
        for j=1:size(BJ_data(:,:,i),1)
            if isnan(cell2mat(BJ_data(j,11,i)))%%�ж�O3�Ƿ�ΪNaN
               if j+1<size(BJ_data(:,:,i),1) && j~=1 %%�߽��жϣ����ں��������j-1,Ϊ�˱�֤������Ϊ0�����j���ܵ���1
                if ~isnan(cell2mat(BJ_data(j+1,11,i))) || ~isnan(cell2mat(BJ_data(j+2,11,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+3,11,i))) || ~isnan(cell2mat(BJ_data(j+4,11,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+5,11,i))) || ~isnan(cell2mat(BJ_data(j+6,11,i))) || ~isnan(cell2mat(BJ_data(j+7,11,i)))
                     %%r����ڰ˸�����NaN��Ҳ��������NaN�������7
                        for k=1:6
                            if isnan(cell2mat(BJ_data(j+k,11,i)))
                                h=h+1;
                            else
                                break
                            end
                        end
                        for k=1:h
                            BJ_data(j+k-1,11,i)=num2cell(((cell2mat(BJ_data(j+h,11,i))-cell2mat(BJ_data(j-1,11,i)))/(h+1))*k+cell2mat(BJ_data(j-1,11,i)));
                        end
                end
               end
            end
                   h=1;
        end
        h=1;
        
         for j=1:size(BJ_data(:,:,i),1)
            if isnan(cell2mat(BJ_data(j,12,i)))%%�ж�NO2�Ƿ�ΪNaN
               if j+1<size(BJ_data(:,:,i),1) && j~=1 %%�߽��жϣ����ں��������j-1,Ϊ�˱�֤������Ϊ0�����j���ܵ���1
                if ~isnan(cell2mat(BJ_data(j+1,12,i))) || ~isnan(cell2mat(BJ_data(j+2,12,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+3,12,i))) || ~isnan(cell2mat(BJ_data(j+4,12,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+5,12,i))) || ~isnan(cell2mat(BJ_data(j+6,12,i))) || ~isnan(cell2mat(BJ_data(j+7,12,i)))
                     %%r����ڰ˸�����NaN��Ҳ��������NaN�������7
                        for k=1:6
                            if isnan(cell2mat(BJ_data(j+k,12,i)))
                                h=h+1;
                            else
                                break
                            end
                        end
                        for k=1:h
                            BJ_data(j+k-1,12,i)=num2cell(((cell2mat(BJ_data(j+h,12,i))-cell2mat(BJ_data(j-1,12,i)))/(h+1))*k+cell2mat(BJ_data(j-1,12,i)));
                        end
                end
               end
            end
                   h=1;
        end
        h=1;
        
        for j=1:size(BJ_data(:,:,i),1)
            if isnan(cell2mat(BJ_data(j,13,i)))%%�ж�CO�Ƿ�ΪNaN
               if j+1<size(BJ_data(:,:,i),1) && j~=1 %%�߽��жϣ����ں��������j-1,Ϊ�˱�֤������Ϊ0�����j���ܵ���1
                if ~isnan(cell2mat(BJ_data(j+1,13,i))) || ~isnan(cell2mat(BJ_data(j+2,13,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+3,13,i))) || ~isnan(cell2mat(BJ_data(j+4,13,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+5,13,i))) || ~isnan(cell2mat(BJ_data(j+6,13,i))) || ~isnan(cell2mat(BJ_data(j+7,13,i)))
                     %%r����ڰ˸�����NaN��Ҳ��������NaN�������7
                        for k=1:6
                            if isnan(cell2mat(BJ_data(j+k,13,i)))
                                h=h+1;
                            else
                                break
                            end
                        end
                        for k=1:h
                            BJ_data(j+k-1,13,i)=num2cell(((cell2mat(BJ_data(j+h,13,i))-cell2mat(BJ_data(j-1,13,i)))/(h+1))*k+cell2mat(BJ_data(j-1,13,i)));
                        end
                end
               end
            end
                   h=1;
        end
        h=1;
        
        for j=1:size(BJ_data(:,:,i),1)
            if isnan(cell2mat(BJ_data(j,14,i)))%%�ж�SO2�Ƿ�ΪNaN
               if j+1<size(BJ_data(:,:,i),1) && j~=1 %%�߽��жϣ����ں��������j-1,Ϊ�˱�֤������Ϊ0�����j���ܵ���1
                if ~isnan(cell2mat(BJ_data(j+1,14,i))) || ~isnan(cell2mat(BJ_data(j+2,14,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+3,14,i))) || ~isnan(cell2mat(BJ_data(j+4,14,i))) ...
                         || ~isnan(cell2mat(BJ_data(j+5,14,i))) || ~isnan(cell2mat(BJ_data(j+6,14,i))) || ~isnan(cell2mat(BJ_data(j+7,14,i)))
                     %%r����ڰ˸�����NaN��Ҳ��������NaN�������7
                        for k=1:6
                            if isnan(cell2mat(BJ_data(j+k,14,i)))
                                h=h+1;
                            else
                                break
                            end
                        end
                        for k=1:h
                            BJ_data(j+k-1,14,i)=num2cell(((cell2mat(BJ_data(j+h,14,i))-cell2mat(BJ_data(j-1,14,i)))/(h+1))*k+cell2mat(BJ_data(j-1,14,i)));
                        end
                end
               end
            end
                   h=1;
        end
        h=1;
        
end
toc

%%��temp_BJ_data_new����ʱ��ϲ�

%%�ϲ�
tic
BJ_temperature=BJ_data(:,:,1);
for j=2:BJ_num
     if mod(j,1000)==0 %�۲��㷨�������ٶ�
       j 
    end     
    BJ_temperature=cat(1,BJ_temperature,BJ_data(:,:,j));
end

toc

BJ_temperature=cell2table(BJ_temperature);

tic
writetable(BJ_temperature,'temp_BJ_17_01_18_05-20_data_weather_75_model_with_time_interplot_new_without_encoding.csv');
toc

%%%%%%%%%%%%���ٽ��ĸ�վ���PM2.5��PM10��O3��NO2��CO��SO2�ŵ�16���Ժ󣨱���վ�����ƣ�����÷ֱ��Ƿ����ˣ�
clear
tic
BJ=readtable('temp_BJ_17_01_18_05-20_data_weather_75_model_with_time_interplot_new_without_encoding_sort_time.csv');%%���밴��ʱ������ı��
toc

% BJ(152049,1)=BJ(152048,2);
% BJ(152048,:) = [];
%%�Ա�������utc_time�����飬�γ���άԪ������
tic
temp_utc_time=table2cell(BJ(1,2)); %��ʼ����һ�����ڷ����utc_time
BJ_data=cell(5,size(BJ,2),10);%��ʼ����άԪ������
BJ_num=1;%վ����Ŀ
j=1;%��¼ѭ����ÿ����άԪ�����������к�
for i = 1:size(BJ,1)
      if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
      end
      if isequal(temp_utc_time, table2cell(BJ(i,2)))
           BJ_data(j,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
           j=j+1;
      else
           temp_utc_time=table2cell(BJ(i,2));
           BJ_num=BJ_num + 1;
           BJ_data(1,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
           j=2;
      end
end
toc

temp_BJ_data_1=BJ_data(:,:,1);

temp_BJ_data=temp_BJ_data_1;
temp_BJ_data_new=cell(size(BJ_data,1),64,size(BJ_data,3));
tic
for i=1:size(BJ_data,3)
        if mod(i,1000)==0 %�۲��㷨�������ٶ�
        i  
        end 
         if ~isnan(cell2mat(BJ_data(1,3,i)))
        temp_BJ_data_new(:,1:63,i)=BJ_knn_full_aqi_station(BJ_data(:,1:15,i));
        temp_BJ_data_new(:,64,i)=BJ_data(:,16,i);
        end
end
toc
temp_BJ_data_new_1=temp_BJ_data_new(:,:,1);

%%��temp_BJ_data_new����ʱ��ϲ�

%%�ϲ�
tic
BJ_temperature=temp_BJ_data_new(:,:,1);
for j=2:BJ_num
       if mod(j,1000)==0 %�۲��㷨�������ٶ�
       j  
      end   
    BJ_temperature=cat(1,BJ_temperature,temp_BJ_data_new(:,:,j));
end

toc

BJ_temperature=cell2table(BJ_temperature);

tic
writetable(BJ_temperature,'temp_BJ_17_01_18_05-20_data_weather_75_model_full_result_new_new_without_encoding.csv');
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear
tic
BJ=readtable('temp_BJ_17_01_18_05-20_data_weather_75_model_full_result_new_new_without_encoding_new.csv'); %%%����վ��˳�����У����������һ��
toc
BJ=table2cell(BJ);

for i=1:size(BJ,1)
    if isequal(BJ{i,64},'Cloudy') 
            BJ(i,64)=num2cell(1);
    elseif isequal(BJ{i,64},'Dust') 
            BJ(i,64)=num2cell(2);
    elseif isequal(BJ{i,64},'Fog') 
            BJ(i,64)=num2cell(3);
    elseif isequal(BJ{i,64},'Hail') || isequal(BJ{i,64},'Haze')
            BJ(i,64)=num2cell(4);
    elseif isequal(BJ{i,64},'Light Rain') 
            BJ(i,64)=num2cell(5);
    elseif isequal(BJ{i,64},'Overcast') 
            BJ(i,64)=num2cell(6);
    elseif isequal(BJ{i,64},'Rain') 
            BJ(i,64)=num2cell(7);
    elseif isequal(BJ{i,64},'Rain with Hail') 
            BJ(i,64)=num2cell(8);
    elseif isequal(BJ{i,64},'Rain/Snow with Hail') 
            BJ(i,64)=num2cell(9);
    elseif isequal(BJ{i,64},'Sand') 
            BJ(i,64)=num2cell(10);
    elseif isequal(BJ{i,64},'Sleet') 
            BJ(i,64)=num2cell(11);
    elseif isequal(BJ{i,64},'Snow') 
            BJ(i,64)=num2cell(12);
    elseif isequal(BJ{i,64},'Sunny/clear') 
            BJ(i,64)=num2cell(13);
    else
            BJ(i,64)=num2cell(14);
    end
end

BJ=cell2table(BJ);

tic
writetable(BJ,'temp_BJ_17_01_18_05-20_data_weather_75_model_full_result_new_new_with_encoding.csv','Delimiter',',','QuoteStrings',true)
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% clear
% tic
% BJ=readtable('temp_BJ_all_month_data_weather_75_model_full_result_new_new_new_without_encoding.csv');%%%��վ������
% toc
% 
% %%%%������aqi-meo�ܱ���aqiվ����з���
% tic
% temp_aqi_station=table2cell(BJ(1,1)); %��ʼ����һ�����ڷ����aqi_station
% BJ_data=cell(200,size(BJ,2),35);%��ʼ����άԪ������
% BJ_num=1;%վ����Ŀ
% j=1;%��¼ѭ����ÿ����άԪ�����������к�
% for i = 1:size(BJ,1)
%       if mod(i,1000)==0 %�۲��㷨�������ٶ�
%        i  
%       end
%       if isequal(temp_aqi_station, table2cell(BJ(i,1)))
%            BJ_data(j,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
%            j=j+1;
%       else
%            temp_aqi_station=table2cell(BJ(i,1));
%            BJ_num=BJ_num + 1;
%            BJ_data(1,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
%            j=2;
%       end
% end
% toc
% 
% %BJ_data_beta=BJ_data;%%�����Է�����
% %BJ_data=BJ_data_beta;%%��ԭ
% 
% %%%%%%��5-32��
% %%���¶ȡ�ѹǿ��ʪ�ȡ����١�����PM2.5��PM10��O3�Լ�4���ٽ�վ���PM2.5��PM10��O3�����١�����
% %%�ƶ�8��
% 
% timestep=8;
% for i=1:size(BJ_data,3) 
%     for k=1:timestep
%         for j=1:size(BJ_data(:,:,i),1)-1
%             BJ_data(j,37+32*(k-1):68+32*(k-1),i)=BJ_data(j+1,5+32*(k-1):36+32*(k-1),i);
%         end
%     end
% end
% 
% %temp_BJ_data_1=BJ_data(:,:,1);
% 
% %BJ_data_alpha=BJ_data;%%%����
% 
% %%�ϲ�
% tic
% BJ_temperature=BJ_data(:,:,1);
% for j=2:BJ_num
%        j     
%     BJ_temperature=cat(1,BJ_temperature,BJ_data(:,:,j));
% end
% 
% toc
% 
% BJ_temperature=cell2table(BJ_temperature);
% 
% 
% %%%%%%%%����������ͳһ�ƶ������
% tic
% BJ_temperature = BJ_temperature(:,[1:267 269:292 268]);
% BJ_temperature = BJ_temperature(:,[1:235 237:292 236]);
% BJ_temperature = BJ_temperature(:,[1:203 205:292 204]);
% BJ_temperature = BJ_temperature(:,[1:171 173:292 172]);
% BJ_temperature = BJ_temperature(:,[1:139 141:292 140]);
% BJ_temperature = BJ_temperature(:,[1:107 109:292 108]);
% BJ_temperature = BJ_temperature(:,[1:75 77:292 76]);
% BJ_temperature = BJ_temperature(:,[1:43 45:292 44]);
% BJ_temperature = BJ_temperature(:,[1:11 13:292 12]);
% toc
% %BJ_temperature_beta=BJ_temperature;%%%����
% %BJ_temperature=BJ_temperature_beta;%%%��ԭ
% 
% %%%%%%%�������Сʱ���ڽ�վ���pm2.5��pm10��O3�����٣������ƶ������
% tic
% BJ_temperature = BJ_temperature(:,[1:259 284:292 260:283]);
% BJ_temperature = BJ_temperature(:,[1:228 253:292 229:252]);
% BJ_temperature = BJ_temperature(:,[1:197 222:292 198:221]);
% BJ_temperature = BJ_temperature(:,[1:166 191:292 167:190]);
% BJ_temperature = BJ_temperature(:,[1:135 160:292 136:159]);
% toc
% %BJ_temperature_alpha=BJ_temperature;%%����
% 
% %%%%%%%��ǰ4Сʱ���ڽ�վ�������ȫ��ɾȥ
% tic
% BJ_temperature(:,{'BJ_temperature109','BJ_temperature110','BJ_temperature111','BJ_temperature112','BJ_temperature113','BJ_temperature114','BJ_temperature115','BJ_temperature116','BJ_temperature117','BJ_temperature118','BJ_temperature119','BJ_temperature120','BJ_temperature121','BJ_temperature122','BJ_temperature123','BJ_temperature124','BJ_temperature125','BJ_temperature126','BJ_temperature127','BJ_temperature128','BJ_temperature129','BJ_temperature130','BJ_temperature131','BJ_temperature132'}) = [];
% BJ_temperature(:,{'BJ_temperature77','BJ_temperature78','BJ_temperature79','BJ_temperature80','BJ_temperature81','BJ_temperature82','BJ_temperature83','BJ_temperature84','BJ_temperature85','BJ_temperature86','BJ_temperature87','BJ_temperature88','BJ_temperature89','BJ_temperature90','BJ_temperature91','BJ_temperature92','BJ_temperature93','BJ_temperature94','BJ_temperature95','BJ_temperature96','BJ_temperature97','BJ_temperature98','BJ_temperature99','BJ_temperature100'}) = [];
% BJ_temperature(:,{'BJ_temperature45','BJ_temperature46','BJ_temperature47','BJ_temperature48','BJ_temperature49','BJ_temperature50','BJ_temperature51','BJ_temperature52','BJ_temperature53','BJ_temperature54','BJ_temperature55','BJ_temperature56','BJ_temperature57','BJ_temperature58','BJ_temperature59','BJ_temperature60','BJ_temperature61','BJ_temperature62','BJ_temperature63','BJ_temperature64','BJ_temperature65','BJ_temperature66','BJ_temperature67','BJ_temperature68'}) = [];
% BJ_temperature(:,{'BJ_temperature13','BJ_temperature14','BJ_temperature15','BJ_temperature16','BJ_temperature17','BJ_temperature18','BJ_temperature19','BJ_temperature20','BJ_temperature21','BJ_temperature22','BJ_temperature23','BJ_temperature24','BJ_temperature25','BJ_temperature26','BJ_temperature27','BJ_temperature28','BJ_temperature29','BJ_temperature30','BJ_temperature31','BJ_temperature32','BJ_temperature33','BJ_temperature34','BJ_temperature35','BJ_temperature36'}) = [];
% toc
% %BJ_temperature_delta=BJ_temperature;%%����
% 
% %%%%%%%ɾ��վ������
% tic
% BJ_temperature(:,{'BJ_temperature269','BJ_temperature275','BJ_temperature281','BJ_temperature287','BJ_temperature237','BJ_temperature243','BJ_temperature249','BJ_temperature255','BJ_temperature205','BJ_temperature211','BJ_temperature217','BJ_temperature223','BJ_temperature173','BJ_temperature179','BJ_temperature185','BJ_temperature191','BJ_temperature141','BJ_temperature147','BJ_temperature153','BJ_temperature159'}) = [];
% toc
% 
% %BJ_temperature_alpha=BJ_temperature;%%����
% 
% %%%%%%%�����һСʱ��PM2.5��PM10��O3�ƶ�60��
% 
% %%%%������aqi-meo�ܱ���aqiվ����з���
% BJ=BJ_temperature;
% tic
% temp_aqi_station=table2cell(BJ(1,1)); %��ʼ����һ�����ڷ����aqi_station
% BJ_data=cell(200,size(BJ,2),35);%��ʼ����άԪ������
% BJ_num=1;%վ����Ŀ
% j=1;%��¼ѭ����ÿ����άԪ�����������к�
% for i = 1:size(BJ,1)
%       if mod(i,1000)==0 %�۲��㷨�������ٶ�
%        i  
%       end
%       if isequal(temp_aqi_station, table2cell(BJ(i,1)))
%            BJ_data(j,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
%            j=j+1;
%       else
%            temp_aqi_station=table2cell(BJ(i,1));
%            BJ_num=BJ_num + 1;
%            BJ_data(1,1:size(BJ,2),BJ_num)=table2cell(BJ(i,1:size(BJ,2)));
%            j=2;
%       end
% end
% toc
% 
% tic
% for i=1:BJ_num
%     i
%     for j=1:size(BJ_data(:,:,i),1)-1
%         BJ_data(j,177,i)=BJ_data(j+1,65,i); %%�����������������ƶ�
%         BJ_data(j,178,i)=BJ_data(j+1,66,i); %%�����������������ƶ�
%         BJ_data(j,179,i)=BJ_data(j+1,67,i); %%�����������������ƶ�
%     end
% end
% toc
% 
% tic
% hour=59;
%  for i=1:BJ_num
%     i
%     for k=1:hour
%         for j=1:size(BJ_data(:,:,i),1)-1
%     BJ_data(j,180+3*(k-1),i)=BJ_data(j+1,177+3*(k-1),i); %%�����������������ƶ�
%     BJ_data(j,181+3*(k-1),i)=BJ_data(j+1,178+3*(k-1),i); %%�����������������ƶ�
%     BJ_data(j,182+3*(k-1),i)=BJ_data(j+1,179+3*(k-1),i); %%�����������������ƶ�
%         end
%     end
%  end
%  toc
% 
% %�ϲ����ƶ������aqi-meo�ܱ�
% tic
% BJ_temperature_new=BJ_data(:,:,1);
% for j=2:BJ_num
%        j     
%     BJ_temperature_new=cat(1,BJ_temperature_new,BJ_data(:,:,j));
% end
% 
% toc
% 
% BJ_temperature_new=cell2table(BJ_temperature_new);
% 
% %%%�ǵ��޸ı����ļ����ƣ�������Ҫɾ�����һ������Ŀհ���
% tic
% writetable(BJ_temperature_new,'BJ_all_month_aqi_meo_75_model_train_new.csv','Delimiter',',','QuoteStrings',true)
% toc