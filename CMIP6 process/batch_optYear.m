%���ܣ��õ�ȫ��ÿ�����������¶ȵ�������
%���룺year_con��ÿ��ģ�ͻ���ģ��ƽ����360*720*100��2001-2100�꣩���¶�����
%�������ʱ�ﵽ�����¶ȵľ���360*720*1��

clear;clc;

sourceHisPath='D:\workplace\productivity temperature\result\year_con\tasmax\June-August_NH\diff_CRUv8_2001-2013\ssp585_diff_2000-2100_8\';
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

%���������¶ȴﵽʱ���·��
 saveSourcePath='D:\workplace\productivity temperature\result\opt_year\June-August_NH\diff_CRU_2001-2013\ssp585_8\';
 for i=3:length
     savePath=strcat(saveSourcePath,his(i,1).name);
     if i==3
     savePaths=savePath;
     else
     savePaths=char(savePaths,savePath);
     end
 end
 
path_tasOpt="D:\workplace\productivity temperature\result\tas_opt\Topt_modis_NIRv_pattern_filterMean_mask.mat";

 %��function
 for i=1:length-2
     fun_optYear(hisPathes(i,:),path_tasOpt,savePaths(i,:));
 end
 
 