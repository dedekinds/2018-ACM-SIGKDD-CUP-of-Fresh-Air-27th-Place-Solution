function temp_BJ_data_new=BJ_knn_aqi_station(temp_BJ_data)

%%%����temp_BJ_data�ķǿ�����
BJ_empty=double(1);
k=0;

 for j=1:size(temp_BJ_data,1)
      if isempty(temp_BJ_data{j,1})~=1
         k=k+1;
      end
         BJ_empty(j,1)=k;
         k=0; 
 end
     
 %%%����temp_BJ_data�ľ������
 BJ_temp_dist=cell(size(BJ_empty,1),size(BJ_empty,1));
 
 k=1;
 for i=1:size(BJ_empty,1)
    for j=1:size(BJ_empty,1)
        
        temp_BJ_data(i,k+12)=num2cell(sqrt((cell2mat(temp_BJ_data(i,3))-cell2mat(temp_BJ_data(j,3)))^2+(cell2mat(temp_BJ_data(i,4))-cell2mat(temp_BJ_data(j,4)))^2));
        k=k+1;
        
    end
    BJ_temp_dist(i,1:size(BJ_temp_dist,2))=num2cell(sort(cell2mat(temp_BJ_data(i,13:size(BJ_temp_dist,2)+12))));
    k=1;
 end
 
 %%%�������ĳһ�г���NaN����ô�����þ�������ҳ��ÿ�������վ�������4��վ��
 %%%���÷������Ȩ���PM2.5��PM10��O3
 
 k=4; %���������ڵ���2
 h=2; %������ľ��������
 j=1;
 temp_BJ_data_new=temp_BJ_data(:,1:12);
 
    for i=1:size(temp_BJ_data,1)%��35����������վ�ֱ�
        
       for l=3:k+2 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵڶ���ʼ
                        [~,n]=find(cell2mat(temp_BJ_data(i,13:47))==cell2mat(BJ_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        temp_BJ_data_new(i,13+(j-1)*6)=temp_BJ_data(n,1);%վ������
                        temp_BJ_data_new(i,14+(j-1)*6)=temp_BJ_data(n,10);%PM10
                        temp_BJ_data_new(i,15+(j-1)*6)=temp_BJ_data(n,11);%O3
                        temp_BJ_data_new(i,16+(j-1)*6)=temp_BJ_data(n,12);%����
                        temp_BJ_data_new(i,17+(j-1)*6)=temp_BJ_data(n,8);%����
                        temp_BJ_data_new(i,18+(j-1)*6)=temp_BJ_data(n,9);%PM2.5
                        j=j+1;
       end
       j=1;
    end
    
    
end