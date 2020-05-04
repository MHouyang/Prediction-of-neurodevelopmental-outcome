%% Neurodevelopmental outcome prediction using support vector regression (SVR) with leave-one-out cross validation (LOOCV)
clc,close all;
clear;
format compact;
%addpath(genpath('libsvm'));    % add LIBSVM package; 1. Download package from https://www.csie.ntu.edu.tw/~cjlin/libsvm/ 2: put package into this script folder; 3: uncomment the command before using it

load('subject_feature.mat') 		% subject's brain feature: N subjects x M regions of interests. Here is regional cortical FA features. 
load('subject_score.mat')     		% corresponding neurodevelopmental outcomes: N subjects x 1 
subnum = size(subject_feature,1);   % number of subjects
ROInum = size(subject_feature,2);   % number of cortical ROIs

feature_vector = subject_feature;
neurodevelopmental_outcome = subject_score;
predicted_score = zeros(subnum,1);
weight = zeros(subnum,ROInum);

 for i = 1: subnum
    % prepare training and testing dataset using LOOCV
    index = 1:subnum;
    index(i)=[];
    index_training = index;   
    index_testing = i;
    feature_vector_train = feature_vector(index_training,:);
    neurodevelopmental_outcome_train = neurodevelopmental_outcome(index_training,:);
    feature_vector_test = feature_vector(index_testing,:);
    neurodevelopmental_outcome_test = neurodevelopmental_outcome(index_testing,:);
    
    % noralization of feature vectors
    d = feature_vector_train;
    feature_vector_train = (d -repmat(min(d,[],1),size(d,1),1))./repmat(max(d,[],1)-min(d,[],1),size(d,1),1);
    feature_vector_test=(feature_vector_test -min(d,[],1))./(max(d,[],1)-min(d,[],1));
    
    % building model
    svmopt = '-s 4 -t 0 -c 9 -g 10 -p 0.1';
    model = svmtrain(neurodevelopmental_outcome_train,feature_vector_train,svmopt);
    weight(i,:) = (model.SVs' * model.sv_coef)';
    
    % testing model
    [predict_val,mse,dec_val] = svmpredict(neurodevelopmental_outcome_test,feature_vector_test,model); 
    predicted_score(i) = predict_val;									   % predicted scores
 end
 
feature_contribution = abs(mean(weight,1)')/sum(abs(mean(weight,1)'));     % feature contribution
[RHO,PVAL] = corr(neurodevelopmental_outcome, predicted_score);            % correlation between predicted and actual scores
MAE = mean(abs((neurodevelopmental_outcome - predicted_score)));           % mean absolute error(MAE) between predicted and actual scores