%%%ʹ��CRUNCEP�����ݣ������CMIP6ģ��ģ�������2001-2013ÿ��*�ļ���6-8�£�*��ƽ�������
%���룺CRUNCEPԭʼ����6СʱΪ�ֱ��ʵ�����
%�����2001-2013ÿ���������¶ȵ�ƽ�����ֵ��ÿ��ȡ4���¶���max���¶ȣ��ٽ���������������¶�ƽ��

clear;clc;

sourceHisPath='D:\workplace\productivity temperature\result\CRU-NCEP\V8\Tair\Tair_6hour_June-August_2001-2013\';
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

%�����������·��������
 saveSourcePath='D:\workplace\productivity temperature\result\CRU-NCEP\V8\Tair\TairMax_year_June-August_2001-2013\';
 for i=3:length
     savePath=strcat(saveSourcePath,his(i,1).name);
     savePath=strrep(savePath,'.nc','');
     if i==3
     savePaths=savePath;
     else
     savePaths=char(savePaths,savePath);
     end
 end
 
 path_growingSeason="D:\workplace\productivity temperature\result\growingSeason\globalMonthlyGS.mat";
 
 %��function
 for i=1:length-2
     fun_CruFundYearSummerNh(hisPathes(i,:),path_growingSeason,savePaths(i,:));
 end
 
 