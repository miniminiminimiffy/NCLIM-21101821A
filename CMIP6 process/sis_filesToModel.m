%��ÿ��ģ����tasmax�ľ�ֵ���Ϊһ��.mat
clear;clc;

%ģ����������Ҫ�����ļ�����ģ�͵���������
model_num=9;
%senorio
% year1=2015;year2=2100;
%historical
year1=1850;year2=2014;

sourceHisPath='E:\workplace\productivity temperature\result\year\gpp\gpp-tas-pr-rsds\autumn_NH\historical\';
his = dir(sourceHisPath);
size0 = size(his);
length = size0(1);%�ļ������ļ�������
for i=3:length
   hisName = strcat(sourceHisPath,his(i,1).name); 
   if i==3
       hisPathes=hisName;
   else
   hisPathes = char(hisPathes,hisName);%��ֱƴ���ַ��������ļ������ļ��е����ƶ�ȡ����
   end
end

split_str=cell(length-2,8);
id=zeros(model_num,2);
id(1,1)=1;
id(model_num,2)=length-2;
%����ͬģ�͵�����ҳ������洢��id������
for i=1:length-2
    split_str(i,:)=strsplit(hisPathes(i,:),'_');    
end

tag=1;
for i=2:length-2
    model_name1=char(split_str(i-1,4));
    model_name2=char(split_str(i,4));
    if(strcmp(model_name1,model_name2))
        continue;
    else
        id(tag,2)=i-1;
        id(tag+1,1)=i;
        tag=tag+1;
    end
end

k=0;
%����ͬ��ģ�ͺϲ�
for i=1:model_num
    %�õ�ģ���ļ��ĸ���
    file_num=id(i,2)-id(i,1)+1;
    %���ļ�����ƴ����һ��
    result=load(hisPathes(id(i,1),:));
    result=result.result;
    k=k+1;
    if(file_num>1)
        for j=2:file_num
            file=load(hisPathes(id(i,1)+j-1,:));
            file=file.result;
            result=cat(3,result,file);
            k=k+1;
        end
    end
    
    %���result�Ƿ������ȷ�������������������ݲű����ļ�
    yearCheck=year2-year1+1;
    result_year=size(result,3);
    if(yearCheck==result_year)
        save_path=strcat('E:\workplace\productivity temperature\result\year_con\gpp\gpp-tas-pr-rsds\autumn_NH\historical_1850-2014\', char(split_str(k,4)));
        save(save_path,'result');
    end
end

