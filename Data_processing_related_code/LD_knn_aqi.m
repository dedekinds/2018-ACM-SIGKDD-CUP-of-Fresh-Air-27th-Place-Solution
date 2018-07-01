function temp_LD_data_new=LD_knn_aqi(temp_LD_data)
%%%����temp_LD_data�ķǿ���������Ϊ��matlab��cell�����������棬���cell
%%%A�����һ���ǿգ�ǰ17���Ƿǿգ���ʱsize(A,1)�ǵ���18�����ǵ���17��
%%%������������Ҫ�õ�����17������18��дѭ��������Ҫ�����cell����ǿ��е���Ŀ

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
        
        temp_LD_data(i,k+11)=num2cell(sqrt((cell2mat(temp_LD_data(i,3))-cell2mat(temp_LD_data(j,3)))^2+(cell2mat(temp_LD_data(i,4))-cell2mat(temp_LD_data(j,4)))^2));
        k=k+1;
        
    end
    LD_temp_dist(i,1:size(LD_temp_dist,2))=num2cell(sort(cell2mat(temp_LD_data(i,12:size(LD_temp_dist,2)+11))));
    k=1;
 end
 
 %%%�������ĳһ�г���NaN����ô�����þ�������ҳ��ÿ�������վ�������4��վ��
 %%%���÷������Ȩ���PM2.5��PM10��NO2
 
 k=5; %���������ڵ���2
 h=2; %������ľ��������
 pm25_fenzi=0;%��ʼ�������Ȩ����¶ȵķ���
 pm25_fenmu=0;%��ʼ�������Ȩ����¶ȵķ�ĸ
 pm10_fenzi=0;%��ʼ�������Ȩ���ѹǿ�ķ���
 pm10_fenmu=0;%��ʼ�������Ȩ���ѹǿ�ķ�ĸ
 O3_fenzi=0;%��ʼ�������Ȩ���ʪ�ȵķ���
 O3_fenmu=0;%��ʼ�������Ȩ���ʪ�ȵķ�ĸ
 
 for i=1:LD_empty%��24����������վ�ֱ�
        if cell2mat(LD_temp_dist(i,2))~=0 %%�ж��Ƿ����ͬ���ľ�γ��
            if isnan(cell2mat(temp_LD_data(i,9))) %%�жϸÿ�������վ��PM2.5�Ƿ�ΪNaN
                    for l=3:k+1 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵ�2��ʼ��������3-1����2��
                        if cell2mat(LD_temp_dist(i,l))-cell2mat(LD_temp_dist(i,2))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                        [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                            if ~isnan(cell2mat(temp_LD_data(n,9)))
                        pm25_fenzi=pm25_fenzi+cell2mat(temp_LD_data(n,9))/(cell2mat(temp_LD_data(i,n+11))^h);
                        pm25_fenmu=pm25_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                            else
                        pm25_fenzi=pm25_fenzi+0;
                        pm25_fenmu=pm25_fenmu+0;
                            end
                    
                        elseif cell2mat(LD_temp_dist(i,3))-cell2mat(LD_temp_dist(i,2))>0.1 || cell2mat(LD_temp_dist(i,3))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                        [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,2)));%ֻ������������ڷ��٣�����ǡ�2��
                            if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                            end
                            if ~isnan(cell2mat(temp_LD_data(n,9)))
                            pm25_fenzi=pm25_fenzi+cell2mat(temp_LD_data(n,9))/(cell2mat(temp_LD_data(i,n+11))^h);
                            pm25_fenmu=pm25_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                            else 
                            pm25_fenzi=pm25_fenzi+0;
                            pm25_fenmu=pm25_fenmu+0;
                            end
                        end   
                    end
                temp_LD_data(i,9)=num2cell(pm25_fenzi/pm25_fenmu);
            end
        
            if isnan(cell2mat(temp_LD_data(i,10))) %%�жϸÿ�������վ��PM10�Ƿ�ΪNaN
                    for l=3:k+1 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵڶ���ʼ
                        if cell2mat(LD_temp_dist(i,l))-cell2mat(LD_temp_dist(i,2))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                        [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,10)))
                        pm10_fenzi=pm10_fenzi+cell2mat(temp_LD_data(n,10))/(cell2mat(temp_LD_data(i,n+11))^h);
                        pm10_fenmu=pm10_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                    
                        else
                        pm10_fenzi=pm10_fenzi+0;
                        pm10_fenmu=pm10_fenmu+0;
                        end
                    
                        elseif cell2mat(LD_temp_dist(i,3))-cell2mat(LD_temp_dist(i,2))>0.1 || cell2mat(LD_temp_dist(i,3))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                    [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,2)));%ֻ������������ڷ��٣�����ǡ�1��
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,10)))
                        pm10_fenzi=pm10_fenzi+cell2mat(temp_LD_data(n,10))/(cell2mat(temp_LD_data(i,n+11))^h);
                        pm10_fenmu=pm10_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                        else 
                        pm10_fenzi=pm10_fenzi+0;
                        pm10_fenmu=pm10_fenmu+0;
                        end
                        end   
                    end
                temp_LD_data(i,10)=num2cell(pm10_fenzi/pm10_fenmu);
            end
        
            if isnan(cell2mat(temp_LD_data(i,11))) %%�жϸÿ�������վ��PM10�Ƿ�ΪNaN
                    for l=3:k+1 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��������0�����Ҫ�ӵڶ���ʼ
                        if cell2mat(LD_temp_dist(i,l))-cell2mat(LD_temp_dist(i,2))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                    [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,11)))
                        O3_fenzi=O3_fenzi+cell2mat(temp_LD_data(n,11))/(cell2mat(temp_LD_data(i,n+11))^h);
                        O3_fenmu=O3_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                    
                        else
                        O3_fenzi=O3_fenzi+0;
                        O3_fenmu=O3_fenmu+0;
                        end
                    
                        elseif cell2mat(LD_temp_dist(i,3))-cell2mat(LD_temp_dist(i,2))>0.1 || cell2mat(LD_temp_dist(i,3))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                    [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,2)));%ֻ������������ڷ��٣�����ǡ�1��
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,11)))
                        O3_fenzi=O3_fenzi+cell2mat(temp_LD_data(n,11))/(cell2mat(temp_LD_data(i,n+11))^h);
                        O3_fenmu=O3_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                        else 
                        O3_fenzi=O3_fenzi+0;
                        O3_fenmu=O3_fenmu+0;
                        end
                        end   
                    end
                temp_LD_data(i,11)=num2cell(O3_fenzi/O3_fenmu);
            end
     %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%���������ͬ��γ��   
        else
            if isnan(cell2mat(temp_LD_data(i,9))) %%�жϸÿ�������վ��PM2.5�Ƿ�ΪNaN
                    for l=4:k+2 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��2��������0�����Ҫ�ӵ�3��ʼ��������4-1=3��
                        if cell2mat(LD_temp_dist(i,l))-cell2mat(LD_temp_dist(i,3))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                        [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                            if ~isnan(cell2mat(temp_LD_data(n,9)))
                        pm25_fenzi=pm25_fenzi+cell2mat(temp_LD_data(n,9))/(cell2mat(temp_LD_data(i,n+11))^h);
                        pm25_fenmu=pm25_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                            else
                        pm25_fenzi=pm25_fenzi+0;
                        pm25_fenmu=pm25_fenmu+0;
                            end
                    
                        elseif cell2mat(LD_temp_dist(i,4))-cell2mat(LD_temp_dist(i,3))>0.1 || cell2mat(LD_temp_dist(i,4))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                        [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(BJ_temp_dist(i,3)));%ֻ������������ڷ��٣�����ǡ�3��
                            if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                            end
                            if ~isnan(cell2mat(temp_LD_data(n,9)))
                            pm25_fenzi=pm25_fenzi+cell2mat(temp_LD_data(n,9))/(cell2mat(temp_LD_data(i,n+11))^h);
                            pm25_fenmu=pm25_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                            else 
                            pm25_fenzi=pm25_fenzi+0;
                            pm25_fenmu=pm25_fenmu+0;
                            end
                        end   
                    end
                temp_LD_data(i,9)=num2cell(pm25_fenzi/pm25_fenmu);
            end
        
            if isnan(cell2mat(temp_LD_data(i,10))) %%�жϸÿ�������վ��PM10�Ƿ�ΪNaN
                    for l=4:k+2 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��2��������0�����Ҫ�ӵ�3��ʼ��������4-1=3��
                        if cell2mat(LD_temp_dist(i,l))-cell2mat(LD_temp_dist(i,3))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                        [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,10)))
                        pm10_fenzi=pm10_fenzi+cell2mat(temp_LD_data(n,10))/(cell2mat(temp_LD_data(i,n+11))^h);
                        pm10_fenmu=pm10_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                    
                        else
                        pm10_fenzi=pm10_fenzi+0;
                        pm10_fenmu=pm10_fenmu+0;
                        end
                    
                        elseif cell2mat(LD_temp_dist(i,4))-cell2mat(LD_temp_dist(i,3))>0.1 || cell2mat(LD_temp_dist(i,4))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                    [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,3)));%ֻ������������ڷ��٣�����ǡ�1��
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,10)))
                        pm10_fenzi=pm10_fenzi+cell2mat(temp_LD_data(n,10))/(cell2mat(temp_LD_data(i,n+11))^h);
                        pm10_fenmu=pm10_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                        else 
                        pm10_fenzi=pm10_fenzi+0;
                        pm10_fenmu=pm10_fenmu+0;
                        end
                        end   
                    end
                temp_LD_data(i,10)=num2cell(pm10_fenzi/pm10_fenmu);
            end
        
            if isnan(cell2mat(temp_LD_data(i,11))) %%�жϸÿ�������վ��O3�Ƿ�ΪNaN
                    for l=4:k+2 %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���,���ڵ�1��2��������0�����Ҫ�ӵ�3��ʼ��������4-1=3��
                        if cell2mat(LD_temp_dist(i,l))-cell2mat(LD_temp_dist(i,3))<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
                    [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,l-1)));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,11)))
                        O3_fenzi=O3_fenzi+cell2mat(temp_LD_data(n,11))/(cell2mat(temp_LD_data(i,n+11))^h);
                        O3_fenmu=O3_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                    
                        else
                        O3_fenzi=O3_fenzi+0;
                        O3_fenmu=O3_fenmu+0;
                        end
                    
                        elseif cell2mat(LD_temp_dist(i,4))-cell2mat(LD_temp_dist(i,3))>0.1 || cell2mat(LD_temp_dist(i,4))>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
                    [~,n]=find(cell2mat(temp_LD_data(i,LD_num+1:LD_num+LD_num_1))==cell2mat(LD_temp_dist(i,3)));%ֻ������������ڷ��٣�����ǡ�3��
                        if size(n,2)==2
                            n=n(1); %%%�����׶���2�ԣ���4��վ����ͬ��γ�ȵģ����Ѱ�ҵ�ʱ����ҵ�����λ�ã����±���
                        end
                        if ~isnan(cell2mat(temp_LD_data(n,11)))
                        O3_fenzi=O3_fenzi+cell2mat(temp_LD_data(n,11))/(cell2mat(temp_LD_data(i,n+11))^h);
                        O3_fenmu=O3_fenmu+1/(cell2mat(temp_LD_data(i,n+11))^h);
                        else 
                        O3_fenzi=O3_fenzi+0;
                        O3_fenmu=O3_fenmu+0;
                        end
                        end   
                    end
                temp_LD_data(i,11)=num2cell(O3_fenzi/O3_fenmu);
            end
        end
end
    
    temp_LD_data_new=temp_LD_data(1:size(temp_LD_data),1:11);
 
end