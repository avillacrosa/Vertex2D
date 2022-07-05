function [Geo, Mat, Set] = InputTest()
    close all; clear; clc;
    addpath(genpath('Src'));

    Geo.nx = 8;
    Geo.ny = 8;

	Set.tend=300;
	Set.Nincr=300;

	Set.OutputFolder='Result/Test';
    Mat = struct();
end