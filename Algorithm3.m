%% Algorithm3

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Cycles of length 3  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                         x
%                         *
%                        / \
%                       /   \
%     N1x :      v1    *-----*  v2
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
 

%%%% STEP 1: N_1(x)
% Hash N1x
N1x = containers.Map('KeyType','uint32','ValueType','uint8');
for v=1:n
    if EG.isKey(sub2ind(size(G),x,v))
        N1x(v) = 1;
    end
end
N1xk = N1x.keys;
N1xsz = N1x.size(1);


%%%% STEP 2:  E(G[N_1(x)]) and E(G^c[N_1(x)])
% Hash EGN1x and Hash of EGcN1x
EGN1x = containers.Map('KeyType','uint32','ValueType','uint8');
EGcN1x = containers.Map('KeyType','uint32','ValueType','uint8');
for i=1:N1xsz
    v1 = N1xk{i};
    for j=(i+1):N1xsz
        v2 = N1xk{j};
        if G(v1,v2)==1
            EGN1x(sub2ind(size(G),v1,v2)) = 1;
        else
            EGcN1x(sub2ind(size(G),v1,v2)) = 1;
        end
    end
end
EGN1xk = EGN1x.keys;
EGcN1xk = EGcN1x.keys;
EGN1xsz = EGN1x.size(1);
EGcN1xsz = EGcN1x.size(1);


%if(~any(x==C3))
    
%%%% STEP 3:  Cycles of length 3
for i=1:EGN1xsz
    index3 = index3+1;
    [v1, v2] = ind2sub(size(G),EGN1xk{i});
    C3(index3,:) = [x v1 v2 x ];
end


%end