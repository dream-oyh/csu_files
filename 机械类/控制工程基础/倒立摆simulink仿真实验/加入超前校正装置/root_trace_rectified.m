% clc
% clear all
% z = [-23.25, sqrt(66.88), -sqrt(66.88)];
% p = [-7.876];
% K = 53.687 * 6.818;
% sys = zpk(p, z, K);
% rlocus(sys)
% T = feedback(sys,1)
% t = 0:0.005:10;
% figure(2)
% step(T,t)
clc
clear all
w = pi;
t = 0:0.01:2*pi;
y = sin(w*t);
plot(t,y)