%% 校正前的根轨迹绘制
clear all
clc
num = [6.818];
den = [1, 0, -66.88];

rlocus(num, den)  % 绘制根轨迹
z = roots(num)     
p = roots(den)      %求根

figure(2)
sys = tf(num, den);
close_sys = feedback(sys,1);
step(close_sys)

