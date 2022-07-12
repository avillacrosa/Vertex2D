close all; clear; clc;
addpath(genpath('Src'));

[Geo, Mat, Set] = Compress;

RunVX(Geo, Mat, Set);