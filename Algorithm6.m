
%% Algorithm6


%%%% STEP 8: N_3(x) 
% Hash N3x
N3x = containers.Map('KeyType','uint32','ValueType','uint8');
for v1=1:N2xsz
    N1v1 = G(:,N2xk{v1});
    v2s = find(N1v1);
    for i=1:length(v2s)
        v2 = v2s(i);
        N3x(v2) = 1;
    end
end
% Remove verticies from N1x
 for i=1:N1xsz
    v = N1xk{i};
    if N3x.isKey(v)
        N3x.remove(v);
    end
 end
% Remove verticies from N2x
for i=1:N2xsz
    v = N2xk{i};
    if N3x.isKey(v)
        N3x.remove(v);
    end
end
N3xk = N3x.keys;
N3xsz = N3x.size(1);
N3x;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 1: One vertex in N3(x) %%%%%%%%%%%%%%%
%                         x
%                         *
%                        / \
%                       /   \
%     N1x :      v1p   *     *  v2p
%                      |     |
%     N2x :      v1    *     *  v2
%                       \   /
%     N3x :              \ /
%                         *
%                         z  
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%if(~any(x==C6))
    
    
%%%% STEP 9
% Outer loop (i) over fixed ei in GcN2x
for i=1:EGcN2xsz
    z = containers.Map('KeyType','uint32','ValueType','uint8');
    v1ps = containers.Map('KeyType','uint32','ValueType','uint8');
    v2ps = containers.Map('KeyType','uint32','ValueType','uint8');
    ei = EGcN2xk{i};
    
    % Here v1, v2 are simply the vertices of edge ei
    [v1,v2] = ind2sub(size(G),ei);
    % Set of v1p, v2p, z correspoinding to fixed v1, v2
    % Note that v1p, v2p may be adjacent
    for j=1:n  
        a = N1x.isKey(j);    % N1x  
        b = G(j,v1)==1;      % N1v1  
        c = G(j,v2)==1;      % N1v2 
        d = N3x.isKey(j);    % N3x

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
        
        if ( b && c && d )
            z(j) = 1;
        end
    end 
    zk = z.keys;
    zsz = z.size(1);   

    % Find all cycles for fixed v1, v2        
    % Outer loop (j) over fixed edge in GcN1x ej 
    for j=1:EGcN1xsz
        ej = EGcN1xk{j};

        % Note vertices vp_a and vp_b are only possibly
        % vp1 and vp2.  So vp1 could be vp_a or vp_b and
        % vp2 could be vp_b or vp_a.
        % Here they are simply the vertices of edge ej
        [vp_a,vp_b] = ind2sub(size(G),ej);

        % The following if statement will check if they are 
        % actually valid parents.  Now the outer loop is
        % for fixed v1p, v2p
        if( v1ps.isKey(vp_a) && v2ps.isKey(vp_b) )
            v1p = vp_a;
            v2p = vp_b;
            % Loop (k) over fixed z        
            for k=1:zsz
                index6 = index6+1;
                C6(index6,:) = [x v1p v1 zk{k} v2 v2p x ];
            end
        elseif( v1ps.isKey(vp_b) && v2ps.isKey(vp_a) )
            v1p = vp_b;
            v2p = vp_a;
            % Loop (k) over fixed z        
            for k=1:zsz
                index6 = index6+1;
                C6(index6,:) = [x v1p v1 zk{k} v2 v2p x ];
            end
        end
        
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% CASE 2:  3 vertices in N2(x) %%%%%%%%%%%%%%
%                         x
%                         *
%                        / \
%                       /   \
%     N1x :      v1p   *     *  v2p
%                      |     |
%     N2x :      v1    *--*--*  v2
%                         z
%                           
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:EGcN2xsz
    z = containers.Map('KeyType','uint32','ValueType','uint8');
    v1ps = containers.Map('KeyType','uint32','ValueType','uint8');
    v2ps = containers.Map('KeyType','uint32','ValueType','uint8');
    ei = EGcN2xk{i};
    [v1,v2] = ind2sub(size(G),ei);
    
   % Set of v1p, v2p, z correspoinding to fixed v1, v2
    % Note that v1p, v2p may be adjacent
    for j=1:n  
        a = N1x.isKey(j);    % N1x  
        b = G(j,v1)==1;      % N1v1  
        c = G(j,v2)==1;      % N1v2 
        d = N2x.isKey(j);    % N2x
        
        % Check if vertex j is element in  
        %   set v1ps = N1x intersect N1v1 / N1v2 / N2x
        if ( (a&&b) && ~(c||d) )
            v1ps(j) = 1;
        end
        
        % Check if vertex j is element in  
        %   set v2ps = N1x intersect N1v2 / N1v1 / N2x
        if ((a&&c) && ~(b||d) )
            v2ps(j) = 1;
        end
        % z(j) = N2x intersect N1v1 intersect  N1v2
        if ( b && c && d )
            z(j) = 1;
        end
    end 
    zk = z.keys;
    zsz = z.size(1);   
    
    for j=1:EGcN1xsz
        ej = EGcN1xk{j};
         % Note vertices vp_a and vp_b are only possibly
        % vp1 and vp2.  So vp1 could be vp_a or vp_b and
        % vp2 could be vp_b or vp_a.
        % Here they are simply the vertices of edge ej
        
        [vp_a,vp_b] = ind2sub(size(G),ej);
        % The following if statement will check if they are 
        % actually valid parents.  Now the outer loop is
        % for fixed v1p, v2p
        if( v1ps.isKey(vp_a) && v2ps.isKey(vp_b) )
            v1p = vp_a;
            v2p = vp_b;
            % Loop (k) over fixed z        
            for k=1:zsz
                 z = zk{k};
                if(G(v1p,z)==0 && G(v2p,z)==0)
                    index6 = index6+1;
                    C6(index6,:) = [x v1p v1 zk{k} v2 v2p x ];
                end
            end
        elseif( v1ps.isKey(vp_b) && v2ps.isKey(vp_a) )
            v1p = vp_b;
            v2p = vp_a;
            % Loop (k) over fixed z        
            for k=1:zsz
                 z = zk{k};
                 if(G(v1p,z)==0 && G(v2p,z)==0)
                    index6 = index6+1;
                    C6(index6,:) = [x v1p v1 zk{k} v2 v2p x ];
                end
            end
        end        
    end     
end


%end

