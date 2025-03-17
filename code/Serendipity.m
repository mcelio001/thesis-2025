function [fSer,axSer,X,Y,tr,C,u,pts] = Serendipity(V,Q)
    % Check if the sequence of point is a polygon
    if (size(V,2) > 2)
        if (issimplified(polyshape(V(1,:),V(2,:), ...
                'Simplify',false,'KeepCollinearPoints',true)))
            u = 1; % Coordinate number

            % Generate triangular mesh over polygon
            [tr,X,Y,~] = triangle(V',0.001);
            tr = tr(:,2:4);
            %[X,Y,tr] = triangleMatlab(V);
            %[X,Y,tr] = triangleMatlab2(V,Q,20,2000);
            
            % Serendipity coordinates
            pts = [];
            C = Serendipity_coord(X,Y,V,Q);
            %C = serendipityCao(X,Y,V);
            %C = Floater_coord(X,Y,V,Q);
            %C = MV_coord(X,Y,V);
            %C = Qth_coord(X,Y,V,Q);
            %C = DH_coord(X,Y,V);
            [C,pts] = interp(C,X,Y,V,Q);
            
            % UI figure for visualizing serendipity coordinates
            fSer = uifigure();
            axSer = uiaxes(fSer,'Position',[125 100 300 300]);
            % Button for plotting previous coordinate
            uibutton(fSer,'Position',[165 50 100 22], ...
              'Text','Plot Previous', ...
              'ButtonPushedFcn','u=plotCoordsTriang(fSer,axSer,C,V,X,Y,tr,u-1,Q,pts);');
            % Button for plotting next coordinate
            uibutton(fSer,'Position',[285 50 100 22], ...
              'Text','Plot Next', ...
              'ButtonPushedFcn','u=plotCoordsTriang(fSer,axSer,C,V,X,Y,tr,u+1,Q,pts);');
            % Plot serendipity coordinates
            plotCoordsTriang(fSer,axSer,C,V,X,Y,tr,u,Q,pts);
        else
            axSer = 0; X = 0; Y = 0; tr = 0; C = 0; u = 0;
        end
    else
        axSer = 0; X = 0; Y = 0; tr = 0; C = 0; u = 0;
    end
end