function temp_LD_data_new_1=LD_knn_aqi_station(temp_LD_data)
%%%����temp_LD_data�ķǿ�����

LD_empty=0;
 for j=1:size(temp_LD_data,1)
      if isempty(temp_LD_data{j,1})~=1
         LD_empty=LD_empty+1;
      end
 end
 
 LD_num=size(temp_LD_data,2);
 LD_num_1=LD_empty;
 
 %%%����temp_LD_data�ľ������
 LD_temp_dist=cell(LD_empty,LD_empty);
 k=1;
 for i=1:LD_empty
    for j=1:LD_empty
        
        temp_LD_data(i,k+12)=num2cell(sqrt((cell2mat(temp_LD_data(i,3))-cell2mat(temp_LD_data(j,3)))^2+(cell2mat(temp_LD_data(i,4))-cell2mat(temp_LD_data(j,4)))^2));
        k=k+1;
        
    end
    LD_temp_dist(i,1:size(LD_temp_dist,2))=num2cell(sort(cell2mat(temp_LD_data(i,13:size(LD_temp_dist,2)+12))));
    k=1;
 end
 k=4; %���������ڵ���2
 h=2; %������ľ��������
 j=1;
 temp_LD_data_new_1=temp_LD_data(:,1:12);
 
    for i=1:LD_empty%��35����������վ�ֱ�
        
       for l=3:k+2 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵڶ���ʼ
                        [~,n]=find(cell2mat(temp_LD_data(i,13:12+LD_empty))==cell2mat(LD_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        temp_LD_data_new_1(i,13+(j-1)*6)=temp_LD_data(n,1);%վ������
                        temp_LD_data_new_1(i,14+(j-1)*6)=temp_LD_data(n,9);%PM2.5
                        temp_LD_data_new_1(i,15+(j-1)*6)=temp_LD_data(n,10);%PM10
                        temp_LD_data_new_1(i,16+(j-1)*6)=temp_LD_data(n,11);%O3
                        temp_LD_data_new_1(i,17+(j-1)*6)=temp_LD_data(n,8);%����
                        temp_LD_data_new_1(i,18+(j-1)*6)=temp_LD_data(n,12);%����
                        j=j+1;
       end
       j=1;
    end
 
end