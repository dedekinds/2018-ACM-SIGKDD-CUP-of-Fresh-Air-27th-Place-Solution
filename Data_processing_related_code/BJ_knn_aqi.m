function temp_BJ_data_new=BJ_knn_aqi(temp_BJ_data)

%%%����temp_BJ_data�ķǿ���������Ϊ��matlab��cell�����������棬���cell
%%%A�����һ���ǿգ�ǰ17���Ƿǿգ���ʱsize(A,1)�ǵ���18�����ǵ���17�����пռ���Ԫ���Ƿǿյģ���
%%%������������Ҫ�õ�����17������18��дѭ��������Ҫ�����cell����ǿ��е���Ŀ

BJ_empty=double(1);%%��ʼ��ͳ�Ʒǿ��еľ���BJ_empty
k=0;%%��ʼ��ͳ��ѭ��������k

 for j=1:size(temp_BJ_data,1) %%%����Ԫ������temp_BJ_data�����ÿһ��
      if isempty(temp_BJ_data{j,1})~=1%%���Ԫ������temp_BJ_data�������һ�еĵ�һ�е�Ԫ�ز��ǿգ�������{}��ȡ��cell�����Ԫ�أ���˿ռ�Ҳ�ܱ��ж�Ϊ�գ�
         k=k+1;%%��ô�ǿ��е�ͳ�ƾ�����1
      end
         BJ_empty(j,1)=k;
         k=0; 
 end
     
 %%%����temp_BJ_data�ľ������
 BJ_temp_dist=cell(size(BJ_empty,1),size(BJ_empty,1));%%%��ʼ���������temp_BJ_data�Ĵ�С�����ݸ�Сʱ�ǿ��е���Ŀ���й���
 
 k=1;
 for i=1:size(BJ_empty,1)
    for j=1:size(BJ_empty,1)
        %%%%����ŷʽ�������ÿ��վ�㵽����վ��ľ��루���������������һ�������ֵ��0��
        temp_BJ_data(i,k+11)=num2cell(sqrt((cell2mat(temp_BJ_data(i,3))-cell2mat(temp_BJ_data(j,3)))^2+(cell2mat(temp_BJ_data(i,4))-cell2mat(temp_BJ_data(j,4)))^2));
        k=k+1;
        
    end
    BJ_temp_dist(i,1:size(BJ_temp_dist,2))=num2cell(sort(cell2mat(temp_BJ_data(i,12:size(BJ_temp_dist,2)+11))));%%%%����BJ_temp_dist������һ�������sort���ľ���������ڲ�ѯ
    k=1;
 end
 
 %%%�������ĳһ�г���NaN����ô�����þ�������ҳ��ÿ�������վ�������4��վ��
 %%%���÷������Ȩ���PM2.5��PM10��O3
 
 k=5; %���������ڵ���2
 h=2; %������ľ��������
 pm25_fenzi=0;%��ʼ�������Ȩ����¶ȵķ���
 pm25_fenmu=0;%��ʼ�������Ȩ����¶ȵķ�ĸ
 pm10_fenzi=0;%��ʼ�������Ȩ���ѹǿ�ķ���
 pm10_fenmu=0;%��ʼ�������Ȩ���ѹǿ�ķ�ĸ
 O3_fenzi=0;%��ʼ�������Ȩ���ʪ�ȵķ���
 O3_fenmu=0;%��ʼ�������Ȩ���ʪ�ȵķ�ĸ
 
    for i=1:size(temp_BJ_data,1)%��35����������վ�ֱ�
        
        if isnan(cell2mat(temp_BJ_data(i,9))) %%�жϸÿ�������վ��PM2.5�Ƿ�ΪNaN
                for l=3:k+1 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵڶ���ʼ
                    if cell2mat(BJ_temp_dist(i,l))-cell2mat(BJ_temp_dist(i,2))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                        [~,n]=find(cell2mat(temp_BJ_data(i,12:46))==cell2mat(BJ_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                    
                        if ~isnan(cell2mat(temp_BJ_data(n,9)))%%����ҵ�������ٽ�վ�㲻��NaN
                        pm25_fenzi=pm25_fenzi+cell2mat(temp_BJ_data(n,9))/(cell2mat(temp_BJ_data(i,n+11))^h);%%�����ۼ�
                        pm25_fenmu=pm25_fenmu+1/(cell2mat(temp_BJ_data(i,n+11))^h);%%��ĸ�ۼ�
                        else
                        pm25_fenzi=pm25_fenzi+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                        pm25_fenmu=pm25_fenmu+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                        end
                    
                    elseif cell2mat(BJ_temp_dist(i,3))-cell2mat(BJ_temp_dist(i,2))>0.1 || cell2mat(BJ_temp_dist(i,3))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                        [~,n]=find(cell2mat(temp_BJ_data(i,12:46))==cell2mat(BJ_temp_dist(i,2)));%ֻ������������ڷ��٣�����ǡ�1��
                    
                        if ~isnan(cell2mat(temp_BJ_data(n,9)))%%����ҵ�������ٽ�վ�㲻��NaN
                            pm25_fenzi=pm25_fenzi+cell2mat(temp_BJ_data(n,9))/(cell2mat(temp_BJ_data(i,n+11))^h);%%�����ۼ�
                            pm25_fenmu=pm25_fenmu+1/(cell2mat(temp_BJ_data(i,n+11))^h);%%��ĸ�ۼ�
                        else 
                            pm25_fenzi=pm25_fenzi+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                            pm25_fenmu=pm25_fenmu+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                        end
                    end   
                end
                temp_BJ_data(i,9)=num2cell(pm25_fenzi/pm25_fenmu);%%������������ֵվ���PM2.5
        end
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PM10 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        
        if isnan(cell2mat(temp_BJ_data(i,10))) %%�жϸÿ�������վ��PM10�Ƿ�ΪNaN
                for l=3:k+1 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵڶ���ʼ
                    if cell2mat(BJ_temp_dist(i,l))-cell2mat(BJ_temp_dist(i,2))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                    [~,n]=find(cell2mat(temp_BJ_data(i,12:46))==cell2mat(BJ_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                    
                    if ~isnan(cell2mat(temp_BJ_data(n,10)))%%����ҵ�������ٽ�վ�㲻��NaN
                        pm10_fenzi=pm10_fenzi+cell2mat(temp_BJ_data(n,10))/(cell2mat(temp_BJ_data(i,n+11))^h);%%�����ۼ�
                        pm10_fenmu=pm10_fenmu+1/(cell2mat(temp_BJ_data(i,n+11))^h);%%��ĸ�ۼ�
                    
                    else
                        pm10_fenzi=pm10_fenzi+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                        pm10_fenmu=pm10_fenmu+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                    end
                    
                    elseif cell2mat(BJ_temp_dist(i,3))-cell2mat(BJ_temp_dist(i,2))>0.1 || cell2mat(BJ_temp_dist(i,3))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                    [~,n]=find(cell2mat(temp_BJ_data(i,12:46))==cell2mat(BJ_temp_dist(i,2)));%ֻ������������ڷ��٣�����ǡ�1��
                    
                    if ~isnan(cell2mat(temp_BJ_data(n,10)))%%����ҵ�������ٽ�վ�㲻��NaN
                        pm10_fenzi=pm10_fenzi+cell2mat(temp_BJ_data(n,10))/(cell2mat(temp_BJ_data(i,n+11))^h);%%�����ۼ�
                        pm10_fenmu=pm10_fenmu+1/(cell2mat(temp_BJ_data(i,n+11))^h);%%��ĸ�ۼ�
                    else 
                        pm10_fenzi=pm10_fenzi+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                        pm10_fenmu=pm10_fenmu+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                    end
                    end   
                end
                temp_BJ_data(i,10)=num2cell(pm10_fenzi/pm10_fenmu);%%������������ֵվ���PM10
        end
        
   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% O3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    
   
        if isnan(cell2mat(temp_BJ_data(i,11))) %%�жϸÿ�������վ��O3�Ƿ�ΪNaN
                for l=3:k+1 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵڶ���ʼ
                    if cell2mat(BJ_temp_dist(i,l))-cell2mat(BJ_temp_dist(i,2))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                    [~,n]=find(cell2mat(temp_BJ_data(i,12:46))==cell2mat(BJ_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                    
                    if ~isnan(cell2mat(temp_BJ_data(n,11)))%%����ҵ�������ٽ�վ�㲻��NaN
                        O3_fenzi=O3_fenzi+cell2mat(temp_BJ_data(n,11))/(cell2mat(temp_BJ_data(i,n+11))^h);%%�����ۼ�
                        O3_fenmu=O3_fenmu+1/(cell2mat(temp_BJ_data(i,n+11))^h);%%��ĸ�ۼ�
                    
                    else
                        O3_fenzi=O3_fenzi+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                        O3_fenmu=O3_fenmu+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                    end
                    
                    elseif cell2mat(BJ_temp_dist(i,3))-cell2mat(BJ_temp_dist(i,2))>0.1 || cell2mat(BJ_temp_dist(i,3))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                    [~,n]=find(cell2mat(temp_BJ_data(i,12:46))==cell2mat(BJ_temp_dist(i,2)));%ֻ������������ڷ��٣�����ǡ�1��
                    
                    if ~isnan(cell2mat(temp_BJ_data(n,11)))%%����ҵ�������ٽ�վ�㲻��NaN
                        O3_fenzi=O3_fenzi+cell2mat(temp_BJ_data(n,11))/(cell2mat(temp_BJ_data(i,n+11))^h);%%�����ۼ�
                        O3_fenmu=O3_fenmu+1/(cell2mat(temp_BJ_data(i,n+11))^h);%%��ĸ�ۼ�
                    else 
                        O3_fenzi=O3_fenzi+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                        O3_fenmu=O3_fenmu+0;%%�������ٽ�վ����NaN�Ļ����򲻼�����м���
                    end
                    end   
                end
                temp_BJ_data(i,11)=num2cell(O3_fenzi/O3_fenmu);%%������������ֵվ���O3
        end
        
        
        
    end
    
    temp_BJ_data_new=temp_BJ_data(1:35,1:11);%%�����������ǰ11�з��أ�Ҳ���ǲ�ֵ��Ľ��
    
end