%gpp-tas-pr-rsds������gpp��tas��ƫ���ϵ����ƫ��С����ϵ��
%���룺ÿ��ģ�ʹ�2000-2100���gpp tas pr rsds
%�����gpp��tas��ƫ���ϵ������20��Ļ���ƽ����2019-2100���partialCorr�����pval����

clear

%����gpp����
sourceGppPath='E:\workplace\productivity temperature\result\year_con\gpp\gpp-tas-pr-rsds\spring_NH\ssp245_2000-2100\';
his = dir(sourceGppPath);
size0 = size(his);
length = size0(1);%�ļ������ļ�������
for i=3:length
   gppName = strcat(sourceGppPath,his(i,1).name); 
   if i==3
       gppPathes=gppName;
   else
   gppPathes = char(gppPathes,gppName);%��ֱƴ���ַ��������ļ������ļ��е����ƶ�ȡ����
   end
end

%����tas����
sourceTasPath='E:\workplace\productivity temperature\result\year_con\tas\gpp-tas-pr-rsds\spring_NH\ssp245_2000-2100\';
 for i=3:length
     tasPath=strcat(sourceTasPath,his(i,1).name);
     if i==3
     tasPaths=tasPath;
     else
     tasPaths=char(tasPaths,tasPath);
     end
 end
 
%����pr����
sourcePrPath='E:\workplace\productivity temperature\result\year_con\pr\gpp-tas-pr-rsds\spring_NH\ssp245_2000-2100\';
 for i=3:length
     prPath=strcat(sourcePrPath,his(i,1).name);
     if i==3
     prPaths=prPath;
     else
     prPaths=char(prPaths,prPath);
     end
 end

%����rsds����
sourceRsdsPath='E:\workplace\productivity temperature\result\year_con\rsds\gpp-tas-pr-rsds\spring_NH\ssp245_2000-2100\';
 for i=3:length
     rsdsPath=strcat(sourceRsdsPath,his(i,1).name);
     if i==3
     rsdsPaths=rsdsPath;
     else
     rsdsPaths=char(rsdsPaths,rsdsPath);
     end
 end

 %����ƫ���ϵ����·��
  saveSourceCorrPath='E:\workplace\productivity temperature\result\ne_year\gpp-tas-pr-rsds\spring_NH\gpp-tas\ssp245_2019-2100\parCorr\9model\';
 for i=3:length
     saveCorrPath=strcat(saveSourceCorrPath,his(i,1).name);
     if i==3
     saveCorrPaths=saveCorrPath;
     else
     saveCorrPaths=char(saveCorrPaths,saveCorrPath);
     end
 end
 
%����pֵ��·��
 savePCorrPath='E:\workplace\productivity temperature\result\ne_year\gpp-tas-pr-rsds\spring_NH\gpp-tas\ssp245_2019-2100\pval\9model\';
 for i=3:length
     savePPath=strcat(savePCorrPath,his(i,1).name);
     if i==3
     savePPaths=savePPath;
     else
     savePPaths=char(savePPaths,savePPath);
     end
 end
 
 %����sensitivity��·��
 saveSenRootPath='E:\workplace\productivity temperature\result\sensitivity\spring_NH\gpp-tas\ssp245_2019-2100\9model\';
 for i=3:length
     saveSenPath=strcat(saveSenRootPath,his(i,1).name);
     if i==3
     saveSenPaths=saveSenPath;
     else
     saveSenPaths=char(saveSenPaths,saveSenPath);
     end
 end

 %����ÿ��ģ�ͼ���ƫ���ϵ�����״δﵽ����ص����
 for i=9:9
     fun_gppTasPartialCorr3(gppPathes(i,:),tasPaths(i,:),prPaths(i,:),rsdsPaths(i,:),saveCorrPaths(i,:),savePPaths(i,:),saveSenPaths(i,:));
 end
