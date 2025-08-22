clc; clear;close all;

load("Copy of bayer1.mat");       
load("Copy of RawImage1.mat"); 
load("Copy of kodim19.mat");
load("Copy of kodim_cfa.mat");

% demos(bayer1, RawImage1, "True",1);
demos(cfa, raw, "False",2);


