%%%��ÿ�µ�pr���ݴ���Ϊ����Ϊ�ֱ��ʵ�ֵ��
%���룺CMIP6 pr���ݣ��ֱ���Ϊ�£�һ��ģ�Ϳ����ж���ļ���
%�����ԭʼ��λΪkg m-2 s-1������ݵĵ�λΪmm yr-1��

function[]=fun_prSumYear(path_data,path_growingSeason,path_save)

%ȥ��·���еĿո񣬷����޷����ַ�������ȡ�����Ϣ
path_data(isspace(path_data)) = [];
%��·������ȡ�����Ϣ
year1=str2double(path_data(length(path_data)-15:length(path_data)-12));
year2=str2double(path_data(length(path_data)-8:length(path_data)-5));

%��������������
GS=load(path_growingSeason);
GS=GS.globalMonthlyGS;%�˴���GS�������ж�դ���Ƿ�Ϊֲ�����ǵ�դ��
%����ֲ�����Ƿ�Χ
veCover=sum(GS,3);
veCover((veCover == 0)) = nan;
%�����㱱����
veCover=veCover(1:180,:);

%����ռ�ֱ���
row=180; col=720;

%ÿ�¼�ÿ���ж�����
daysMonth=[31,28,31,30,31,30,31,31,30,31,30,31];%������
daysMonth_leap=[31,29,31,30,31,30,31,31,30,31,30,31];%����

%�������
result=nan(row,col,year2-year1+1);

startId=1;
tag=1;
for i_year=year1:year2
    endId=startId-1+12;
    count_3=12;
    
    %�������ݣ�һ�ζ���һ�������
    startLoc=[1,1,startId];
    count=[Inf,Inf,count_3];
    tasmax=ncread(path_data,'pr',startLoc,count);
    %�����������ز���Ϊ360*720�������·�ת
    tasmax=imresize(permute(tasmax,[2 1 3]),[360,720],'bilinear');
    tasmax=flip(tasmax);
    %����������ƴ��Ϊ-180~180�ȵķ�Χ
    tasmax1=tasmax(:,1:360,:);
    tasmax2=tasmax(:,361:720,:);
    tasmax=[tasmax2,tasmax1];
    %ֻ���㱱���������
    tasmax=tasmax(1:180,:,:);
    
    startId=endId+1;
    %����ÿ��ƽ��ֵ���������ھ����� 
    %����ÿһ������
    for i_lon=1:col
        for i_lat=1:row
            %�����դ���ֲ������������ֱ��ΪNan
            if(isnan(veCover(i_lat,i_lon)))
                continue;
            end
            %��ԭʼ��λkg m-2 s-1����Ϊmm day-1
            tasmax_grow=tasmax(i_lat,i_lon,:)*86400;
            tasmax_reshape=reshape(tasmax_grow,1,12);
            %�ж��Ƿ�Ϊ���꣬����Ϊmm mon-1
            if(rem(i_year,100)~=0&&rem(i_year,4)==0)
                tasmax_month=tasmax_reshape.*daysMonth_leap;%����
            else
                tasmax_month=tasmax_reshape.*daysMonth;%������
            end
            
            %������ÿ�µ�pr���ܣ�����Ϊmm yr-1
            result(i_lat,i_lon,tag)=sum(tasmax_month(1,[9 10 11]),'omitnan');           
        end
    end
    tag=tag+1;
end

%������
save(path_save,'result');
