function [fSer,axSer,C,u] = Serendipity_old(V,Q)
    % Check if the sequence of point is a polygon
    if (size(V,2) > 2)
        if (issimplified(polyshape(V(1,:),V(2,:), ...
                'Simplify',false,'KeepCollinearPoints',true)))
            u = 1; % Coordinate number

            % Generate meshgrid
            n = 200;
            x = linspace(0,1,n);
            [Y,X] = meshgrid(x,x);
            X = X(:);
            Y = Y(:);
            S = 1 - inpolygon(X,Y,V(1,:),V(2,:));
            
            % Serendipity coordinates
            %C = Serendipity_coord(X,Y,V,Q);
            C = Wach_coord(X,Y,V);
            C = reshape(C, n,n,[]);
            for i = 1:size(C,3)
                c = C(:,:,i);
                c(S == 1) = 0;
                C(:,:,i) = c;
            end
            
            % UI figure for visualizing serendipity coordinates
            fSer = uifigure();
            axSer = uiaxes(fSer,'Position',[125 100 300 300]);
            % Button for plotting previous coordinate
            uibutton(fSer,'Position',[165 50 100 22], ...
              'Text','Plot Previous', ...
              'ButtonPushedFcn','u=plotCoords(fSer,axSer,C,V,u-1,Q);');
            % Button for plotting next coordinate
            uibutton(fSer,'Position',[285 50 100 22], ...
              'Text','Plot Next', ...
              'ButtonPushedFcn','u=plotCoords(fSer,axSer,C,V,u+1,Q);');
            % Plot serendipity coordinates
            plotCoords(fSer,axSer,C,V,u,Q);
            
            %figure();
            %surf(X,Y,C(:,:,u));
        else
            axSer = 0; C = 0; u = 0;
        end
    else
        axSer = 0; C = 0; u = 0;
    end
end