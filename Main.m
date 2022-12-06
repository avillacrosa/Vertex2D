close all; clear; clc;
addpath(genpath('Src'));

% [Geo, Mat, Set] = Compress;
[Geo, Mat, Set] = TEST;

RunVX(Geo, Mat, Set);