%generate wiring information for 32ch linear 
% probe with 100 micron spacing from Plexon 
%standard format for columns in probewiring:
%column 1: channel number 
%column 2: x
%column 3: y
%column 4: z
%column 5: shaft
function probewiring=probeConfig_Plex

probewiring=[
    31	0	0	0	1
30	0	0	100	1
29	0	0	200	1
28	0	0	300	1
27	0	0	400	1
26	0	0	500	1
25	0	0	600	1
24	0	0	700	1
23	0	0	800	1
22	0	0	900	1
21	0	0	1000	1
20	0	0	1100	1
19	0	0	1200	1
18	0	0	1300	1
17	0	0	1400	1
16	0	0	1500	1
15	0	0	1600	1
14	0	0	1700	1
13	0	0	1800	1
12	0	0	1900	1
11	0	0	2000	1
10	0	0	2100	1
9	0	0	2200	1
8	0	0	2300	1
7	0	0	2400	1
6	0	0	2500	1
5	0	0	2600	1
4	0	0	2700	1
3	0	0	2800	1
2	0	0	2900	1
1	0	0	3000	1
0	0	0	3100	1];