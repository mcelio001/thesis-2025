function u2 = plotCoordsTriang(f,ax,C,V,X,Y,tr,u,Q,pts)
    % Plot u-th generated serendipity coordinate on a polygon

    k = size(C,2);
    u = mod(u-1,k) + 1; % Allows for cycling through the coordinates

    cla(ax);
    if isempty(pts)
        plot3(ax, V(1,[1:end 1]), V(2,[1:end 1]), ...
            zeros(1,size(V,2)+1), 'r.-');
    else
        plot3(ax, V(1,[1:end 1]), V(2,[1:end 1]), ...
            zeros(1,size(V,2)+1), 'm.-');
    end
    hold(ax,'on');
    trisurf(tr,X,Y,C(:,u),'Parent',ax);%,'EdgeColor','none');
    hold(ax,'on');
    scatter3(ax,X(pts),Y(pts),C(pts,u), '.', 'r', 'SizeData', 100);
    %hold(ax,'on');
    %scatter3(ax,X,Y,C(:,u), '.', 'k');
    %title(ax,join(['Serendipity function i = ', int2str(u), ...
    %    ' (order = ', int2str(Q), ')'], ''))
    f.Color = '#FFFFFF';
    %exportapp(f,join(['bary_', int2str(u),'_i.png'],''));

    u2 = u;
end