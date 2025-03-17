clear all;

% Script for letting the user draw a polygon and plotting its serendipity coordinates

addpath('MV\','plots\','serendipity\','Wachspress\','interpolation\',...
    'Cao\', 'DHC\');

Q = 2;

% Draws a point on the plane
function V2 = drawPointFun(ax,V,BO)
    % Get current mouse position (between 0 and 1 on the axis plane)
    u = get(ax, 'currentpoint');
    u = u(1,1:2);
    % Check if the point is within the axis plane
    % If it's barely outside, it's counted as being on the border
    a = abs(u-0.5);
    if (a(1) < 0.55 && a(2) < 0.55)
        u = min(u,1);
        u = max(u,0);
        % Add point to polygon
        V2 = [V u'];
    
        % Re-plot the polygon and the plot borders
        cla(ax);
        plot(ax, BO(1,[1:end 1]), BO(2,[1:end 1]), 'k.-');
        plot(ax, V2(1,[1:end 1]), V2(2,[1:end 1]), 'r.-');
    else
        V2 = V;
    end
end
% Clears the plot and the polygon
function V = clearPolFun(ax,BO)
    % Clear the polygon
    V = [];

    % Re-plot the border
    cla(ax);
    plot(ax, BO(1,[1:end 1]), BO(2,[1:end 1]), 'k.-');
end

% UI figure for drawing polygon
fPol = uifigure();
axPol = uiaxes(fPol,'Position',[115 80 310 310]);
BO = [[0;0] [0;1] [1;1] [1;0]]; % Plot border
plot(axPol, BO(1,[1:end 1]), BO(2,[1:end 1]), 'k.-');
hold(axPol,"on");
title(axPol, 'Draw your polygon!')

V = [];

% Function variables to make them callable
drawPoint = @(ax,V,BO) drawPointFun(ax,V,BO);
clearPol = @(ax,BO) clearPolFun(ax,BO);

% If the window is clicked, draw a point
set(fPol, 'WindowButtonDownFcn', 'V=drawPoint(axPol,V,BO);');
% Button for plotting serendipity coordinates
uibutton(fPol,'Position',[165 50 100 22], ...
  'Text','Serendipity', ...
  'ButtonPushedFcn','[fSer,axSer,X,Y,tr,C,u,pts] = Serendipity(V,Q);');
% Button for clearing the polygon and plot
uibutton(fPol,'Position',[285 50 100 22], ...
  'Text','Clear', ...
  'ButtonPushedFcn','V=clearPol(axPol,BO);');