function [X,Y,tr] = triangleMatlab(V,h)
    % Generate triangular mesh over polygon, using Matlab functionalities

    if nargin == 1
        h = 0.04;
    end

    % Convert polygon into polyshape object
    pgon = polyshape(V(1,:),V(2,:),'KeepCollinearPoints',true);
    % Create triangulation object from polyshape
    tr = triangulation(pgon);
    % Create fegeometry object from triangulation
    gm = fegeometry(tr);
    % Generate (finer) mesh over fegeometry object
    gm = generateMesh(gm, "GeometricOrder", "linear", Hmax=h);

    % Use mesh nodes as basis for new triangulation
    X = gm.Mesh.Nodes(1,:);
    Y = gm.Mesh.Nodes(2,:);
    % Make sure all polygon vertices are included in the mesh points
    % (added to account for collinear vertices)
    k = size(V,2);
    for i = 1:k
        if ~(ismember(V(:,i)',[X;Y]','rows'))
            X = [X V(1,i)];
            Y = [Y V(2,i)];
        end
    end

    % Create Delaunay triangulation
    TR = delaunayTriangulation(X',Y');
    tr = TR.ConnectivityList;
    % Remove all triangles outside the polygon
    C = incenter(TR);
    tr = tr(inpolygon(C(:,1),C(:,2),V(1,:),V(2,:)),:);
end