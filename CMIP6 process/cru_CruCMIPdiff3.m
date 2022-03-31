%����CMIP6����ģ��(2001-2013)tasmax ��(2001-2013)��cruncep Tairmax�Ĳ�ֵ����Ϊ���ߵġ�
%��������CMIP6(2000-2100)��tasmax������

%���룺CMIP6ģ��ģ���2000-2100��tasmax��CRUNCEP2001-2013����ʵ����
%�����CMIP6�;�CRU/NCEPУ����2000-2100��tasmax����
clear;clc;

%�������
row=180;
col=720;

%����CRUNCEP����
CRUNCEP_mean=load("D:\workplace\productivity temperature\result\CRU-NCEP\V8\Tair\TairMax_yearMean_June-August\TairMax_yearMean6-8_2001-2013.mat");
CRUNCEP_mean=CRUNCEP_mean.result;

%����ģ�͵�����Ŀ¼
sourceHisPath='D:\workplace\productivity temperature\result\year_con\tasmax\June-August_NH\ssp585_2000-2100_8\';
his = dir(sourceHisPath);
size0 = size(his);
length1 = size0(1);%�ļ������ļ�������
for i=3:length1
   hisName = strcat(sourceHisPath,his(i,1).name); 
   if i==3
       hisPathes=hisName;
   else
   hisPathes = char(hisPathes,hisName);%��ֱƴ���ַ��������ļ������ļ��е����ƶ�ȡ����
   end
end

%���屣��·��
saveSourcePath='D:\workplace\productivity temperature\result\year_con\tasmax\June-August_NH\diff_CRUv8_2001-2013\ssp585_diff_2000-2100_8\';
 for i=3:length1
     savePath=strcat(saveSourcePath,his(i,1).name);
     if i==3
     savePaths=savePath;
     else
     savePaths=char(savePaths,savePath);
     end
 end

%����ÿһ���ļ�
for i_file=1:length1-2
    %��������2000-2100��
    result=nan(row,col,101);
    
    %���뱾CMIP6�ļ����ļ���360*720*101�ľ���2000-2100�꣩
    thisFile=load(hisPathes(i_file,:));
    thisFile=thisFile.result;
    
    %���㱾CMIP6�ļ�2001-2013��ľ�ֵ
    CMIP6_mean=mean(thisFile(:,:,2:14),3,'omitnan');
    %���㱾CRU/NCEP�뱾CMIP6�ļ���2001-2013���ϵĲ�ֵ
    delta=CRUNCEP_mean-CMIP6_mean;
    
    %Ϊresult���2000-2100�������
    for i_year=1:101
        result(:,:,i_year)=thisFile(:,:,i_year)+delta;
    end
    
    %������ 
    save(savePaths(i_file,:),'result');
end

