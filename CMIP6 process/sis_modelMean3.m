%����һ���ļ�����������ά����ľ�ֵ����������x*y*z����ά����

clear;

%�ռ�ֱ���
row = 180;
col = 720;
years = 82;

%������·��
saveRootPath = "D:\workplace\productivity temperature\result\ne_year\gpp-tas-pr-rsds\June-August_NH\gpp-tas\modelMean\withouBCC\justWithoutBCC\ssp585\pval_2019-2100.mat";

%˳������ƽ���ļ�
rootPath='D:\workplace\productivity temperature\result\ne_year\gpp-tas-pr-rsds\June-August_NH\gpp-tas\ssp585_2019-2100\pval\withoutBCC\';
files = dir(rootPath);
files(1:2,:) = [];
fileNum = size(files,1);

%Ԥ����������
result = nan(row,col,years);

for i_file = 1:fileNum
    %���뱾�ļ�
    thisFilePath = [rootPath,files(i_file).name];
    mat = load(thisFilePath);
    mat = mat.result_pval;
    
    if(i_file == 1)
        result = mat;
    else
        matCat = cat(4,result*((i_file-1)/i_file),mat*(1/i_file));
        result = sum(matCat,4,'omitnan');
    end
end

%������������ֵΪnan
result(result==0) = nan;

%������
save(saveRootPath,'result');
