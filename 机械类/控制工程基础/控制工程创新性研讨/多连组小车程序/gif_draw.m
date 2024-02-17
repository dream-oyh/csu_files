
clc
clear all
x = 0:0.01:1;
w = 0:0.01:2;
nImages = length(w); %图像数
fig = figure;

for idx = 1:nImages %索引
    [t,y] = plot_xva(w(idx));
    figure(1)
    plot(t,y(:,1),t,y(:,2),t,y(:,3),t,y(:,4),t,y(:,5),t,y(:,6),t,y(:,7),t,y(:,8));
    title(['w=',num2str(w(idx))]);
    drawnow
    %制作动画
    frame = getframe(fig);
    im{idx} = frame2im(frame);
    [A,map] = rgb2ind(im{idx},256); %将 RGB 图像转换为索引图像 A。map 最多包含 n 个颜色。
    if idx == 1
        imwrite(A,map,'filename','gif','LoopCount',Inf,'DelayTime',1/100);%'DelayTime'为每帧图像播放时间
    else
        imwrite(A,map,'filename','gif','WriteMode','append','DelayTime',1/1000);
    end
end

function [t,y] = plot_xva(w)
m = 1;
k = 1;
c = 1;
p0 = 1;
% w = 1;
M=diag([m,m,m,m,m,m,m,m]);
a=diag([3,2,2,2,2,2,2,3])+diag([-1,-1,-1,-1,-1,-1,-1],1)+diag([-1,-1,-1,-1,-1,-1,-1],-1);
K=k.*a;
C=c.*a;
t=0:0.0001:20;
u=p0*sin(w*t);
b=inv(M)*[1 0 0 0 0 0 0 0]';
A=[zeros(8),eye(8);-inv(M)*K,-inv(M)*C];
B=[zeros(8,1);[1 0 0 0 0 0 0 0]'];
C1=[eye(8) zeros(8);zeros(8) eye(8);-inv(M)*K,-inv(M)*C];
D=[zeros(16,1);b];
sys=ss(A,B,C1,D);
[y,t,~]=lsim(sys,u,t);
% figure(2)
% title(['p0=',num2str(p0)]);
% plot(t,y(:,9),t,y(:,10),t,y(:,11),t,y(:,12),t,y(:,13),t,y(:,14),t,y(:,15),t,y(:,16));
% figure(3)
% title(['p0=',num2str(p0)]);
% plot(t,y(:,17),t,y(:,18),t,y(:,19),t,y(:,20),t,y(:,21),t,y(:,22),t,y(:,23),t,y(:,24));  
end

