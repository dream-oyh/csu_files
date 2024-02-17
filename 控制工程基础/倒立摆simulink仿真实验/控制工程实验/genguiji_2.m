clear;
zg = [-13.535];
pg = [-136.166,sqrt(27),-sqrt(27)]
kg = 2.7*991.65;
G = zpk(zg,pg,kg);
closeG = feedback(1,G)
step(closeG)
grid on