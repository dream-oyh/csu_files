import math


def d1(K, T1, phi_d, u, ZE, sigmaH):
    return 2.32 * ((K * T1) / (phi_d) * ((u + 1) / u) * (ZE / sigmaH) ** 2) ** (1 / 3)


def sigmaF1(K, T1, YFa, YSa, b, d1, m):
    return 2 * K * T1 * YFa * YSa / (b * d1 * m)


def sigmaF2(sigmaF1, YFa1, YFa2, YSa1, YSa2):
    return sigmaF1 * YFa2 * YSa2 / (YFa1 * YSa1)


def v(d1, n1):
    return math.pi * d1 * n1 / (60 * 1000)


def check_indensity(sigmaF_re, sigmaF, SF):
    sigma_allow = sigmaF / SF
    if sigmaF_re < sigma_allow:
        print("通过弯曲强度校验")
    else:
        print("请重新设计齿轮，弯曲强度校验不通过")


K = 1.2  # 载荷系数
P = 7  # 小齿轮传动功率 kW
n_1 = 301  # 小齿轮转速 r/min

phi_d = 1  # 齿宽系数
u = 3.06  # 齿轮传动比
ZE = 189.8  # 弹性系数锻钢 - 锻钢/ \sqrt{MPa}

z1 = 29  # 小齿轮齿数
z2 = 89  # 大齿轮齿数

sigmaH1_lim = 585  # 小齿轮接触疲劳强度
sigmaH2_lim = 375  # 大齿轮接触疲劳强度
sigmaF1_lim = 356  # 小齿轮弯曲疲劳强度
sigmaF2_lim = 248  # 大齿轮弯曲疲劳强度

SH = 1  # 接触疲劳安全系数
SF = 1.25  # 弯曲疲劳安全系数

YFa1 = 2.62  # 小齿轮齿形系数
YSa1 = 1.63  # 小齿轮应力修正系数
YFa2 = 2.24  # 大齿轮齿形系数
YSa2 = 1.78  # 大齿轮应力修正系数


T1 = 9.55 * 10**6 * P / n_1  # 小齿轮传动力矩
sigmaH = min(sigmaH1_lim / SH, sigmaH2_lim / SH)  # 较小的许用接触疲劳强度
d1_prev = d1(K, T1, phi_d, u, ZE, sigmaH)
m = math.ceil(d1_prev / z1)
d_1 = m * z1
b = d_1 * phi_d
a = (z1 + z2) * m / 2
sigma_F1 = sigmaF1(K, T1, YFa1, YSa1, b, d_1, m)
sigma_F2 = sigmaF2(sigma_F1, YFa1, YFa2, YSa1, YSa2)
v_0 = v(d_1, n_1)


print(f"m={m}")
print("T1=" + str(format(T1, ".2f")))
print("sigmaH_min=" + str(format(sigmaH, ".2f")))
print("d1_prev=" + str(format(d1_prev, ".2f")))
print("d1=" + str(format(d_1, ".2f")))
print("d2=" + str(format(z2 * m, ".2f")))
print("sigmaF1=" + str(format(sigma_F1, ".2f")))
print("sigmaF2=" + str(format(sigma_F2, ".2f")))
print("v=" + str(format(v_0, ".2f")))
print("a=" + str(format(a, ".2f")))
# 校验强度
print("小齿轮")
check_indensity(sigma_F1, sigmaF1_lim, SF)
print("大齿轮")
check_indensity(sigma_F2, sigmaF2_lim, SF)
