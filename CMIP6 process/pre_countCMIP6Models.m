%����CMIP6ģ�͵��������ļ���ɾ����
%���룺װ��CMIP6ģ�͵��ļ���·����
%�����ModelsName��ģ�����Ľ������Ϊȫ��LACKΪȱ�٣�MOREΪ���ࡣ

clear;clc

%��Ҫ�Զ���Ĳ�����
%historical
startYear=1850;endYear=2014;
%senorio
% startYear=2015;endYear=2100;

%�г��ļ����������ļ�����Ϣ
sourceHisPath='D:\data\CMIP6\r1i1pifi\npp\historical\';
his = dir(sourceHisPath);
length = size(his,1); % �ļ������ļ�������

%ɾ����СΪ0���ļ�
for i=3:length
    if(his(i).bytes==0)
        fileName=[sourceHisPath,his(i).name];
        delete(fileName);
    end
end

%��ȡ�����ļ�������
for i=3:length
   hisName = his(i,1).name; 
   if i==3
       hisPathes=hisName;
   else
   hisPathes = char(hisPathes,hisName);%��ֱƴ���ַ��������ļ������ļ��е����ƶ�ȡ����
   end
end

%CMIPģ�͵ĵ�3���7�ֱ�Ϊģ��������ʱ��
ModelName_id=3;ModelDate_id=7;

%�����ָ��ַ����������
rows=size(strsplit(hisPathes(1,:),'_'),2);
strSplit=cell(length-2,rows);
for i=1:length-2
    strSplit(i,:)=strsplit(hisPathes(i,:),'_');
end
%�ڵ�һ�к����һ������һ�пյ�cell
strSplitEmpty=cell(1,rows);
strSplitEmpty(1,ModelName_id)=cellstr('Empty');
strSplitEmpty(1,ModelDate_id)=cellstr('201501-210012.nc');
strSplit=[strSplitEmpty;strSplit;strSplitEmpty];

%����ÿһ���ļ�����������ģ�͵�ʱ���г�
tag=1;
for i=2:length
    %��ȡģ������
    ModelName_before=strSplit(i-1,ModelName_id);
    ModelName_this=strSplit(i,ModelName_id);
    
    %��ȡģ��ʱ��
    ModelTime_before=char(strSplit(i-1,ModelDate_id));
    ModelTime_this=char(strSplit(i,ModelDate_id));
    ModelTime_befor_split=strsplit(ModelTime_before,'-');
    ModelTime_this_split=strsplit(ModelTime_this,'-');
    %file befor��ʱ��
    ModelTime_before10=char(ModelTime_befor_split(1,1));
    ModelTime_before1=str2double(ModelTime_before10(1:4));
    ModelTime_before20=char(ModelTime_befor_split(1,2));
    ModelTime_before2=str2double(ModelTime_before20(1:4));
    %file this��ʱ��
    ModelTime_this10=char(ModelTime_this_split(1,1));
    ModelTime_this1=str2double(ModelTime_this10(1:4));
    ModelTime_this20=char(ModelTime_this_split(1,2));
    ModelTime_this2=str2double(ModelTime_this20(1:4));
    
    if(~strcmp(ModelName_this,ModelName_before))
        %����ģ������
        ModelName(tag,1)=ModelName_before;%����Ԥ�Ȳ�֪��ģ�͵�������ֻ�ܲ��ö�̬����
        tag=tag+1;
        %����ģ��ʱ�䣬���ģ�ͱ仯�ˣ��ͽ�tag_date����Ϊ1
        tag_date=1;
        ModelDate(tag,tag_date)=ModelTime_this1;
        ModelDate(tag,tag_date+1)=ModelTime_this2;
        tag_date=tag_date+2;
    else
        %����ģ��ʱ��
        ModelDate(tag,tag_date)=ModelTime_this1;
        ModelDate(tag,tag_date+1)=ModelTime_this2;
        tag_date=tag_date+2;
    end
end

%�ӵڶ��п�ʼ��������Ϊ��һ�������������ȥ��������д��
ModelNum=size(ModelName,1);
for i=2:ModelNum
    isOK=1;
    %ȥ�������е�0
    thisDate=ModelDate(i,:);
    thisDate(thisDate==0)=[];
    
    %���������2015��2100������ݣ����ģ�Ͳ��ϸ�����
    DateNum=size(thisDate,2);
    if(thisDate(1,1)~=startYear||thisDate(1,DateNum)~=endYear)
        if(thisDate(1,1)<startYear||thisDate(1,DateNum)>endYear)
            ModelName(i,2)=cellstr('MORE');
        else
            ModelName(i,2)=cellstr('LACK');
        end
        continue;
    end
        
    %����ÿһ��ʱ��
    for j=1:(DateNum/2)-1
        dateDiff=thisDate(1,j*2+1)-thisDate(1,j*2);
        %����м����ʱ�����Ծ�����ģ�Ͳ��ϸ�����
        if(dateDiff~=1&&dateDiff~=0)
            isOK=0;
            ModelName(i,2)=cellstr('LACK');
            break;
        end
    end
    if(isOK==1)
        ModelName(i,2)=cellstr('��');
    end
end
ModelName(1,:)=[];
result=ModelName;


%����CMIP6ģ�ͻ��ܣ�ȡ�ñ�Ҫ����
[~,allModels]=xlsread("E:\researches\research content\temperature-NEE\ģ���б�.xlsx");
allModels_num=size(allModels,1);
models_num=size(result,1);

%ΪallModels����һ�У����ڴ�����
allModels(:,2)=cell(allModels_num,1);

%allModels������ģ������
for i=1:allModels_num
    %����result������ģ��
    thisName=char(allModels(i,1));
    thisName(isspace(thisName))=[];
    for j=1:models_num
        %�����д���Ӧ��ģ�ʹ�
        if(strcmp(thisName,result(j,1)))
            allModels(i,2)=result(j,2);
        end
    end
end
