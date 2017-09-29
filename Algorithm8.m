%if(~any(x==C8))

%% Algorithm 8

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 1: One vertex in N4(x) (Isometric) %%%
%                   
%                         x
%                         *
%                        / \
%                       /   \
%     N1x :      v1pp  *     *  v2pp
%                      |     |
%     N2x :      v1p   *     *  v2p
%                      |     |
%     N3x :      v1    *     *  v2
%                       \   /
%     N4x :              \ /
%                         *
%                         z  
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Hash N4x
N4x = containers.Map('KeyType','uint32','ValueType','uint8');
for v1=1:N3xsz
    N1v1 = G(:,N3xk{v1});
    v2s = find(N1v1);
    for i=1:length(v2s)
        v2 = v2s(i);
        N4x(v2) = 1;
    end
end
% Remove verticies from N2x
for i=1:N2xsz
    v = N2xk{i};
    if N4x.isKey(v)
        N4x.remove(v);
    end
end
% Remove verticies from N3x
 for i=1:N3xsz
    v = N3xk{i};
    if N4x.isKey(v)
        N4x.remove(v);
    end
 end
N4xk = N4x.keys;
N4xsz = N4x.size(1);
N4x;


for i=1:EGcN3xsz
    ei = EGcN3xk{i};
    [v1,v2] = ind2sub(size(G),ei);
    zs = containers.Map('KeyType','uint32','ValueType','uint8');
    v1ps = containers.Map('KeyType','uint32','ValueType','uint8');
    v2ps = containers.Map('KeyType','uint32','ValueType','uint8');
    for k=1:n  
        a = N2x.isKey(k);    % N2x  
        b = G(k,v1)==1;      % N1v1  
        c = G(k,v2)==1;      % N1v2 
        d = N4x.isKey(k);    % N4x
        % Check if vertex k is an element in 
        %   set v1ps = N2x intersect N1v1 / N1v2
        if ( a && b && ~c )
            v1ps(k) = 1;
        end
        % Check if vertex k is an element in 
        %   set v2ps = N2x intersect N1v2 / N1v1
        if ( a && c && ~b )
            v2ps(k) = 1;
        end
        
        if ( b && c && d )
            zs(k) = 1;
        end
    end 
    zsk = zs.keys;
    zssz = zs.size(1); 
        
    for j=1:EGcN2xsz
        ej = EGcN2xk{j};
        [vp_a,vp_b] = ind2sub(size(G),ej);
        
        % The following if statement will check if they are 
        % actually valid parents.  Now the outer loop is
        % for fixed v1p, v2p
        case8=0;
        if( v1ps.isKey(vp_a) && v2ps.isKey(vp_b) )
            v1p = vp_a;
            v2p = vp_b;
            case8=1;
        elseif( v1ps.isKey(vp_b) && v2ps.isKey(vp_a) )
            v1p = vp_b;
            v2p = vp_a;
            case8=1;
        end

        if(case8)
            v1pps = containers.Map('KeyType','uint32','ValueType','uint8');
            v2pps = containers.Map('KeyType','uint32','ValueType','uint8');
            for k=1:n  
                a = N1x.isKey(k);     % N1x  
                b = G(k,v1p)==1;      % N1v1p  
                c = G(k,v2p)==1;      % N1v2p

                % Check if vertex k is an element in 
                %   set v1pps = N1x intersect N1v1 / N1v2
                if ( a && b && ~c )
                    v1pps(k) = 1;
                end

                % Check if vertex k is an element in 
                %   set v2pps = N1x intersect N1v2 / N1v1
                if ( a && c && ~b )
                    v2pps(k) = 1;
                end
            end

            for k=1:EGcN1xsz
                ek = EGcN1xk{k};
                [vpp_a,vpp_b] = ind2sub(size(G),ek);
                
                % The following if statement will check if they are 
                % actually valid parents.  Now the outer loop is
                % for fixed v1p, v2p
                if( v1pps.isKey(vpp_a) && v2pps.isKey(vpp_b) )
                    v1pp = vpp_a;
                    v2pp = vpp_b;
                    for ii=1:zssz
                        z = zsk{ii};
                        index8 = index8+1;
                        C8(index8,:) = [ x v1pp v1p v1 z v2 v2p v2pp x ];
                    end
                    
                elseif( v1pps.isKey(vpp_b) && v2pps.isKey(vpp_a) )
                    v1pp = vpp_b;
                    v2pp = vpp_a;
                    for ii=1:zssz
                        z = zsk{ii};
                        index8 = index8+1;
                        C8(index8,:) = [ x v1pp v1p v1 z v2 v2p v2pp x ];
                    end
                end
                
                
            end
        end
    end
end

%end

