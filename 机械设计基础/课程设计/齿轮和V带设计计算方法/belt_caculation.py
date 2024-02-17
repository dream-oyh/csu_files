import math

def d2(n_1, n_2, d1, epsilon):
    return n_1 * d1 * (1 - epsilon) / n_2


def v(d1, n_1):
    return math.pi * d1 * n_1 / (60 * 1000)


def L0(a0, d1, d2):
    return 2 * a0 + math.pi / 2 * (d1 + d2) + (d2 - d1) ** 2 / (4 * a0)


def z(K_A, P, P0, delta_P, K_alpha, K_L):
    return math.ceil(K_A * P / ((P0 + delta_P) * K_alpha * K_L))


def F0(K_A, P, z, v, K_alpha, q):
    return 500 * K_A * P / (z * v) * (2.5 / K_alpha - 1) + q * v**2


def FQ(z, F0, alpha):
    return 2 * z * F0 * math.sin(alpha / 2 * math.pi / 180)


n_1 = 970  # 电动机（小轮）满载转速——电动机型号
n_2 = 301  # 大轮转速
i = n_1 / n_2  # 带传动比
print("i=" + str(format(i, ".2f")))
P = 7.5  # V 带输入功率/kW（选取小轮与大轮的较大者）
K_A = 1.2  # 工作情况系数
P_c = K_A * P  # 计算功率
print("P_c=" + str(format(P_c, ".2f")))
d_1 = int(input("选取小轮直径/mm："))
epsilon = 0.02  # 弹性传动比
P0 = 2.08  # V 带基本额定功率表 13-4 查
delta_P = 0.3  # 额定功率增量表 13-6 查
q = 0.170  # 带单位长度质量/kg/m

d_2 = d2(n_1, n_2, d_1, epsilon)
print("d2=" + str(format(d_2, ".2f")))
d_2 = int(
    input("计算出的 d2 值为" + str(format(d_2, ".2f")) + "，请根据 V 带轮的基准直径，选择与 d2 最接近的直径为/mm：")
)
v_0 = v(d_1, n_1)
print("v=" + str(format(v_0, ".2f")))
a0 = 1.5 * (d_1 + d_2)
print("a0=" + str(format(a0, ".2f")))

a_min = format(0.7 * (d_1 + d_2), ".2f")
a_max = format(2 * (d_1 + d_2), ".2f")
a0 = int(
    input(
        "计算出的 a0 为"
        + str(format(a0, ".2f"))
        + f"，请四舍五入，将 a0 取整，且保证 a0 的值在{a_min}到{a_max}之间/mm:"
    )
)
L_0 = L0(a0, d_1, d_2)
print("L0=" + str(format(L_0, ".2f")))
L_d = int(input("计算出的 L0 为" + str(format(L_0, ".2f")) + f",请根据表 13-2 选用实际带长为/mm："))
K_L = float(input("选择带长修正系数为："))
a = a0 + (L_d - L_0) / 2
print("实际中心距 a=" + str(format(a, ".2f")))
alpha1 = 180 - (d_2 - d_1) * 57.3 / a
print("小带轮包角 alpha=" + str(format(alpha1, ".2f")))
K_alpha = float(input("请根据表 13-8 选择包角修正系数为："))

z_0 = z(K_A, P, P0, delta_P, K_alpha, K_L)
print("V 带根数为 z=" + str(format(z_0, ".2f")))
F_0 = F0(K_A, P, z_0, v_0, K_alpha, q)
print("初拉力 F0 =" + str(format(F_0, ".2f")))
F_Q = FQ(z_0, F_0, alpha1)
print("作用在轴上的压力 FQ=" + str(format(F_Q, ".2f")))
