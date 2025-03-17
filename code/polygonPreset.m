
clear all;

% Script for plotting the serendipity coordinates of a preset polygon

addpath('MV\','plots\','serendipity\','Wachspress\','interpolation\',...
    'Cao\', 'DHC\');

Q = 3;
pol = 4;
p = 0.3;

switch pol
    case 1
        V = [[0;0] [1;0] [1;1] [0;1]];
    case 2
        V = [[0;0] [1;0] [1;1] [1/2;1] [0;1]];
    case 3
        V = [[0;0] [1;0] [1;1/2] [1/2;1/2] [1/2;1] [0;1]];
    case 4
        V = [[0;0] [1;0] [0;1]];
    case 5
        V = [[0;1] [0.5;1] [1;1] [0;0]];
    case 6
        V = [[0;0] [1/3;1/3] [1;1] [0.8;0.2]];
    case 7
        V = [[0;0] [1/3;1/100] [1;0] [1/2;1]];
    case 8
        V = [[0;0] [1;0] [2/3;1/2] [1;1]];
    case 9
        V = [[0;0] [1;0] [1;1-p] [1-p;1] [0;1]];
    case 10
        V = [[0;0] [1;0] [1;0.9] [p;0.9] [0;1]];
    case 11
        V = [[0;0] [1-p;0] [1;p] [1;1]];
    case 12
        V = [[0;0] [1;0] [1;0.9] [1/2;0.9+p] [0;0.9]];
    case 13
        V = [[0;0] [1-p;0] [1;p] [0;p]];
    case 14
        V = [[0;0] [0.1;0] [1;p/2] [0.1;p] [0;p]];
    case 15
        V = [[0;0] [1;0] [1;p/2] [0;p]];
end

[fSer,axSer,X,Y,tr,C,u,pts] = Serendipity(V,Q);
%[fSer,axSer,C,u] = Serendipity_old(V,Q);