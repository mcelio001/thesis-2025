function area = signedArea(v1,v2,v3)
    area = 0.5 * (v1(1,:).*v2(2,:) + v2(1,:).*v3(2,:) + v3(1,:).*v1(2,:) - ...
        v1(1,:).*v3(2,:) - v2(1,:).*v1(2,:) - v3(1,:).*v2(2,:));
end