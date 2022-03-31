%��CRU/NCEP V7��������ȡ��TBOT(temperature at the lowest atm level)���ݣ���ƴ��Ϊ1���
%���룺CRU/NCEP V7 һ���ļ���һ���£�ÿ���ļ�ʱ��ֱ���Ϊ 6hour������
%�����CRU/NCEP V7 һ���ļ���һ�꣬ÿ���ļ�ʱ��ֱ���Ϊ 6hour������

clear;clc;

sourceHisPath='I:\data\CRU-NCEP\V7\TPQWL\2014\';
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
 saveSourcePath='I:\workplace\�����¶�\supplement\CRUNCEP_V7\TBOT_6hour\';
 for i=3:length
     savePath=strcat(saveSourcePath,his(i,1).name);
     savePath=strrep(savePath,'.nc','');
     if i==3
     savePaths=savePath;
     else
     savePaths=char(savePaths,savePath);
     end
 end
 
 %�ȶ����һ���µ�����
 result=ncread(hisPathes(1,:),'TBOT');
 %��֮��������������ƴ���ڵ�һ���ļ�֮��
 for i=2:length-2
     nextFile=ncread(hisPathes(i,:),'TBOT');
     result=cat(3,result,nextFile);
 end
 result=ncRejoin(result);
 
 save('I:\workplace\�����¶�\supplement\CRUNCEP_V7\TBOT_6hour\cruncepv7_halfdeg_2014','result');
 