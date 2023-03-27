close all; clear; clc;
addpath(genpath('Src'));

% [Geo, Mat, Set] = Compress;
% [Geo, Mat, Set] = Large;
% [Geo, Mat, Set] = Proliferation;
[Geo, Mat, Set] = Propulsion;

% [Geo, Mat, Set] = TEST;

RunVX(Geo, Mat, Set);
