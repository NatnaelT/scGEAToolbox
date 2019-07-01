function [cluster_labs,s]=run_simlr(X,k,donorm)
% sc_cluster - 
%
% REF: SoptSC: Similarity matrix optimization for clustering, lineage, and signaling inference
% Input X: 
% 
% USAGE:
% >> % [X,genelist]=sc_readfile('example_data/GSM3044891_GeneExp.UMIs.10X1.txt');
% load('example_data/example10xdata.mat');
% [C,s]=run_simlr(X,[],true);
% figure;
% scatter(s(:,1),s(:,2),20,C,'filled')

pw1=fileparts(which(mfilename));
pth=fullfile(pw1,'thirdparty/SIMLR');
addpath(pth);
pth=fullfile(pw1,'thirdparty/SIMLR/src');
addpath(pth);

if nargin<2
    k=[];
end

if nargin<3
    donorm=true;
end

if donorm
    [X]=sc_norm(X,'type','deseq');
    X=log10(X+1);
end

if isempty(k)
    [K1, K2] = Estimate_Number_of_Clusters_SIMLR(X',2:10);
    [~,i]=min(K2);
    k=i+1;
end

[y, S, F, ydata,alpha] = SIMLR_pearson(X',k,10);

cluster_labs=y;
s=ydata;

%    figure;
%    gscatter(ydata(:,1),ydata(:,2),y);
% figure;
% scatter(s(:,1),s(:,2),20,cluster_labs,'filled')
