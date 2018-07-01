function W=knn_interplote_weather_without_encoding(temp_meo,d)
%W=1;
    temp_meo_new(:,1)=cell2mat(temp_meo(:,1));
    temp_meo_new(:,2)=cell2mat(temp_meo(:,2));
    temp_meo_new(:,4)=cell2mat(temp_meo(:,4));
    temp_meo_new(:,5)=cell2mat(temp_meo(:,5));
    temp_meo_new(:,6)=cell2mat(temp_meo(:,6));
    temp_meo_new(:,7)=cell2mat(temp_meo(:,7));
    temp_meo_new(:,8)=cell2mat(temp_meo(:,8));

    %[d,~,~]=xlsread('station_AQI');%�����������վ�ľ�γ������
    temp=zeros(size(d,1),size(temp_meo_new,1));

    %%%%%���18������۲�վ��35����������վ����֮���ŷʽ����%%%%
    for i=1:size(d,1)
        for  j=1:size(temp_meo_new,1) 
            d(i,j+6)=sqrt((d(i,1)-temp_meo_new(j,1))^2+(d(i,2)-temp_meo_new(j,2))^2);%ŷʽ����=���ţ���x1-x2��^2+(y1-y2)
        end
        temp(i,1:size(temp_meo_new,1))=sort(d(i,7:size(temp_meo_new,1)+6));%%�Ծ����������
    end

    %%%%���18������۲�վ��u��v����������ٵķ���
    u=zeros(size(temp_meo_new,1),1); %��ʼ��u�����ϵķ���
    v=zeros(size(temp_meo_new,1),1); %��ʼ��v�����ϵķ���
    for j = 1:size(temp_meo_new,1) %���������ĳ��ʱ�̵�����վ�ķ���
        if isnan(temp_meo_new(j,7)) %������ж�Ӧ������վ�ķ���ΪNaN
            u(j)=666666666; %�Բ����ڷ��ټ�¼������վ��u������ֵΪ666666666
            v(j)=666666666; %�Բ����ڷ��ټ�¼������վ��u������ֵΪ666666666
        elseif temp_meo_new(j,7)>=999016
            u(j)=0.5.*rand();  %���ڷ������999016������۲�վ���ԣ����ǵķ���С��0.5������������һ��С��0.5����0����
            v(j)=0.5.*rand();  %���ڷ������999016������۲�վ���ԣ����ǵķ���С��0.5������������һ��С��0.5����0����
        else
            u(j) = temp_meo_new(j,8) * sind((temp_meo_new(j,7)));%u�������
            v(j) = temp_meo_new(j,8) * cosd((temp_meo_new(j,7)));%v�������
        end
    end

    k=4; %���������ڵ���2
    h=2; %������ľ��������
    W=cell(size(d,1),3,1);%��35����������վ��Ŀ����һ����ά����
    ufenzi=0; %��ʼ�������Ȩ���u������ٵķ���
    ufenmu=0;%��ʼ�������Ȩ���u������ٵķ�ĸ
    vfenzi=0;%��ʼ�������Ȩ���v������ٵķ���
    vfenmu=0;%��ʼ�������Ȩ���v������ٵķ�ĸ
    temp_fenzi=0;%��ʼ�������Ȩ����¶ȵķ���
    temp_fenmu=0;%��ʼ�������Ȩ����¶ȵķ�ĸ
    pressure_fenzi=0;%��ʼ�������Ȩ���ѹǿ�ķ���
    pressure_fenmu=0;%��ʼ�������Ȩ���ѹǿ�ķ�ĸ
    humidity_fenzi=0;%��ʼ�������Ȩ���ʪ�ȵķ���
    humidity_fenmu=0;%��ʼ�������Ȩ���ʪ�ȵķ�ĸ

    for i=1:size(d,1)%��35����������վ�ֱ������ͷ���
        [~,n]=find(d(i,:)==temp(i,1));%ֻ������������ڷ��٣�����ǡ�1��
        W(i,9,1)=temp_meo(n-6,3);
        for l=2:k %k�ǹ涨��ѡ��������ڵ�����۲�վ�ĸ���
            
            
            if temp(i,l)-temp(i,1)<0.1 %�����l������۲�վ����i����������վ�ľ�����˿�������վ�����������۲�վС��0.1
            
            [~,n]=find(d(i,:)==temp(i,l-1));%��������ڷ��ٲ��Ҵ�l��ʼѭ��Ѱ�Ҿ����������վ��Զ������۲�վ
            ufenzi= ufenzi + u(n-6)/(d(i,n)^h); 
            ufenmu= ufenmu + 1/(d(i,n)^h);
            vfenzi= vfenzi + v(n-6)/(d(i,n)^h); 
            vfenmu= vfenmu + 1/(d(i,n)^h);
            temp_fenzi=temp_fenzi+temp_meo_new(n-6,4)/(d(i,n)^h);
            temp_fenmu=temp_fenmu+1/(d(i,n)^h);
            pressure_fenzi= pressure_fenzi+temp_meo_new(n-6,5)/(d(i,n)^h);
            pressure_fenmu=pressure_fenmu+1/(d(i,n)^h);
            humidity_fenzi=humidity_fenzi+temp_meo_new(n-6,6)/(d(i,n)^h);
            humidity_fenmu=humidity_fenmu+1/(d(i,n)^h);
            
            elseif temp(i,2)-temp(i,1)>0.1 || temp(i,2)>0.2 %�������ݿ��ӻ��۲⣬���ڶ����ڵ�����۲�վ������ڹ۲�վ�Ĳ�ֵ����0.1
                                                                                   %���ߵڶ����ڹ۲�վ�������0.2��ʱ�򣬴�ʱ������Ϊֻ�������������۲�
                                                                                   %վ�ķ��ٲ�ֱ�Ӹ��Ƹ������������վ����Ϊ�ӿ��ӻ���ͼ������ЩԶ��󲿷�
                                                                                   %���������۲�վ����Щ���������۲�վ������ֻ��1������2������۲�վ
            [~,n]=find(d(i,:)==temp(i,1));%ֻ������������ڷ��٣�����ǡ�1��
            ufenzi= u(n-6)/(d(i,n)^h); 
            ufenmu= 1/(d(i,n)^h);
            vfenzi= v(n-6)/(d(i,n)^h); 
            vfenmu= 1/(d(i,n)^h);
            temp_fenzi=temp_fenzi+temp_meo_new(n-6,4)/(d(i,n)^h);
            temp_fenmu=temp_fenmu+1/(d(i,n)^h);
            pressure_fenzi= pressure_fenzi+temp_meo_new(n-6,5)/(d(i,n)^h);
            pressure_fenmu=pressure_fenmu+1/(d(i,n)^h);
            humidity_fenzi=humidity_fenzi+temp_meo_new(n-6,6)/(d(i,n)^h);
            humidity_fenmu=humidity_fenmu+1/(d(i,n)^h);
            
            end   
        end
            W(i,1,1)=num2cell(d(i,1));
            W(i,2,1)=num2cell(d(i,2));
            W(i,3,1)=num2cell(temp_fenzi/temp_fenmu); %���ݷ����Ȩ����¶�
            W(i,4,1)=num2cell(pressure_fenzi/pressure_fenmu); %���ݷ����Ȩ���ѹǿ
            W(i,5,1)=num2cell(humidity_fenzi/humidity_fenmu); %���ݷ����Ȩ���ʪ��
            W(i,6,1)=num2cell(ufenzi/ufenmu); %���ݷ����Ȩ���u����ķ���
            W(i,7,1)=num2cell(vfenzi/vfenmu); %���ݷ����Ȩ���v����ķ���
            W(i,8,1)=num2cell(sqrt(cell2mat(W(i,6))^2+cell2mat(W(i,7))^2)); %���������η���(���ɶ���)�ϳɷ���
    end
    
end