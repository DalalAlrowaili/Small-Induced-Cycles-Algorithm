
%% Algorithm4

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Cycles of length 4  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         x
%                         *
%                        / \
%                       /   \
%     N1x :      v1p   *     *  v2p
%                       \   /
%                        \ /
%     N2x :               *
%                         v 
%                  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% STEP 4: N_2(x)
% Hash N2x
N2x = containers.Map('KeyType','uint32','ValueType','uint8');
for v1=1:N1xsz
    N1v1 = G(:,N1xk{v1});
    v2s = find(N1v1);
    for i=1:length(v2s)
        v2 = v2s(i);
        N2x(v2) = 1;
    end
end
if(N2x.isKey(x))
    N2x.remove(x);
end
for i=1:N1xsz
    v = N1xk{i};
    if N2x.isKey(v)
        N2x.remove(v);
    end
end
N2xk = N2x.keys;
N2xsz = N2x.size(1);
N2x;



%if(~any(x==C4))
    
    
%%%% STEP 5:  Cycles of length 4
for i=1:EGcN1xsz
    z = containers.Map('KeyType','uint32','ValueType','uint8');
    ei = EGcN1xk{i};
    [v1,v2] = ind2sub(size(G),ei);
    for j=1:n  
        % Check if z(j) is in intersection ...
        a = N2x.isKey(j);               %       N2x  intersect
        b = G(j,v1)==1;                 %       N1v1 intersect
        c = G(j,v2)==1;                 %       N1v2
        if ( a && b && c  )
            z(j) = 1;
        end
    end
    zk = z.keys;
    zsz = z.size(1);
    
    for j=1:zsz
        index4 = index4+1;
        C4(index4,:) = [x v1 zk{j} v2 x ];
    end
    
end

%end

