%gpp-tas-pr-rsds������gpp��tas��ƫ���ϵ����ƫ��С����ϵ��
%���룺ÿ��ģ�ʹ�2000-2100���gpp tas pr rsds
%�����gpp��tas��ƫ���ϵ������20��Ļ���ƽ����2019-2100���partialCorr�����pval����

function[]=fun_gppTasPartialCorr3(gpp_path,tas_path,pr_path,rsds_path,saveCorr_path,saveP_path,saveSen_path)

%�����ռ�ֱ�����ʱ��ֱ��ʣ���Ҫ����Ҫ�����и���
row=180;
col=720;
years=101;
years_result=82;

%����gpp
gpp=load(gpp_path);
gpp=gpp.result;
%����tas
tas=load(tas_path);
tas=tas.result;
%����pr
pr=load(pr_path);
pr=pr.result;
%����rsds
rsds=load(rsds_path);
rsds=rsds.result;

%Ԥ������������Ҫ����Ҫ�����и���
result=nan(row,col,years_result);     
result_pval=nan(row,col,years_result);
sensitivity = nan(row,col,years_result);  % ƫ��С����ϵ��

%�ж��ĸ�դ���Ϊ�ɼ��������ľ���
catMatrix=cat(3,gpp,tas,pr,rsds);
calMatrix=sum(catMatrix,3);

%����ÿһ��դ��
for i_lon=1:col
    for i_lat=1:row
        if(isnan(calMatrix(i_lat,i_lon)))
            continue;
        else
            %����Ϊ1*101���飬�����޷�Ӧ��detrend
            gpp_reshape=reshape(gpp(i_lat,i_lon,:),1,years);
            tas_reshape=reshape(tas(i_lat,i_lon,:),1,years);
            pr_reshape=reshape(pr(i_lat,i_lon,:),1,years);
            rsds_reshape=reshape(rsds(i_lat,i_lon,:),1,years);
            
            %20�껬��ƽ����ʹ��ȥ���ƺ�����ݼ���ƫ���ϵ��(2020-2100��)
            for i_year=1:years_result
                %ȡ�û���ƽ�����������
                gpp_thisYear=gpp_reshape(i_year:i_year+19);
                tas_thisYear=tas_reshape(i_year:i_year+19);
                pr_thisYear=pr_reshape(i_year:i_year+19);
                rsds_thisYear=rsds_reshape(i_year:i_year+19);
                %ȥ��һ����������
                gpp_detrend=detrend(gpp_thisYear);
                tas_detrend=detrend(tas_thisYear);
                pr_detrend=detrend(pr_thisYear);
                rsds_detrend=detrend(rsds_thisYear);
                
                %����ƫ���ϵ����rho��2*2���ϵ������pval��pֵ��ÿһ����һ��������
                [rho,pval]=partialcorr([gpp_detrend' tas_detrend'],[pr_detrend' rsds_detrend']);
                result(i_lat,i_lon,i_year)=rho(1,2);
                result_pval(i_lat,i_lon,i_year)=pval(1,2);
                
                %����ƫ��С����ϵ��
                if(length(unique(gpp_detrend))<3 || length(unique(tas_detrend))<3 || length(unique(pr_detrend))<3 ||  length(unique(rsds_detrend))<3)
                    continue
                end
                X = [tas_detrend' pr_detrend' rsds_detrend'];
                [~,~,~,~,beta,~,~,~] = plsregress(X,gpp_detrend');
                sensitivity(i_lat,i_lon,i_year) = beta(2);
            end
        end
    end
    disp(i_lon);
end

%��gpp��tas��ƫ���ϵ���������,��ƫ��С����ϵ������
save(saveCorr_path,'result');
save(saveP_path,'result_pval');
save(saveSen_path,'sensitivity');

