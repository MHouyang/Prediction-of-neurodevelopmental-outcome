# Prediction-of-neurodevelopmental-outcome

The following items are included:
1. Custom code in Matlab for support vector regression (SVR) analysis with leave-one-out for prediction of neurodevelopmental outcome. 
   1) Script_SVR_LOOCV_analysis.m;

2. Demo input data:
   1) subject_feature.mat: N subjects x M regions of interests
   2) subject_score.mat: N subjects x 1 

3. Expected output for Script_SVR_LOOCV_analysis.m: 
	1) predicted_score: predicted neurodevelopmental outcome;
	2) RHO and MAE: correlation coefficient and mean absolute errors between predicted and acutal scores, respectively; 
	3) feature_contribution: contribution of each feature to the neurodevelopmental outcome prediction.

4. Installation guide & System requirements
Scripts have been tested on Matlab 2015a with LIBSVM (version 3.20, and 3.22) in Windows operating systems. 
Hardware requirement: Matlab scripts require only a standard computer with enough RAM (8+ GB is recommended).
Software requirement: SVR is implemented using LIBSVM package that can be freely downloaded from https://www.csie.ntu.edu.tw/~cjlin/libsvm/ .
