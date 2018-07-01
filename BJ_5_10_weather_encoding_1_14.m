clear
tic
BJ=readtable('bj_meo_2018-05-31-22-23.csv'); %%%����վ��˳�����У�ʱ���ڵڶ��У�ɾ����station_id
toc
BJ=table2cell(BJ);

for i=1:size(BJ,1)
    if isequal(BJ{i,3},'Cloudy') 
            BJ(i,3)=num2cell(1);
    elseif isequal(BJ{i,3},'Dust') 
            BJ(i,3)=num2cell(2);
    elseif isequal(BJ{i,3},'Fog') 
            BJ(i,3)=num2cell(3);
    elseif isequal(BJ{i,3},'Hail') || isequal(BJ{i,3},'Haze')
            BJ(i,3)=num2cell(4);
    elseif isequal(BJ{i,3},'Light Rain') 
            BJ(i,3)=num2cell(5);
    elseif isequal(BJ{i,3},'Overcast') 
            BJ(i,3)=num2cell(6);
    elseif isequal(BJ{i,3},'Rain') 
            BJ(i,3)=num2cell(7);
    elseif isequal(BJ{i,3},'Rain with Hail') 
            BJ(i,3)=num2cell(8);
    elseif isequal(BJ{i,3},'Rain/Snow with Hail') 
            BJ(i,3)=num2cell(9);
    elseif isequal(BJ{i,3},'Sand') 
            BJ(i,3)=num2cell(10);
    elseif isequal(BJ{i,3},'Sleet') 
            BJ(i,3)=num2cell(11);
    elseif isequal(BJ{i,3},'Snow') 
            BJ(i,3)=num2cell(12);
    elseif isequal(BJ{i,3},'Sunny/clear') 
            BJ(i,3)=num2cell(13);
    else
            BJ(i,3)=num2cell(14);
    end
end

BJ=cell2table(BJ);

tic
temp_station_id=table2cell(BJ(1,1)); %��ʼ����һ�����ڷ����staion_id
BJ_data=cell(1,8,1);%��ʼ����άԪ������, ע���һ��λ�õ�ֵҪ����һ�£���ÿ��Ԫ��������
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

%%�������۲�վ�����Ƽ��뵽BJ_data��ĵ�8,9��
[d,e,f]=xlsread('station_meo');%�����������վ�ľ�γ������
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

tic
writetable(BJ_new,'BJ_5_31_22_23_with_location_new_encoding.csv','Delimiter',',','QuoteStrings',true)
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear;
tic
[a,b,c]=xlsread('meo_170106_16');%��������վ�ľ�γ�����ꡢ���ٷ��������
x=readtable('BJ_5_31_22_23_with_location_new_encoding_new.csv');%���뱱����ʷ��������,��ʱ������
x = x(:,[1 9 2:8 end]);
x = x(:,[1:2 10 3:9]);
x = x(:,[1:4 6:10 5]);
x=table2cell(x);
toc

k=1;
g=1;
j=1;
tic
aqi_utc_time=x(2,4);%��ʼ����һ��ƥ���utc_time
L=cell(1,11,1);%����8782��18�У�11�е�Ԫ�����ݣ�ע������Ҫ�����������У��У�Ԫ��������
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

%%�ǵô�knn_interplote_weather��m�ļ�����ΪҪ�����������
tic
[d,~,~]=xlsread('station_AQI');%�����������վ�ľ�γ������
O=[35,6,2];
for i=1:size(L,3)
      
            i  
       
       if i~=8226&&i~=8955&&i~=10724&&i~=10741&&i~=10780&&i~=10903%%�����Сʱ���������ݲ�����
           temp_meo=[cell2mat(L(:,2,i)) cell2mat(L(:,3,i)) cell2mat(L(:,10,i)) cell2mat(L(:,5,i)) cell2mat(L(:,6,i)) cell2mat(L(:,7,i)) cell2mat(L(:,8,i)) cell2mat(L(:,9,i))];
           W=knn_interplote_weather(temp_meo,d);
           O(1:35,2:10,i)=W(1:35,1:9,1); %%%����Сʱ������״����ֵ��ÿһ�����������۲�վ
       end
end
toc

%%��utc_timeʱ�������˳���L���Ƶ�P��ĵ�һ�е�һ��
 P=num2cell(O);
for i=1:size(L,3)
P(1,1,i)=L(1,4,i);
end

%%�������۲�վ�����Ƽ��뵽P��ĵ�11��
[d,e,f]=xlsread('station_AQI');%�����������վ�ľ�γ������
for i=1:size(L,3)
    if i~=8226&&i~=8955&&i~=10724&&i~=10741&&i~=10780&&i~=10903
     P(:,11,i)=e(2:size(P(:,:,i),1)+1,1);
    end
end

%%%%%%%%%����submission�ı���վ��˳���������
[~,~,BJ_predict_station]=xlsread('BJ_predict_station_id');%�����������վ�ľ�γ������
BJ_data_new=cell(size(P));

for i=1:size(BJ_predict_station,1)
   for k=1:size(P,1)
     for j=1:size(P,3)
        if isequal(P(k,11,j),BJ_predict_station(i,1))
            BJ_data_new(i,:,j)=P(k,:,j);
        end 
     end
   end
end

tic
BJ_new=BJ_data_new(:,:,1);
for j=2:size(BJ_data_new,3)
       j     
    BJ_new=cat(1,BJ_new,BJ_data_new(:,:,j));
end

toc

%%%�������о�γ�ȵı���4�·����ݱ�
BJ_new=cell2table(BJ_new);
BJ_new = BJ_new(:,[11 1:10]);

tic
writetable(BJ_new,'BJ_5_31_22_23_with_weather_new_encoding.csv','Delimiter',',','QuoteStrings',true)
toc
