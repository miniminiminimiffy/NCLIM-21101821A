%����һ���ļ����ж�ά����ľ�ֵ�����õ���x*y�Ķ�ά����

clear;clc;

row=180;
col=720;
 
sourceHisPath='D:\workplace\productivity temperature\result\sensitivity\June-August_NH\gpp-tas\ssp585_2019-2100\change[2081-2100][2001-2020]\';
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

opt_YearAll=zeros(row,col,length-2);

%����ÿһ���ļ���ƴ��Ϊһ���ļ�
for i=1:length-2
    opt_year=load(hisPathes(i,:));
    opt_year=opt_year.result;
    %���������ļ���ÿһ��
    opt_YearAll(:,:,i)=opt_year;
end

%���ֵ
result=mean(opt_YearAll,3,'omitnan');

%������
% figure
% imagesc(result);
% colorbar

%��������
save("D:\workplace\productivity temperature\result\sensitivity\June-August_NH\gpp-tas\modelMean\withoutBCC\ssp585_change[2001-2020][2081-2100].mat",'result');
