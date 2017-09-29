
%% Algorithm5

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Cycles of length 5  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                         x
%                         *
%                        / \
%                       /   \
%     N1x :      v1p   *     *  v2p
%                      |     |
%     N2x :      v1    *-----*  v2
%                         
%                           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%% STEP 6:  E(G[N_2(x)]) and E(G^c[N_2(x)])
% Hash EGN2x and Hash of EGcN2x
EGN2x = containers.Map('KeyType','uint32','ValueType','uint8');
EGcN2x = containers.Map('KeyType','uint32','ValueType','uint8');
for i=1:N2xsz
    v1 = N2xk{i};
    for j=(i+1):N2xsz
        v2 = N2xk{j};
        if G(v1,v2)==1
            EGN2x(sub2ind(size(G),v1,v2)) = 1;
        else
            EGcN2x(sub2ind(size(G),v1,v2)) = 1;
        end
    end
end
EGN2xk = EGN2x.keys;
EGcN2xk = EGcN2x.keys;
EGN2xsz = EGN2x.size(1);
EGcN2xsz = EGcN2x.size(1);



%if(~any(x==C5))
 


%%%% STEP 7:  Cycles of length 5
for i=1:EGN2xsz
    v1ps = containers.Map('KeyType','uint32','ValueType','uint8');
    v2ps = containers.Map('KeyType','uint32','ValueType','uint8');
    ei = EGN2xk{i};
    [v1,v2] = ind2sub(size(G),ei);
    
    for j=1:n  
        a = N1x.isKey(j);    % N1x  
        b = G(j,v1)==1;      % N1v1  
        c = G(j,v2)==1;      % N1v2 
        
        % Check if vertex j is an element in 
        %   set v1ps = N1x intersect N1v1 / N1v2
        if ( a && b && ~c )
            v1ps(j) = 1;
        end
        
        % Check if vertex j is an element in 
        %   set v2ps = N1x intersect N1v2 / N1v1
        if ( a && c && ~b )
            v2ps(j) = 1;
        end
    end
    
    for j=1:EGcN1xsz
        ej = EGcN1xk{j};
        [vp_a,vp_b] = ind2sub(size(G),ej);
        % The following if statement will check if they are 
        % actually valid parents.  Now the outer loop is
        % for fixed v1p, v2p
        case5 = 0;
        if( v1ps.isKey(vp_a) && v2ps.isKey(vp_b) )
            v1p = vp_a;
            v2p = vp_b;
            case5=1;
        elseif( v1ps.isKey(vp_b) && v2ps.isKey(vp_a) )
            v1p = vp_b;
            v2p = vp_a;
            case5=1;
        end
        if(case5)
            index5 = index5+1;
            C5(index5,:) = [ x v1p v1 v2 v2p x ];
        end
          
    end

end
 
%end

