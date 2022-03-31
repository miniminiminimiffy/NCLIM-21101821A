%���ã���ÿ���µ�rsdsȡƽ���õ�һ���ƽ��rsds
%���룺CMIP6��rsds���ݣ��ֱ���Ϊ�£�һ��ģ���ж���ļ�
%�����ÿ��12����ƽ����rsds���ֱ���Ϊ�꣬һ��ģ���ж���ļ�

function[]=fun_rsdsSumYear(path_data,path_growingSeason,path_save)

%ȥ��·���еĿո񣬷����޷����ַ�������ȡ�����Ϣ
path_data(isspace(path_data)) = [];
%��·������ȡ�����Ϣ
year1=str2double(path_data(length(path_data)-15:length(path_data)-12));
year2=str2double(path_data(length(path_data)-8:length(path_data)-5));

%��������������
GS=load(path_growingSeason);
GS=GS.globalMonthlyGS;
%����ֲ�����Ƿ�Χ
veCover=sum(GS,3);
veCover((veCover == 0)) = nan;
%�����㱱����
veCover=veCover(1:180,:);

%����ռ�ֱ���
row=180; col=720;

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
    tasmax=ncread(path_data,'rsds',startLoc,count);
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
    for i_lat=1:row
        for i_lon=1:col
           %�����դ���ֲ������������ֱ��ΪNan
            if(isnan(veCover(i_lat,i_lon)))
                continue;
            end
            
            %��ÿ��12���µ�rsds��������
            tasmax_reshape=reshape(tasmax(i_lat,i_lon,:),1,12);
            result(i_lat,i_lon,tag)=sum(tasmax_reshape(1,[9 10 11]),'omitnan');           
        end
    end
    tag=tag+1;
end

%������
save(path_save,'result');
