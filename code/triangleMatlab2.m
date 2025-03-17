function [X,Y,tr] = triangleMatlab2(V,Q,p1,p2)
    % Generate triangular mesh over polygon, using Matlab functionalities

    if nargin == 1
        h = 0.04;
    end

    % Convert polygon into polyshape object
    % pgon = polyshape(V(1,:),V(2,:),'KeepCollinearPoints',true);
    % % Create triangulation object from polyshape
    % tr = triangulation(pgon);
    % % Create fegeometry object from triangulation
    % gm = fegeometry(tr);
    % % Generate (finer) mesh over fegeometry object
    % gm = generateMesh(gm, "GeometricOrder", "linear", Hmax=h);

    % % Use mesh nodes as basis for new triangulation
    % X = gm.Mesh.Nodes(1,:);
    % Y = gm.Mesh.Nodes(2,:);
    % Make sure all polygon vertices are included in the mesh points
    % (added to account for collinear vertices)

    x = linspace(0,1,p1);
    y = linspace(0,1,p2);
    [X,Y] = meshgrid(x,y);
    X = X(:)'; Y = Y(:)';

    [in,on] = inpolygon(X,Y,V(1,:),V(2,:));
    un = or(in,on);
    X = X(in);
    Y = Y(in);
    k = size(V,2);
    p = 1;
    for i = 1:k
        ux = linspace(V(1,i),V(1,mod(i,k)+1),p);
        uy = linspace(V(2,i),V(2,mod(i,k)+1),p);
        for j = 1:p
            X = [X ux];
            Y = [Y uy];
        end
    end
    P = unique([X;Y]','rows')';
    X = P(1,:);
    Y = P(2,:);

    % Create Delaunay triangulation
    TR = delaunayTriangulation(X',Y');
    tr = TR.ConnectivityList;
    % Remove all triangles outside the polygon
    C = incenter(TR);
    tr = tr(inpolygon(C(:,1),C(:,2),V(1,:),V(2,:)),:);

    %X = X';
    %Y = Y';
end