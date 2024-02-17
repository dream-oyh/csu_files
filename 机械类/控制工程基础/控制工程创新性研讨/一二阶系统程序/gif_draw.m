clc
clear all
wn = 5;
v = 1;
%生成 y = x^n (n变化)图像的gif图
x = 0:0.01:1;
ksai = 0:0.01:2;
nImages = length(ksai); %图像数
fig = figure;

for idx = 1:nImages %索引
    f0 = two_response(wn, ksai(idx), 0)/wn;
    f1 = two_response(wn, ksai(idx), 1)/wn;
    f2 = two_response(wn, ksai(idx), 2)/wn;
    fplot([f0,f1,f2],'LineWidth',1);
    axis([0,10,-0.4,2]);
    title(['wn=',num2str(wn),'   ksai=',num2str(ksai(idx))]);
    legend({'脉冲响应','跃迁响应','斜坡响应'});
    drawnow
    %制作动画
    frame = getframe(fig);
    im{idx} = frame2im(frame);
    [A,map] = rgb2ind(im{idx},256); %将 RGB 图像转换为索引图像 A。map 最多包含 n 个颜色。
    if idx == 1
        imwrite(A,map,'filename','gif','LoopCount',Inf,'DelayTime',1/1000);%'DelayTime'为每帧图像播放时间
    else
        imwrite(A,map,'filename','gif','WriteMode','append','DelayTime',1/1000);
    end
end

function f = two_response(wn, ksai, v)
    syms s
    F = wn^2 / (s^v * (s^2 + 2 * ksai * wn * s + wn^2));
    f = ilaplace(F); 
end