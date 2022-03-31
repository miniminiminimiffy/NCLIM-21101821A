%����SIF����
%��������Ϊ��1��6-hour�ֱ���
%���������Ϊ��1���·ֱ��ʣ�ȡÿ���������ݵ����ֵ��2��180*720��3��ÿ��һ��mat
%ԭʼ��������Ϊdata�зֱ���Ϊ0.05�㣬ȫ���CSIF����

clear

%����ռ�ֱ���
row = 180;
col = 720;
years = 20;

%������·��
saveRootPath = 'E:\workplace\productivity temperature\result\afters\SIF-temp\mon\CSIF\';

%�������ļ���
rootPath = 'E:\data\drought threshold\CSIF\';
foldersYear = dir(rootPath);
foldersYear(1:2) = [];

%����ÿ���µĽ���id
monDay1s = [1,32,60,91,121,152,182,213,244,274,305,335];%��������ʼ���
monDay1e = [31,59,90,120,151,181,212,243,273,304,334,365];%������ֹ���
monDay2s = [1,32,61,92,122,153,183,214,245,275,306,336];%������ʼ���
monDay2e = [31,60,91,121,152,182,213,244,274,305,335,366];%����ֹ���

%�����ļ��У�i_folder���������
for i_folder = 2:21
    thisFolderPath = [foldersYear(i_folder).folder,'\',foldersYear(i_folder).name];
    files = dir(thisFolderPath);
    files(1:2) = [];
    fileNum0 = size(files);
    fileNum = fileNum0(1);
    
    %Ԥ����������
    result = zeros(row,col,12)-9999;
    
    %����ÿһ���ļ�
    for i_file = 1:fileNum
        %��ȡ���ļ�
        thisFilePath = [files(i_file).folder,'\',files(i_file).name];
        thisFile = ncread(thisFilePath,'clear_daily_SIF');
        %����������,��-9999��Ϊnan
        thisFile = rot90(thisFile);
        thisFile(thisFile==-9999) = nan;
        %�ز���
        thisFile_re = nan(row,col);
        for i_lon = 1:col
            for i_lat = 1:row
                window = thisFile(i_lat*10-9:i_lat*10,i_lon*10-9:i_lon*10);
                window_r = reshape(window,1,100);
                thisFile_re(i_lat,i_lon) = mean(window_r,'omitnan');
            end
        end
        %ȡ������
        thisFile_re = thisFile_re(1:row,:);
        %ȡ�ñ��ļ������
        thisFileName = files(i_file).name;
        thisFileName_split = strsplit(thisFileName,'.');
        thisFileNo = char(thisFileName_split(5));
        thisFileNo = str2double(thisFileNo(5:7));
        %�жϱ��ļ������ĸ��·�
        for i_mon = 1:12
            if(rem(i_folder,4)~=0)%������
                if(thisFileNo>=monDay1s(i_mon) && thisFileNo<=monDay1e(i_mon))
                    thisFileMonth=  i_mon;
                end
            else%����
                if(thisFileNo>=monDay2s(i_mon) && thisFileNo<=monDay2e(i_mon))
                    thisFileMonth = i_mon;
                end
            end
        end
        
        %ȡ������·ݵ��ļ����뱾�ļ��ϲ�Ϊһ����ά����
        matCom = cat(3,thisFile_re,result(:,:,thisFileMonth));
        matMax = max(matCom,[],3,'omitnan');
        matMax(matMax==-9999) = nan;
        %�Ƚϴ�С�󣬸�ֵ���������
        result(:,:,thisFileMonth) = matMax;
    end
    disp(i_folder);
    %������
    thisSavePath = [saveRootPath,num2str(1999+i_folder,'%2d')];
    save(thisSavePath,'result')
end

%%
% ������
for i=1:12
    subplot(3,4,i)
    imagesc(result(:,:,i),[0 0.6]);colorbar
    title(num2str(i))
end
