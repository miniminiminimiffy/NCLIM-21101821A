%���ã���ÿ�µ�GPP���ݴ���Ϊÿ����ܺ�ֵ�����ڷ�������GPP���Ժ��Բ��ƣ����Բ�������������Ҳ�ɡ�
%���룺CMIP6��GPP���ݣ��ֱ���Ϊ�£�һ��ģ���ж���ļ���
%�����ÿ��12�����ۼ�������GPP���ֱ���Ϊ�꣬һ��ģ���ж���ļ���

function[]=fun_gppSumYear(path_data,path_growingSeason,path_save)

%ȥ��·���еĿո񣬷����޷����ַ�������ȡ�����Ϣ
path_data(isspace(path_data)) = [];
%��·������ȡ�����Ϣ
year1=str2double(path_data(length(path_data)-15:length(path_data)-12));
year2=str2double(path_data(length(path_data)-8:length(path_data)-5));

%�������������ݣ��õ�ֲ�����Ǿ���GSCover
GS=load(path_growingSeason);
GS=GS.globalMonthlyGS;
VeCover=sum(GS,3);
VeCover(VeCover==0)=nan;
%�����㱱����
VeCover=VeCover(1:180,:);


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
    gpp=ncread(path_data,'gpp',startLoc,count);
    %�����������ز���Ϊ360*720�������·�ת
    gpp=imresize(permute(gpp,[2 1 3]),[360,720],'bilinear');
    gpp=flip(gpp);
    %����������ƴ��Ϊ-180~180�ȵķ�Χ
    gpp1=gpp(:,1:360,:);
    gpp2=gpp(:,361:720,:);
    gpp=[gpp2,gpp1];
    %�����㱱����
    gpp=gpp(1:180,:,:);
    
    startId=endId+1;
    
    %����ÿ��ƽ��ֵ���������ھ����� 
    %����ÿһ������
    for i_lon=1:col
        for i_lat=1:row
            %�����ֲ����������ֱ������
            if(isnan(VeCover(i_lat,i_lon)))
                continue;
            end
            
            %��ԭʼ��λkg m-2 s-1����Ϊkg m-2 day-1
            gpp_grow=gpp(i_lat,i_lon,:)*86400;
            gpp_reshape=reshape(gpp_grow,1,12);
            %�ж��Ƿ�Ϊ���꣬����Ϊkg m-2 mon-1
            if(rem(i_year,100)~=0&&rem(i_year,4)==0)
                gpp_month=gpp_reshape.*daysMonth_leap;%����
            else
                gpp_month=gpp_reshape.*daysMonth;%������
            end
            
            %�����꣨n-m�£�ÿ�µ�GPP���ܣ�����ΪgC m-2 year-1
            gpp_month=gpp_month*1000;%kg����Ϊg
            result(i_lat,i_lon,tag)=sum(gpp_month(1,[9 10 11]),'omitnan');           
        end
    end
    tag=tag+1;
end

%������
save(path_save,'result');
