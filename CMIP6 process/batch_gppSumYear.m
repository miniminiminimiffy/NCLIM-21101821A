%%%��ÿ�µ�GPP���ݴ���Ϊÿ����ܺ�ֵ�����ڷ�������GPP���Ժ��Բ��ƣ����Բ�������������Ҳ�ɡ�
%���룺CMIP6 GPP���ݣ��ֱ���Ϊ�£�һ��ģ�Ϳ����ж���ļ���
%�����ÿ����ܺͣ�һ��ģ���ж���ļ���
%��λ��ԭʼ��λΪkg m-2 s-1������ݵĵ�λΪgC m-2 yr-1��

clear

%��1������nc�ļ�
%����nc�ļ�·��
sourceHisPath='E:\data\CMIP6\r1i1pifi\gpp\mon\historical\';
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

%����ģ���б�
[~,modelList]=xlsread("E:\workplace\productivity temperature\supplement\modelList-gpp_tas_pr_rsds.xlsx");
modelList_num=size(modelList,1);

%��ÿ���ļ���ģ�����Ƶ����г���
his(1:2,:)=[];
hisPathes_split=cell(length-2,1);
%�ָ�hisPathes
for i=1:length-2
    this_split=strsplit(his(i).name,'_');
    hisPathes_split(i,1)=this_split(3);
    a=1;
end

%��ѡ������ģ��
%���ˣ����к�·����صľ����ά���Ѷ�һ��
%����hisPathes_split���ж��Ƿ�Ϊ�˴�ModelList��������ģ�ͣ�����ɾ��֮
for i=length-2:-1:1
    tag=0;
    path_modelName=char(hisPathes_split(i));
    %����ģ���б�
    for j=1:modelList_num
        list_modelName=char(modelList(j));
        %�����ncΪModelList��Ҫ�����ģ��
        if(strcmp(path_modelName,list_modelName))
            tag=1;
            break;
        end
    end
    %�������ModelList����Ҫ�����ģ�ͣ�ɾ��֮
    if(tag==0)
        hisPathes(i,:)='';
        his(i)=[];
    end
end

%��2������ͼ���·��������
length_compute=size(his,1);%�õ����������ļ�����
saveSourcePath='E:\workplace\productivity temperature\result\year\gpp\gpp-tas-pr-rsds\autumn_NH\historical\';
 for i=1:length_compute
     savePath=strcat(saveSourcePath,his(i).name);
     savePath=strrep(savePath,'.nc','');
     if i==1
     savePaths=savePath;
     else
     savePaths=char(savePaths,savePath);
     end
 end
 
 path_growingSeason='E:\data\phenology\growing season\globalMonthlyGS.mat';
 
 %��3������function
 for i=1:length_compute
     fun_gppSumYear(hisPathes(i,:),path_growingSeason,savePaths(i,:));
 end
 
 