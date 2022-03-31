%%%��ÿ�µ�tasmax���ݴ���Ϊÿ��*6-8�£��˴����ص㣩*��ƽ��ֵ��
%�ļ�����tasmax:������;summer:һ���в��������·�Ϊ�������ļ�6-8��;Nh:ֻ���㱱����;MtoY:ԭʼCMIP6�ֱ���Ϊ���ֽ������Ϊÿ��ľ�ֵ��
%���룺CMIP6 tasmax���ݣ��ֱ���Ϊ�£�һ��ģ�Ϳ����ж���ļ���
%�����ÿ��6-8�µ�ƽ��ֵ��һ��ģ���ж���ļ���
%��λ��ԭʼ��λΪK�������λΪ�档

function[]=fun_tasmaxSummerNhMtoY(path_tasmax,path_GS,path_save)
%ȥ��·���еĿո񣬷����޷����ַ�������ȡ�����Ϣ
path_tasmax(isspace(path_tasmax)) = [];

%��·������ȡ�����Ϣ
year1=str2double(path_tasmax(length(path_tasmax)-15:length(path_tasmax)-12));
year2=str2double(path_tasmax(length(path_tasmax)-8:length(path_tasmax)-5));

%��������������
GS=load(path_GS);
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
    tasmax=ncread(path_tasmax,'tas',startLoc,count);
    
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
    tasmax_thisYear = mean(tasmax(:,:,9:11),3,'omitnan');
    tasmax_thisYear(isnan(veCover)) = nan;
    result(:,:,tag) = tasmax_thisYear;
    
%     for i_lon=1:col
%         for i_lat=1:row
%             %�����դ���ֲ������������ֱ��ΪNan
%             if(isnan(veCover(i_lat,i_lon)))
%                 continue;
%             end
%             tasmax_thisGrid=reshape(tasmax(i_lat,i_lon,:),1,12);
%             %�����괺���Ļ��＾����ȡ��ֵ
%             result(i_lat,i_lon,tag)=mean(tasmax_thisGrid(1,[3 4 5]),'omitnan');           
%         end
%     end
    
    tag=tag+1;
end

result=result-273.15;
save(path_save,'result');
