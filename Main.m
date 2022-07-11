close all; clear; clc;
addpath(genpath('Src'));

% [Geo, Mat, Set] = InputTest;
[Geo, Mat, Set] = InputCompress;


RunV3(Geo, Mat, Set);