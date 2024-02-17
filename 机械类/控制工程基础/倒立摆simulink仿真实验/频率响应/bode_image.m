clear all
clc
num = 98 * [6.818];
den = [1 0 -66.88];
G = tf(num, den);
bode(G);
grid on
figure(2)
nyquist(num,den);
grid

z = roots(num);
p = roots(den);

za = [z; -14.28];
pa = [p; -143.71];
k = 986;
sys = zpk(za, pa, k);
figure(3)
bode(sys)
grid
figure(4)
nyquist(sys)
sysc = sys/(1+sys);
t = 0:0.005:3;
figure(5)
impulse(sysc,t)