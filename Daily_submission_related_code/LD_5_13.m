% %%%%ÿ������ѵ�����׶�aqi-meo���ݱ������
% 
% %%%�������Ӧ�ľ�γ��������ӵ�4�·��µ��׶��������ݱ������
% clear
% LD=readtable('ld_meo_2018-05-13.csv');%a��վ��˳�򣬲���ɾ������״���ͷ���ɾȥstation_id
% LD = sortrows(LD,'station_id','ascend');
% LD_grid=readtable('London_meo_grid.csv');
% 
% %%%��4�·ݵ������ݰ���grid����
% tic
% temp_grid=table2cell(LD(1,1)); %��ʼ����һ�����ڷ����grid����
% LD_data=cell(5,8,10);%��ʼ����άԪ������
% LD_num=1;%վ����Ŀ
% j=1;%��¼ѭ����ÿ����άԪ�����������к�
% for i = 1:size(LD,1)
%       if mod(i,1000)==0 %�۲��㷨�������ٶ�
%        i  
%       end
%       if isequal(temp_grid, table2cell(LD(i,1)))
%            LD_data(j,1:8,LD_num)=table2cell(LD(i,1:8));
%            j=j+1;
%       else
%            temp_grid=table2cell(LD(i,1));
%            LD_num=LD_num + 1;
%            LD_data(1,1:8,LD_num)=table2cell(LD(i,1:8));
%            j=2;
%       end
% end
% toc
% 
% %%%����Ӧ�ľ�γ��������ӵ�LD_data��9,10��
% 
% for i=1:size(LD_data,3)
%    
%      LD_data(1:size(LD_data(:,:,i),1),9:11,i)=repmat(table2cell(LD_grid(i,1:3)),size(LD_data(:,:,i),1),1);
%     
% end
% 
% %%�ϲ�
% tic
% LD_temperature=LD_data(:,:,1);
% for j=2:LD_num
%        j     
%     LD_temperature=cat(1,LD_temperature,LD_data(:,:,j));
% end
% 
% toc
% 
% LD_temperature=cell2table(LD_temperature);
% 
% %%%����csv�Ժ�ǵ�ȥɾ���հ���
% tic
% writetable(LD_temperature,'LD_5_13_with_location.csv','Delimiter',',','QuoteStrings',true)
% toc
% 
% %%%%%%%���׶�4�·������������ݣ�18.3.31-18.4.12���������׶ؿ�������վ��λ�ã�ȷ��ÿ����������վ������4������㣬��ȡ������ȥ��(unique()��������ȥ��)
% %%%%%%%���Ի��һ���򻯺�Ĳ��Լ���ΪԤ����һСʱ�������ݵĲ��Լ���Ҳ����������������ܱ����÷������Ȩ
% 
% clear
% tic
% LD=readtable('LD_5_13_with_location_new.csv');%%%�����׶���ʷ�����������ݣ��ϴ�ǰҪ��ʱ�����򣬲���ɾ���κ��У�һ��11��
% LD_AQ_Stations=readtable('London_AirQuality_Stations.csv');
% LD_AQ_Stations = sortrows(LD_AQ_Stations,'Longitude','ascend');
% toc
% 
% LD(:,'LD_temperature3') = [];
% LD(:,'LD_temperature9') = [];
% LD = LD(:,[1 8 2:7 end]);
% LD = LD(:,[1:2 9 3:8]);
% 
% %%%��4�·ݵ������ݰ���utc_time����
% tic
% temp_utc=table2cell(LD(1,4)); %��ʼ����һ�����ڷ����utc_time����
% LD_data=cell(861,size(LD,2),5);%��ʼ����άԪ������
% LD_num=1;%վ����Ŀ
% j=1;%��¼ѭ����ÿ����άԪ�����������к�
% for i = 1:size(LD,1)
%       if mod(i,1000)==0 %�۲��㷨�������ٶ�
%        i  
%       end
%       if isequal(temp_utc, table2cell(LD(i,4)))
%            LD_data(j,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
%            j=j+1;
%       else
%            temp_utc=table2cell(LD(i,4));
%            LD_num=LD_num + 1;
%            LD_data(1,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
%            j=2;
%       end
% end
% toc
% 
% 
% %%���ÿ����������վ���ڽ�4�����
% tic
% grid_data=cell(96,9,5);
% LD_grid_step=1;
% for i=1:size(LD_data,3)
%     if mod(i,861*18)==1 %�۲��㷨�������ٶ�
%        i  
%      end
%    for j=1:size(LD_AQ_Stations,1)
%        temp_lon_index=(floor((table2array(LD_AQ_Stations(j,6))-(-2))/0.1))*21+1;
%        temp_lat_index=floor((table2array(LD_AQ_Stations(j,5))-(50.5000))/0.1);
%        temp_index_1=temp_lon_index+temp_lat_index;
%        grid_data(LD_grid_step,1:9,i)=LD_data(temp_index_1,1:9,i);
%        temp_index_2=temp_index_1+21;
%        LD_grid_step=LD_grid_step+1;
%        grid_data(LD_grid_step,1:9,i)=LD_data(temp_index_2,1:9,i);
%        temp_index_3=temp_index_1+1;
%        LD_grid_step=LD_grid_step+1;
%        grid_data(LD_grid_step,1:9,i)=LD_data(temp_index_3,1:9,i);
%        temp_index_4=temp_index_2+1;
%        LD_grid_step=LD_grid_step+1;
%        grid_data(LD_grid_step,1:9,i)=LD_data(temp_index_4,1:9,i);
%        LD_grid_step=LD_grid_step+1;
%    end
%    LD_grid_step=1;
% end
% toc
% 
% %%Ϊgrid_data(:,:,1)���һ�о��룬ÿ4�ж�Ӧ��һ��aqi�۲�վ���ֱ��������ж�Ӧ�ĸ�����굽��aqi�۲�վ�ľ���
% %%һ��24���۲�վ��ע����ҪԤ���ֻ��13����
% 
% temp_grid_data=grid_data(:,:,1); %%����������û�д������ں����ļ���
% temp_grid_data_2=grid_data(:,:,2);
% LD_AQ_Stations_temp=table2cell(LD_AQ_Stations);
% j=1;
% for i=1:4:size(temp_grid_data,1) 
%         temp_grid_data(i,10)=num2cell(sqrt((cell2mat(LD_AQ_Stations_temp(j,5))-cell2mat(temp_grid_data(i,3)))^2+(cell2mat(LD_AQ_Stations_temp(j,6))-cell2mat(temp_grid_data(i,2)))^2));
%         temp_grid_data(i+1,10)=num2cell(sqrt((cell2mat(LD_AQ_Stations_temp(j,5))-cell2mat(temp_grid_data(i+1,3)))^2+(cell2mat(LD_AQ_Stations_temp(j,6))-cell2mat(temp_grid_data(i+1,2)))^2));
%         temp_grid_data(i+2,10)=num2cell(sqrt((cell2mat(LD_AQ_Stations_temp(j,5))-cell2mat(temp_grid_data(i+2,3)))^2+(cell2mat(LD_AQ_Stations_temp(j,6))-cell2mat(temp_grid_data(i+2,2)))^2));
%         temp_grid_data(i+3,10)=num2cell(sqrt((cell2mat(LD_AQ_Stations_temp(j,5))-cell2mat(temp_grid_data(i+3,3)))^2+(cell2mat(LD_AQ_Stations_temp(j,6))-cell2mat(temp_grid_data(i+3,2)))^2));
%         j=j+1;
% end
% 
% 
% %%��temp_grid_data(:,:,10)���Ƶ�ʣ�������Ԫ���������棨��Ϊÿһ����άԪ������������ڽ���㶼����ͬ�ģ���˼�����ͬ��
% %%����10806����άԪ�����鶼������һ�о���
% 
% grid_data(:,10,1)=temp_grid_data(:,10,1);
% temp_grid_data_distance=grid_data(:,10);
% for i=2:size(grid_data,3)
%         grid_data(:,10,i)=grid_data(:,10,1);
% end
% 
% %%%������ƽ������¶ȡ�ʪ�ȡ�ѹǿ
% tic
% for j=1:size(grid_data,3)
%     for i=1:4:size(grid_data(:,:,j),1)
%         grid_data(i,11,j)=num2cell(cell2mat(grid_data(i,5,j))/(cell2mat(grid_data(i,10,j)))^2);%%%�¶ȳ��Ծ����ƽ��
%         grid_data(i+1,11,j)=num2cell(cell2mat(grid_data(i+1,5,j))/cell2mat(grid_data(i+1,10,j))^2);
%         grid_data(i+2,11,j)=num2cell(cell2mat(grid_data(i+2,5,j))/cell2mat(grid_data(i+2,10,j))^2);
%         grid_data(i+3,11,j)=num2cell(cell2mat(grid_data(i+3,5,j))/cell2mat(grid_data(i+3,10,j))^2);
%         
%         grid_data(i,12,j)=num2cell(cell2mat(grid_data(i,6,j))/cell2mat(grid_data(i,10,j))^2);%%ѹǿ���Ծ����ƽ��
%         grid_data(i+1,12,j)=num2cell(cell2mat(grid_data(i+1,6,j))/cell2mat(grid_data(i+1,10,j))^2);
%         grid_data(i+2,12,j)=num2cell(cell2mat(grid_data(i+2,6,j))/cell2mat(grid_data(i+2,10,j))^2);
%         grid_data(i+3,12,j)=num2cell(cell2mat(grid_data(i+3,6,j))/cell2mat(grid_data(i+3,10,j))^2);
%         
%         grid_data(i,13,j)=num2cell(cell2mat(grid_data(i,7,j))/cell2mat(grid_data(i,10))^2);%%ʪ�ȳ��Ծ����ƽ��
%         grid_data(i+1,13,j)=num2cell(cell2mat(grid_data(i+1,7,j))/cell2mat(grid_data(i+1,10,j))^2);
%         grid_data(i+2,13,j)=num2cell(cell2mat(grid_data(i+2,7,j))/cell2mat(grid_data(i+2,10,j))^2);
%         grid_data(i+3,13,j)=num2cell(cell2mat(grid_data(i+3,7,j))/cell2mat(grid_data(i+3,10,j))^2);
%     end
% end
% toc
% 
% %%�½�һ��3άԪ�����ݴ洢�׶ؿ�������վ����+��Ӧ����վ����
% tic
% LD_aqi_stations_data=cell(24,13,size(grid_data,3));
% for i=1:size(grid_data,3)
%         LD_aqi_stations_data(:,1:8,i)=table2cell(LD_AQ_Stations(:,1:8));
% end
% toc
% 
% tic
% k=1;
% for j=1:size(grid_data,3)
%      if mod(j,1000)==0 %�۲��㷨�������ٶ�
%        j  
%      end
%     for i=1:4:size(grid_data(:,:,j),1)
%         
%          LD_aqi_stations_data(k,9,j)=grid_data(1,4,j);
%          temp_fenzi=cell2mat(grid_data(i,11,j))+cell2mat(grid_data(i+1,11,j))+cell2mat(grid_data(i+2,11,j))+cell2mat(grid_data(i+3,11,j));
%          temp_fenmu=1/(cell2mat(grid_data(i,10,j))^2)+1/(cell2mat(grid_data(i+1,10,j))^2)+1/(cell2mat(grid_data(i+2,10,j))^2)+1/(cell2mat(grid_data(i+3,10,j))^2);
%          
%          avg_temp=temp_fenzi/temp_fenmu;
%          LD_aqi_stations_data(k,10,j)=num2cell(avg_temp);%��4�������������¶�ƽ��ֵ���ڵ�10��
%          
%          pressure_fenzi=cell2mat(grid_data(i,12,j))+cell2mat(grid_data(i+1,12,j))+cell2mat(grid_data(i+2,12,j))+cell2mat(grid_data(i+3,12,j));
%          pressure_fenmu=1/(cell2mat(grid_data(i,10,j))^2)+1/(cell2mat(grid_data(i+1,10,j))^2)+1/(cell2mat(grid_data(i+2,10,j))^2)+1/(cell2mat(grid_data(i+3,10,j))^2);
%          
%          avg_pressure=pressure_fenzi/pressure_fenmu;
%          LD_aqi_stations_data(k,11,j)=num2cell(avg_pressure);%��4������������ѹǿƽ��ֵ���ڵ�11��
%          
%          humidity_fenzi=cell2mat(grid_data(i,13,j))+cell2mat(grid_data(i+1,13,j))+cell2mat(grid_data(i+2,13,j))+cell2mat(grid_data(i+3,13,j));
%          humidity_fenmu=1/(cell2mat(grid_data(i,10,j))^2)+1/(cell2mat(grid_data(i+1,10,j))^2)+1/(cell2mat(grid_data(i+2,10,j))^2)+1/(cell2mat(grid_data(i+3,10,j))^2);
%          
%          avg_humidity=humidity_fenzi/humidity_fenmu;
%          LD_aqi_stations_data(k,12,j)=num2cell(avg_humidity);%��4������������ʪ��ƽ��ֵ���ڵ�12��
%          
%          k=k+1;
%     end
%     k=1;
% end
% toc
% 
% %%%%����u-v�ֽ⣬�ֽ�󱣴浽grid_data��14,15��
% tic
% for j=1:size(grid_data,3)
%         for i=1:4:size(grid_data(:,:,j),1)
%         %(cell2mat(grid_data(i,9,j)) * sind(cell2mat(grid_data(i,8,j))));%u�������
%         %(cell2mat(grid_data(i,9,j)) * cosd(cell2mat(grid_data(i,8,j))));%u�������
%         
%         grid_data(i,14,j)=num2cell((cell2mat(grid_data(i,9,j)) * sind(cell2mat(grid_data(i,8,j))))/(cell2mat(grid_data(i,10,j)))^2);%%%u������ٳ��Ծ����ƽ��
%         grid_data(i+1,14,j)=num2cell((cell2mat(grid_data(i+1,9,j)) * sind(cell2mat(grid_data(i,8,j))))/cell2mat(grid_data(i+1,10,j))^2);
%         grid_data(i+2,14,j)=num2cell((cell2mat(grid_data(i+2,9,j)) * sind(cell2mat(grid_data(i,8,j))))/cell2mat(grid_data(i+2,10,j))^2);
%         grid_data(i+3,14,j)=num2cell((cell2mat(grid_data(i+3,9,j)) * sind(cell2mat(grid_data(i,8,j))))/cell2mat(grid_data(i+3,10,j))^2);
%         
%         grid_data(i,15,j)=num2cell((cell2mat(grid_data(i,9,j)) * cosd(cell2mat(grid_data(i,8,j))))/(cell2mat(grid_data(i,10,j)))^2);%%%v������ٳ��Ծ����ƽ��
%         grid_data(i+1,15,j)=num2cell((cell2mat(grid_data(i+1,9,j)) * cosd(cell2mat(grid_data(i,8,j))))/cell2mat(grid_data(i+1,10,j))^2);
%         grid_data(i+2,15,j)=num2cell((cell2mat(grid_data(i+2,9,j)) * cosd(cell2mat(grid_data(i,8,j))))/cell2mat(grid_data(i+2,10,j))^2);
%         grid_data(i+3,15,j)=num2cell((cell2mat(grid_data(i+3,9,j)) * cosd(cell2mat(grid_data(i,8,j))))/cell2mat(grid_data(i+3,10,j))^2);
%         end
% end
% toc
% 
% %%��u-v������ӵ�LD_aqi_stations_data��13,14�У���15�м���ϲ�����
% tic
% k=1;
% for j=1:size(grid_data,3)
%      if mod(j,1000)==0 %�۲��㷨�������ٶ�
%        j  
%      end
%     for i=1:4:size(grid_data(:,:,j),1)
%          %%�����Ȩƽ�����u�������
%          u_fenzi=cell2mat(grid_data(i,14,j))+cell2mat(grid_data(i+1,14,j))+cell2mat(grid_data(i+2,14,j))+cell2mat(grid_data(i+3,14,j));
%          u_fenmu=1/(cell2mat(grid_data(i,10,j))^2)+1/(cell2mat(grid_data(i+1,10,j))^2)+1/(cell2mat(grid_data(i+2,10,j))^2)+1/(cell2mat(grid_data(i+3,10,j))^2);
%          
%          avg_u=u_fenzi/u_fenmu;
%          LD_aqi_stations_data(k,13,j)=num2cell(avg_u);
%          
%          %%�����Ȩƽ�����v�������
%          v_fenzi=cell2mat(grid_data(i,15,j))+cell2mat(grid_data(i+1,15,j))+cell2mat(grid_data(i+2,15,j))+cell2mat(grid_data(i+3,15,j));
%          v_fenmu=1/(cell2mat(grid_data(i,10,j))^2)+1/(cell2mat(grid_data(i+1,10,j))^2)+1/(cell2mat(grid_data(i+2,10,j))^2)+1/(cell2mat(grid_data(i+3,10,j))^2);
%          avg_v=v_fenzi/v_fenmu;
%          LD_aqi_stations_data(k,14,j)=num2cell(avg_v);
%          
%          %%�ϳɷ���
%          LD_aqi_stations_data(k,15,j)=num2cell(sqrt((avg_u)^2+(avg_v)^2));
%          
%          k=k+1;
%     end
%     k=1;
% end
% toc
% 
% %%��������ӵ�LD_aqi_stations_data��16��
% tic
% for j=1:size(grid_data,3)
%     for i=1:24
%             if cell2mat(LD_aqi_stations_data(i,13,j))>0 && cell2mat(LD_aqi_stations_data(i,14,j))>0
%             LD_aqi_stations_data(i,16,j)=num2cell((atan(cell2mat(LD_aqi_stations_data(i,13,j))/cell2mat(LD_aqi_stations_data(i,14,j)))/pi)*180);
%             elseif cell2mat(LD_aqi_stations_data(i,13,j))>0 && cell2mat(LD_aqi_stations_data(i,14,j))<0
%             LD_aqi_stations_data(i,16,j)= num2cell((atan(cell2mat(LD_aqi_stations_data(i,13,j))/cell2mat(LD_aqi_stations_data(i,14,j)))/pi)*180+180);
%             elseif cell2mat(LD_aqi_stations_data(i,13,j))<0 && cell2mat(LD_aqi_stations_data(i,14,j))<0
%             LD_aqi_stations_data(i,16,j)=num2cell((atan(cell2mat(LD_aqi_stations_data(i,13,j))/cell2mat(LD_aqi_stations_data(i,14,j)))/pi)*180+180);
%             elseif cell2mat(LD_aqi_stations_data(i,13,j))<0 && cell2mat(LD_aqi_stations_data(i,14,j))>0 
%             LD_aqi_stations_data(i,16,j)=num2cell((atan(cell2mat(LD_aqi_stations_data(i,13,j))/cell2mat(LD_aqi_stations_data(i,14,j)))/pi)*180+360);
%             elseif cell2mat(LD_aqi_stations_data(i,13,j))==0 && cell2mat(LD_aqi_stations_data(i,14,j))>0
%             LD_aqi_stations_data(i,16,j)=num2cell(0);
%             elseif cell2mat(LD_aqi_stations_data(i,13,j))==0 && cell2mat(LD_aqi_stations_data(i,14,j))<0
%             LD_aqi_stations_data(i,16,j)=num2cell(180);  
%             elseif cell2mat(LD_aqi_stations_data(i,13,j))>0 && cell2mat(LD_aqi_stations_data(i,14,j))==0
%             LD_aqi_stations_data(i,16,j)=num2cell(90);
%             elseif cell2mat(LD_aqi_stations_data(i,13,j))<0 && cell2mat(LD_aqi_stations_data(i,14,j))==0
%             LD_aqi_stations_data(i,16,j)=num2cell(270);
%             else
%             LD_aqi_stations_data(i,16,j)=Null;
%             end
%     end
% end
% toc
% 
% %%%�ϲ��׶�aqi-meo�ܱ�
% 
% London_station_data_aqi=unique(cell2table(LD_aqi_stations_data(:,:,1)));
% tic
% for j=2:size(grid_data,3)
%        if mod(j,1000)==0 %�۲��㷨�������ٶ�
%             j
%        end   
%     London_station_data_aqi=cat(1,London_station_data_aqi,cell2table(LD_aqi_stations_data(:,:,j)));
% end
% toc
% 
% tic
% writetable(London_station_data_aqi,'London_5_13_get_test_data.csv','Delimiter',',','QuoteStrings',true)
% toc
% 
% %%%%%%%%%%%%��aqi-meo�ܱ�
% 
% clear
% tic
% LD_aqi_forecast=readtable('ld_aqi_2018-05-13.csv');%%%�����׶���ʷ�����������ݣ�ͨ��api��ȡ�Ժ󣬱���վ�㡢��γ�ȡ�PM2.5��PM10��NO2
% LD_aqi_forecast = sortrows(LD_aqi_forecast,'station_id','ascend');
% toc
% a=LD_aqi_forecast;
% 
% 
% %%��London_aqi�ܱ��utc_time�ָ�
% temp=table2array(a(:,2));
% vec=datevec(temp);
% vec1=num2cell(vec);
% a(:,6:9)=vec1(:,1:4);
% a = a(:,[1 6 2:5 7:end]);
% a = a(:,[1:2 7 3:6 8:end]);
% a = a(:,[1:3 8 4:7 end]);
% a = a(:,[1:4 9 5:8]);
% a(:,'time') = [];
% 
% %%��London_meo�ܱ��utc_time�ָ�
% London_station_data_aqi=readtable('London_5_13_get_test_data_new.csv');%%ע��Ҫֻ����aqi��Ϊtrue�ı��Ҳ���ǵ�һ��Ϊtrue
% London_station_data_aqi = sortrows(London_station_data_aqi,'Var1','ascend');
% temp=table2array(London_station_data_aqi(:,9));
% vec=datevec(temp);
% vec1=num2cell(vec);
% London_station_data_aqi(:,17:22)=vec1(:,1:6);
% London_station_data_aqi = London_station_data_aqi(:,[1 17 2:16 18:end]);
% London_station_data_aqi = London_station_data_aqi(:,[1:2 18 3:17 19:end]);
% London_station_data_aqi = London_station_data_aqi(:,[1:3 19 4:18 20:end]);
% London_station_data_aqi = London_station_data_aqi(:,[1:4 20 5:19 21:end]);
% London_station_data_aqi(:,'Var21') = [];
% London_station_data_aqi(:,'Var22') = [];
% 
% %%%��aqi�ܱ���վ�����
% tic
% temp_station_name=table2cell(a(1,1)); %��ʼ����һ�����ڷ������������
% LD_data=cell(5,8,5);%��ʼ����άԪ������
% LD_num=1;%վ����Ŀ
% j=1;%��¼ѭ����ÿ����άԪ�����������к�
% for i = 1:size(a,1)
%       if mod(i,1000)==0 %�۲��㷨�������ٶ�
%        i  
%       end
%       if isequal(temp_station_name, table2cell(a(i,1)))
%            LD_data(j,:,LD_num)=table2cell(a(i,:));
%            j=j+1;
%       else
%            temp_station_name=table2cell(a(i,1));
%            LD_num=LD_num + 1;
%            LD_data(1,:,LD_num)=table2cell(a(i,:));
%            j=2;
%       end
% end
% toc
% 
% %%��meo�ܱ�վ�����
% tic
% temp_station_name=table2cell(London_station_data_aqi(1,1)); %��ʼ����һ�����ڷ������������
% LD_meo_data=cell(5,20,5);%��ʼ����άԪ������
% LD_num=1;%վ����Ŀ
% j=1;%��¼ѭ����ÿ����άԪ�����������к�
% for i = 1:size(London_station_data_aqi,1)
%       if mod(i,1000)==0 %�۲��㷨�������ٶ�
%        i  
%       end
%       if isequal(temp_station_name, table2cell(London_station_data_aqi(i,1)))
%            LD_meo_data(j,:,LD_num)=table2cell(London_station_data_aqi(i,:));
%            j=j+1;
%       else
%            temp_station_name=table2cell(London_station_data_aqi(i,1));
%            LD_num=LD_num + 1;
%            LD_meo_data(1,:,LD_num)=table2cell(London_station_data_aqi(i,:));
%            j=2;
%       end
% end
% toc
% 
% %%%% �ϲ�aqi-meo�������
% tic
% k=1;
% for i=1:19
%     i
%     for j=1:size(LD_data(:,:,i),1)
%         for  k =1:size(LD_meo_data(:,:,i),1)
%             if isequal(LD_meo_data(k,1,i),LD_data(j,1,i)) && isequal(LD_meo_data(k,2,i),LD_data(j,2,i)) ...
%         && isequal(LD_meo_data(k,3,i),LD_data(j,3,i)) && isequal(LD_meo_data(k,4,i),LD_data(j,4,i)) ...
%         && isequal(LD_meo_data(k,5,i),LD_data(j,5,i))  
%                
%         LD_data(j,9:23,i)=LD_meo_data(k,6:20,i);
%             end
%         end
%     end
% end
% toc
% 
%  %%�ϲ�
% tic
% LD_temperature=LD_data(:,:,1);
% for j=2:LD_num
%        j     
%     LD_temperature=cat(1,LD_temperature,LD_data(:,:,j));
% end
% 
% toc
% 
% LD_temperature=cell2table(LD_temperature);
% 
% %%%����csv�Ժ�ǵ�ȥɾ���հ���
% tic
% writetable(LD_temperature,'LD_5_13_test_full_result.csv','Delimiter',',','QuoteStrings',true)
% %writetable(LD,'LD_temperature.txt','Delimiter',',')
% toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
tic
LD=readtable('LD_5_31_test_full_result_sort_time.csv');%%%����֮ǰ�Ƚ�PM2.5��PM10��O3�ĸ�ֵ���NaN
toc

LD(:,{'LD_temperature9','LD_temperature10','LD_temperature11','LD_temperature14','LD_temperature15','LD_temperature20','LD_temperature21'}) = [];
LD(:,{'LD_temperature2','LD_temperature3','LD_temperature4','LD_temperature5'}) = [];
LD = LD(:,[1 5 2:4 6:end]);
LD = LD(:,[1 6 2:5 7:end]);
LD = LD(:,[1 7 2:6 8:end]);
LD = LD(:,[1:4 6:11 5 end]);
LD = LD(:,[1:4 6:11 5 end]);
LD = LD(:,[1:4 6:11 5 end]);

%%���׶ذ���utc_time�����飬�γ���άԪ������
tic
temp_utc_time=table2cell(LD(1,2)); %��ʼ����һ�����ڷ����aqi_station
LD_data=cell(5,size(LD,2),10);%��ʼ����άԪ������
LD_num=1;%վ����Ŀ
j=1;%��¼ѭ����ÿ����άԪ�����������к�
for i = 1:size(LD,1)
      if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
      end
      if isequal(temp_utc_time, table2cell(LD(i,2)))
           LD_data(j,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
           j=j+1;
      else
           temp_utc_time=table2cell(LD(i,2));
           LD_num=LD_num + 1;
           LD_data(1,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
           j=2;
      end
end
toc

%%���׶ص�PM2.5��PM10��O3���տռ�����ڽ��з������Ȩ��ֵ��ע���׶�ʵ������û��O3�ģ����Ҫȥ����
temp_LD_data_new=cell(size(LD_data));
tic
for i=1:size(LD_data,3)
        
         i  
  
        temp_LD_data_new(:,1:11,i)=LD_knn_aqi(LD_data(:,1:11,i));
        temp_LD_data_new(:,12,i)=LD_data(:,12,i);
end
toc

%%���ٽ�4��վ��ķ��١�����PM2.5��PM10����12�еĺ���

temp_LD_data=temp_LD_data_new(:,:,1);%%%���Ժ���LD_knn_aqi_station��
temp_LD_data_new_beta=temp_LD_data_new;%%%����

temp_LD_data_new_new=cell(size(LD_data,1),48,size(LD_data,3));
tic
for i=1:size(temp_LD_data_new,3)
         i 
         if ~isnan(cell2mat(temp_LD_data_new(1,3,i)))
        temp_LD_data_new_new(:,1:48,i)=LD_knn_full_aqi_station(temp_LD_data_new(:,:,i));
        end
end
toc
temp_LD_data_new_1=temp_LD_data_new_new(:,:,1);

%%�ϲ�
tic
LD_temperature_new=temp_LD_data_new_new(:,:,1);
for j=2:size(temp_LD_data_new_new,3)
       j     
    LD_temperature_new=cat(1,LD_temperature_new,temp_LD_data_new_new(:,:,j));
end

toc

LD_temperature_new=cell2table(LD_temperature_new);
%%%%%����csv�ļ�ɾ������
tic
writetable(LD_temperature_new,'5_31_LD_data_75_model_full_result_with_NO2.csv');
toc

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear
tic
LD=readtable('5_31_LD_data_75_model_full_result_with_NO2_new_without_sort_winddirection_encoding.csv');%%%��aqiվ������
toc

%%���׶ذ���aqiվ�������飬�γ���άԪ������
tic
temp_aqi_station=table2cell(LD(1,1)); %��ʼ����һ�����ڷ����aqi_station
LD_data=cell(5,size(LD,2),10);%��ʼ����άԪ������
LD_num=1;%վ����Ŀ
j=1;%��¼ѭ����ÿ����άԪ�����������к�
for i = 1:size(LD,1)
      if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
      end
      if isequal(temp_aqi_station, table2cell(LD(i,1)))
           LD_data(j,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
           j=j+1;
      else
           temp_aqi_station=table2cell(LD(i,1));
           LD_num=LD_num + 1;
           LD_data(1,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
           j=2;
      end
end
toc

% %%%%%%��5-36��
% %%���¶ȡ�ѹǿ��ʪ�ȡ����١�����PM2.5��PM10��O3�Լ�4���ٽ�վ���PM2.5��PM10��O3�����١�����
% %%�ƶ�8��
% 
% timestep=8;
% for i=1:size(LD_data,3) 
%     for k=1:timestep
%         for j=1:size(LD_data(:,:,i),1)-1
%             LD_data(j,37+32*(k-1):68+32*(k-1),i)=LD_data(j+1,5+32*(k-1):36+32*(k-1),i);
%         end
%     end
% end
% 
% %temp_LD_data_1=LD_data(:,:,1);
% 
% %LD_data_alpha=LD_data;%%%����
% 
% %%�ϲ�
% tic
% LD_temperature=LD_data(:,:,1);
% for j=2:LD_num
%        j     
%     LD_temperature=cat(1,LD_temperature,LD_data(:,:,j));
% end
% 
% toc
% 
% LD_temperature=cell2table(LD_temperature);
% 
% 
% %%%%%%%%������ͳһ�ƶ������
% tic
% LD_temperature = LD_temperature(:,[1:267 269:292 268]);
% LD_temperature = LD_temperature(:,[1:235 237:292 236]);
% LD_temperature = LD_temperature(:,[1:203 205:292 204]);
% LD_temperature = LD_temperature(:,[1:171 173:292 172]);
% LD_temperature = LD_temperature(:,[1:139 141:292 140]);
% LD_temperature = LD_temperature(:,[1:107 109:292 108]);
% LD_temperature = LD_temperature(:,[1:75 77:292 76]);
% LD_temperature = LD_temperature(:,[1:43 45:292 44]);
% LD_temperature = LD_temperature(:,[1:11 13:292 12]);
% toc
% %LD_temperature_beta=LD_temperature;%%%����
% %LD_temperature=LD_temperature_beta;%%%��ԭ
% 
% %%%%%%%�������Сʱ���ڽ�վ���pm2.5��pm10��O3�����٣������ƶ������
% tic
% LD_temperature = LD_temperature(:,[1:259 284:292 260:283]);
% LD_temperature = LD_temperature(:,[1:228 253:292 229:252]);
% LD_temperature = LD_temperature(:,[1:197 222:292 198:221]);
% LD_temperature = LD_temperature(:,[1:166 191:292 167:190]);
% LD_temperature = LD_temperature(:,[1:135 160:292 136:159]);
% toc
% %LD_temperature_alpha=LD_temperature;%%����
% 
% %%%%%%%��ǰ4Сʱ���ڽ�վ�������ȫ��ɾȥ
% tic
% LD_temperature(:,{'LD_temperature109','LD_temperature110','LD_temperature111','LD_temperature112','LD_temperature113','LD_temperature114','LD_temperature115','LD_temperature116','LD_temperature117','LD_temperature118','LD_temperature119','LD_temperature120','LD_temperature121','LD_temperature122','LD_temperature123','LD_temperature124','LD_temperature125','LD_temperature126','LD_temperature127','LD_temperature128','LD_temperature129','LD_temperature130','LD_temperature131','LD_temperature132'}) = [];
% LD_temperature(:,{'LD_temperature77','LD_temperature78','LD_temperature79','LD_temperature80','LD_temperature81','LD_temperature82','LD_temperature83','LD_temperature84','LD_temperature85','LD_temperature86','LD_temperature87','LD_temperature88','LD_temperature89','LD_temperature90','LD_temperature91','LD_temperature92','LD_temperature93','LD_temperature94','LD_temperature95','LD_temperature96','LD_temperature97','LD_temperature98','LD_temperature99','LD_temperature100'}) = [];
% LD_temperature(:,{'LD_temperature45','LD_temperature46','LD_temperature47','LD_temperature48','LD_temperature49','LD_temperature50','LD_temperature51','LD_temperature52','LD_temperature53','LD_temperature54','LD_temperature55','LD_temperature56','LD_temperature57','LD_temperature58','LD_temperature59','LD_temperature60','LD_temperature61','LD_temperature62','LD_temperature63','LD_temperature64','LD_temperature65','LD_temperature66','LD_temperature67','LD_temperature68'}) = [];
% LD_temperature(:,{'LD_temperature13','LD_temperature14','LD_temperature15','LD_temperature16','LD_temperature17','LD_temperature18','LD_temperature19','LD_temperature20','LD_temperature21','LD_temperature22','LD_temperature23','LD_temperature24','LD_temperature25','LD_temperature26','LD_temperature27','LD_temperature28','LD_temperature29','LD_temperature30','LD_temperature31','LD_temperature32','LD_temperature33','LD_temperature34','LD_temperature35','LD_temperature36'}) = [];
% toc
% %LD_temperature_delta=LD_temperature;%%����
% 
% %%%%%%%ɾ��վ������
% tic
% LD_temperature(:,{'LD_temperature269','LD_temperature275','LD_temperature281','LD_temperature287','LD_temperature237','LD_temperature243','LD_temperature249','LD_temperature255','LD_temperature205','LD_temperature211','LD_temperature217','LD_temperature223','LD_temperature173','LD_temperature179','LD_temperature185','LD_temperature191','LD_temperature141','LD_temperature147','LD_temperature153','LD_temperature159'}) = [];
% toc
% 
% 
% 
% LD=LD_temperature;

%%%%%%%%%%%%%�����ı���վ��˳�������submission���������˳��
tic
temp_aqi_station=table2cell(LD(1,1)); %��ʼ����һ�����ڷ����aqi_station
LD_data=cell(5,size(LD,2),5);%��ʼ����άԪ������
LD_num=1;%վ����Ŀ
j=1;%��¼ѭ����ÿ����άԪ�����������к�
for i = 1:size(LD,1)
      if mod(i,1000)==0 %�۲��㷨�������ٶ�
       i  
      end
      if isequal(temp_aqi_station, table2cell(LD(i,1)))
           LD_data(j,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
           j=j+1;
      else
           temp_aqi_station=table2cell(LD(i,1));
           LD_num=LD_num + 1;
           LD_data(1,1:size(LD,2),LD_num)=table2cell(LD(i,1:size(LD,2)));
           j=2;
      end
end
toc

[~,~,LD_predict_station]=xlsread('LD_predict_id');%�����������վ�ľ�γ������
LD_data_new=cell(9,size(LD_data,2),13);

for i=1:size(LD_predict_station,1)
     for j=1:size(LD_data,3)
        if isequal(LD_data(1,1,j),LD_predict_station(i,1))
            LD_data_new(:,:,i)=LD_data(:,:,j);
        end 
     end
end

%%%%%%%%%%%%%

%%�ϲ�
tic
LD_temperature=LD_data_new(:,:,1);
for j=2:size(LD_data_new,3)
       j     
    LD_temperature=cat(1,LD_temperature,LD_data_new(:,:,j));
end

toc

LD_temperature=cell2table(LD_temperature);

%LD_temperature(:,{'LD_temperature11','LD_temperature18','LD_temperature25','LD_temperature32','LD_temperature39','LD_temperature46','LD_temperature53','LD_temperature60','LD_temperature67','LD_temperature79','LD_temperature84','LD_temperature89','LD_temperature94','LD_temperature99','LD_temperature104','LD_temperature109','LD_temperature114','LD_temperature119','LD_temperature124','LD_temperature129','LD_temperature134','LD_temperature139','LD_temperature144','LD_temperature149','LD_temperature154','LD_temperature159','LD_temperature164','LD_temperature169','LD_temperature174'}) = [];

%%%�ǵ��޸ı����ļ�����
tic
writetable(LD_temperature,'LD_aqi_meo_5_31_75_model_test_new_with_NO2_winddirection_encoding.csv','Delimiter',',','QuoteStrings',true)
toc