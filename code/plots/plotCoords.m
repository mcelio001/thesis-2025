function u2 = plotCoords(f,ax,C,V,u,Q)
    % Plot u-th generated serendipity coordinate on a polygon

    k = size(C,3);
    n = size(C,1);
    u = mod(u-1,k) + 1; % Allows for cycling through the coordinates

    x = linspace(0,1,n);
    c = C(:,:,u);

    % Set up figure
    nl = 100; lw = 2; ms = 15;
    cla(ax);
    %axis('image');
    hold(ax,"on");
    % Contour plot of serendipity coordinate
    contour(ax,x,x,c',nl);
    %colormap("parula");
    % Plot polygon borders
    plot(ax,V(1,[1:end 1]), V(2,[1:end 1]), 'r.-', ...
        'LineWidth', lw, 'MarkerSize', ms);
    %title(ax,join(['Serendipity function i = ', int2str(u), ...
        %' (order = ', int2str(Q), ')'], ''))
    f.Color = '#FFFFFF';
    exportapp(f,join(['Wach_', int2str(u),'.pdf'],''))

    u2 = u;
end