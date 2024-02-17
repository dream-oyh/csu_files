// typst 0.10.0
#import "template.typ": *
#import "@preview/tablex:0.0.6": tablex, hlinex
#import "template.typ": tablem, three-line-table

#show: project.with(
  title: "MATLAB Final Week Review",
  authors: (
    "Dream",
  )
)
= MATLAB可能会用得上的一些小tips

+ 对$m times n$矩阵$A$为例，矩阵元素$A(i,j)$的序号为$(j-1)times m + i$，相互转换关系也可以通过`sub2ind`和`ind2sub`转换
+ 三个取整的函数区别：`floor(x)`是向数轴左侧取整，`fix(x)`是向中部取整，`ceil(x)`是向数轴右侧取整
+ `rem(A,n)==0`能判断A中矩阵能否被n整除
+ 书`P33`页有将字符串中的小写字母变为大写字母，其余字符不变的程序，如果考试考到可以参考
+ 特殊矩阵：
    #align(center,[
#three-line-table[
|命令代码|生成矩阵|
|---|---|
|`zeros`|零矩阵|
|`ones`|一矩阵|
|`eye`|单位矩阵|
|`rand`|0~1均匀分布随机矩阵|
|`randn`|均值为0，方差为1的标准正态分布随机矩阵|
|`magic(n)`|n阶魔方矩阵|
|`vander(V)`|以向量V作为基础向量的范德蒙德矩阵|
|`hilb(n)`|希尔伯特矩阵|
|`invhilb(n)`|希尔伯特逆矩阵|
|`compan(p)`|伴随矩阵|
|`pascal(n)`|n阶帕斯卡矩阵|
|`diag(A)`|提取对角线元素|
|`diag(A,k)`|提取第k条对角线上的元素，主对角线是第0条，向上则依次+1，向下依次-1|
|`diag(V)`|构建以行向量V为对角线的对角线矩阵|
|`triu(A)`|取上三角矩阵|
|`triu(A,k)`|取A第k条对角线以上的元素|
|`tril(A)`|取下三角矩阵|
|`tril(A,k)`|取A第k条对角线以下的元素|
|`rot90(A,k)`|A矩阵*逆时针*翻转k次,k的缺省是1|
|`fliplr(A)`|左右翻转|
|`flipud(A)`|上下翻转|
|`norm(A,k)`|求范数，k=1,2,inf|
|`cond(A,k)`|求条件数，k=1,2,inf|
|`[V,D]=eig(A)`|求A的特征值矩阵与特征向量，V是特征值的对角线矩阵，D是对应特征向量|
]
]
)
+ 求多项式的根有两种方法
    ```m
% 方法一
P = [3 -7 0 5 2 -18];
A = compan(P) % 先求伴随矩阵
x = eig(A) %再求特征值，就直接得到根

% 方法二
P = [3 -7 0 5 2 -18];
x = roots(P);
    ```
+ switch语句表达式中，case的表达式如果是多个值，需要用cell矩阵，可借用`num2cell`把普通的数值矩阵转成cell
+ for循环的本质：
    ```m
    for 循环变量 = 矩阵表达式
        循环体语句
    end
    ```
    将矩阵的*各列元素*赋给循环变量，然后执行循环体语句
+ 当`norm(A,1)==0`时，可以认为A是很小的矩阵
+ 有两个预定义变量`nargin`和`nargout`能够记录调用该函数时输入实参与输出实参的个数
    ```m
    function fout = charray(a,b,c)
    if nargin == 1
        fout = a;
    elseif nargin == 2
        fout = a + b;
    elseif nargin == 3
        fout = (a*b*c)/2;
    end
    end
    ```
+ 其他形式的线性直角坐标图
    #align(center,[
#three-line-table[
|命令代码|用途|
|---|---|
|`bar(x,y,选项)`|条形图|
|`stairs(x,y,选项)`|阶梯图|
|`stem(x,y,选项)`|杆图|
|`fill(x,y,选项)`|填充图|
|`polar(theta,rho,选项)`|极坐标图|
|`semilogx(x,y,选项)`|半对数坐标，x轴为常用对数刻度，y保持线性刻度|
|`semilogy(x,y,选项)`|半对数坐标，y轴为常用对数刻度，x保持线性刻度|
|`loglog(x,y,选项)`|全对数坐标|
|`fplot(filename, lims, tol, 选项)`|书`P97`顶部，自适应曲线绘制|
]
]
)
+ 在用`mesh`, `surf`画三维图像之前，需要用`[X,Y] = meshgrid(x,y)`生成网格坐标矩阵
+ `mesh` or `surf`的调用： `mesh/surf(x,y,z)`即可
+ 一些难题的笔记：
    ```m
    % 两个等直径圆管的交线
    m = 30;
    z = 1.2 * (0 : m) / m;
    r = ones(size(z));
    theta = (0:m)/m * 2 * pi;
    x1 = r' * cos(theta);
    y1 = r' * sin(theta); % 生成第一个圆管的坐标矩阵
    z1 = z' * ones(1,m+1);
    x = (-m : 2 : m) / m;
    x2 = x' * ones(1, m+1);
    y2 = r' * sin(theta);
    z2 = r' * cos(theta);
    surf(x1,y1,z1);
    axis equal
    axis off
    hold on
    surf(x2,y2,z2);
    axis equal
    axis off
    hold off
    title("两个等直径圆管的交线")
    ```
    #figure(
      image("5.16.jpg", width:70%),
      caption: [执行结果],
    )

+ 求两平面交线
    ```MATLAB
   clc;
    clear;
    [x,y] = meshgrid(-10:0.2:10);
    z1 = (x.^2-2*y.^2) + eps;
    a = input('a=?')
    z2 = a * ones(size(x));
    subplot(1,2,1);
    mesh(x,y,z1);
    hold on;
    mesh(x,y,z2);
    v = [-10,10,-10,10,-100,100];
    axis(v);
    grid on;
    hold off;
    r0 = abs(z1 - z2)<=1;
    xx = r0.*x;
    yy = r0.*y;
    zz = r0.*z1;
    subplot(1,2,2);
    plot3(xx(r0~=0),yy(r0~=0),zz(r0~=0),'*');
    axis(v);
    grid on;
    ```
    #figure(
      image("5.17.jpg"),
      caption: [执行结果],
    )
+ 句柄部分先跳过，最后再看
