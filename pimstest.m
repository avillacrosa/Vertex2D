close all; clear; clc;
addpath(genpath('Src'));

%% LOADS THE PROBLEM
[Geo, Mat, Set] = pimtopo;

Geo = RunVX(Geo, Mat, Set);
% PlotGeo(Geo)
