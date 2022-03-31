%��historical��1850-2014����senorio��2015-2100�������ݺϲ�Ϊһ���ļ�����ȡ2000-2100�������

clear; clc;

%historical���ļ�·��
sourceHisPath='E:\workplace\productivity temperature\result\year_con\rsds\gpp-tas-pr-rsds\spring_NH\historical_1850-2014\';
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

%senorio���ļ�·��
SourceSspPath='E:\workplace\productivity temperature\result\year_con\rsds\gpp-tas-pr-rsds\spring_NH\ssp245_2015-2100\';
 for i=3:length
     sspPath=strcat(SourceSspPath,his(i,1).name);
     if i==3
     sspPaths=sspPath;
     else
     sspPaths=char(sspPaths,sspPath);
     end
 end

 %�����ļ���·��
 saveSourcePath='E:\workplace\productivity temperature\result\year_con\rsds\gpp-tas-pr-rsds\spring_NH\ssp245_2000-2100\';
 for i=3:length
     savePath=strcat(saveSourcePath,his(i,1).name);
     if i==3
     savePaths=savePath;
     else
     savePaths=char(savePaths,savePath);
     end
 end
 
 %��������ģ�ͣ�ƴ�������ļ�
 for i=1:length-2
     historical=load(hisPathes(i,:));
     ssp=load(sspPaths(i,:));
     historical=historical.result;
     ssp=ssp.result;
     
     result=cat(3,historical(:,:,151:165),ssp);
     save(savePaths(i,:),'result');
 end
 
 figure;
 imagesc(result(:,:,101));
 colorbar;
 figure;
 plot(reshape(result(47,655,:),1,101));