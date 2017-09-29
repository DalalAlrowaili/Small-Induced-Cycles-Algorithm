
%% Algorithm7: CASE 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%% Cycles of length 7  %%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% CASE 1: An edge in N2(x)and A vertex in N3(x) 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          x
%                          * 
%                         / \
%                        /   \
%                       /     \
%                      /       \
%     N1x :       v3p *         * v1p
%                     |         |
%                     |   v2    |
%     N2x :        v3 *---*     * v1
%                          \   /
%                           \ /
%                            *
%                            z
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%if(~any(x==C7))
    
    
    
% % Cycles of length 7

for i=1:EGcN2xsz
ei = EGcN2xk{i};
[v1i,v2i] = ind2sub(size(G),ei);
for j=1:EGcN2xsz
    ej = EGcN2xk{j};
    [v1j,v2j] = ind2sub(size(G),ej);
    if (ei==ej)
        continue;
    end
    
    b1 = (v2i==v2j);
    b2 = (v1i==v2j);
    b3 = (v2i==v1j);
    b4 = (v1i==v1j);
    
    if (b1)
        v1 = v2i;
        v2 = v1i;
        v3 = v1j;
    elseif (b2)
        v1 = v1i;
        v2 = v2i;
        v3 = v1j;
    elseif (b3)
        v1 = v2i;
        v2 = v1i;
        v3 = v2j;
    elseif (b4)
        v1 = v1i;
        v2 = v2i;
        v3 = v2j;
    else
        continue;
    end
    
    
    ek1 = sub2ind(size(G),v2,v3);
    ek2 = sub2ind(size(G),v3,v2);
    if (~EGN2x.isKey(ek1) && ~EGN2x.isKey(ek2))
        continue;
    end
    
    z = containers.Map('KeyType','uint32','ValueType','uint8');
    v1ps = containers.Map('KeyType','uint32','ValueType','uint8');
    v3ps = containers.Map('KeyType','uint32','ValueType','uint8');
    % Set of v1p, v2p, z correspoinding to fixed v1, v2, v3
    % Note that v1p, v3p may be adjacent
    for k=1:n  
        a = N1x.isKey(k);    % N1x  
        b = G(k,v1)==1;      % N1v1  
        c = G(k,v3)==1;      % N1v3 
        d = N3x.isKey(k);    % N3x
        e = G(k,v2)==1;      % N1v2
        
        % Check if vertex j is element in  
        %   set v1ps = N1x intersect N1v1 / N1v2 / N3x
        if ( (a&&b) && ~(c||d||e) )
            v1ps(k) = 1;
        end
        
        % Check if vertex j is element in  
        %   set v3ps = N1x intersect N1v3 / N1v1 / N3x
        if ((a&&c) && ~(b||d||e) )
            v3ps(k) = 1;
        end
        % z(j) = N3x intersect N1v1 intersect  N1v2
        if ( b && ~c && d && e)
            z(k) = 1;
        end
    end 
    zk = z.keys;
    zsz = z.size(1);   
    
    for k=1:EGcN1xsz
        ek = EGcN1xk{k};
        
        [vp_a,vp_b] = ind2sub(size(G),ek);
        
        if( v1ps.isKey(vp_a) && v3ps.isKey(vp_b) )
            v1p = vp_a;
            v3p = vp_b;
            % Loop (k) over fixed z        
            for l=1:zsz
                z = zk{l};
                if(G(v3,z)==0 && G(z,v3)==0)
                    index7 = index7+1;
                    C7(index7,:) = [x v1p v1 z v2 v3 v3p x ];
                end
            end
        elseif( v1ps.isKey(vp_b) && v3ps.isKey(vp_a) )
            v1p = vp_b;
            v3p = vp_a;
            % Loop (k) over fixed z        
            for l=1:zsz
                z = zk{l};
                if(G(v3,z)==0 && G(z,v3)==0)
                    index7 = index7+1;
                    C7(index7,:) = [x v1p v1 z v2 v3 v3p x ];
                end
            end
        end        
    end     
end 
end

%end



%% Algorithm7: CASE 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% CASE 2:  2 vertices in N3(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%                         x
%                         *
%                        / \
%                       /   \
%     N1x :      v1pp  *     *  v2pp
%                      |     |
%     N2x :      v1p   *     *  v2p
%                      |     |
%     N3x :      v1    *-----*  v2
%
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% STEP ???: Graph E(G[N_3(x)]) and  E(G^c[N_3(x)])
% Hash GN3x and Hash of GcN3x
EGN3x = containers.Map('KeyType','uint32','ValueType','uint8');
EGcN3x = containers.Map('KeyType','uint32','ValueType','uint8');
 
for i=1:N3xsz
    v1 = N3xk{i};
    for j=(i+1):N3xsz % loop over upper triangular elements
        v2 = N3xk{j};
        if G(v1,v2)==1
            EGN3x(sub2ind(size(G),v1,v2)) = 1;
        else
            EGcN3x(sub2ind(size(G),v1,v2)) = 1;
        end
    end
end
EGN3xk = EGN3x.keys;
EGcN3xk = EGcN3x.keys;
EGN3xsz = EGN3x.size(1);
EGcN3xsz = EGcN3x.size(1);


%if(~any(x==C7))


    
for i=1:EGN3xsz
    ei = EGN3xk{i};
    [v1,v2] = ind2sub(size(G),ei);

    v1ps = containers.Map('KeyType','uint32','ValueType','uint8');
    v2ps = containers.Map('KeyType','uint32','ValueType','uint8');
    for k=1:n  
        a = N2x.isKey(k);    % N2x  
        b = G(k,v1)==1;      % N1v1  
        c = G(k,v2)==1;      % N1v2 
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
    end
        
    for j=1:EGcN2xsz
        ej = EGcN2xk{j};
        [vp_a,vp_b] = ind2sub(size(G),ej);
        
        % The following if statement will check if they are 
        % actually valid parents.  Now the outer loop is
        % for fixed v1p, v2p
        case7_2=0;
        if( v1ps.isKey(vp_a) && v2ps.isKey(vp_b) )
            v1p = vp_a;
            v2p = vp_b;
            case7_2=1;
        elseif( v1ps.isKey(vp_b) && v2ps.isKey(vp_a) )
            v1p = vp_b;
            v2p = vp_a;
            case7_2=1;
        end

        if(case7_2)
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
                    index7 = index7+1;
                    C7(index7,:) = [ x v1pp v1p v1 v2 v2p v2pp x ];
                elseif( v1pps.isKey(vpp_b) && v2pps.isKey(vpp_a) )
                    v1pp = vpp_b;
                    v2pp = vpp_a;
                    index7 = index7+1;
                    C7(index7,:) = [ x v1pp v1p v1 v2 v2p v2pp x ];
                end
            end
        end
    end
end



%end



%% Algorithm7: CASE 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%% CASE 3:  4 vertices in N2(x)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                          x
%                          * 
%                         / \
%                        /   \
%                       /     \
%                      /       \
%     N1x :      v1p  *         *  v2p
%                     |         |
%                     |         |
%     N2x :      v1   *--*---*--*  v2
%                        z1  z2
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%



%if(~any(x==C7))

    
    
for i=1:EGcN2xsz
    z1s = containers.Map('KeyType','uint32','ValueType','uint8');
    z2s = containers.Map('KeyType','uint32','ValueType','uint8');
    Ez1z2 = containers.Map('KeyType','uint32','ValueType','uint8');

    v1ps = containers.Map('KeyType','uint32','ValueType','uint8');
    v2ps = containers.Map('KeyType','uint32','ValueType','uint8');
    ei = EGcN2xk{i};
    [v1,v2] = ind2sub(size(G),ei);

    
    % Set of v1p, v2p, z1, z2 correspoinding to fixed v1, v2
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
        
        % Check if vertex j is element in  
        %   set z1s = N2x intersect N1v1 / N1v2
         if ( (b&&d) && ~c )
            z1s(j) = 1;
        end
        
        % Check if vertex j is element in  
        %   set  z2s = N2x intersect N1v2 / N1v1
        if ((c&&d) && ~b )
            z2s(j) = 1;
        end
        
    end
    z1ssz = z1s.size(1);
    z1sk = z1s.keys();
    z2ssz = z2s.size(1);
    z2sk = z2s.keys();
    
    for j=1:z1ssz
        z1 = z1sk{j};
        for k=1:z2ssz
            z2 = z2sk{k};
            z1z2 = sub2ind(size(G),z1,z2);
            z2z1 = sub2ind(size(G),z2,z1);
            
            a = EGN2x.isKey(z1z2);    % EGN2x
            b = EGN2x.isKey(z2z1);    % EGN2x

            if (a || b)
                Ez1z2(z1z2) = 1;
            end
        end
    end
    Ez1z2k = Ez1z2.keys;
    Ez1z2sz = Ez1z2.size(1);
   
    
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
            % Loop (k) over fixed edge ek       
            for k=1:Ez1z2sz
                ek = Ez1z2k{k};
                [z1_a,z2_b] = ind2sub(size(G),ek);
                if(G(v1p,z1)==0 && G(v2p,z1)==0 && G(v1p,z2)==0 && G(v2p,z2)==0)
                    index7 = index7+1;
                    C7(index7,:) = [x v1p v1 z1 z2 v2 v2p x ];
                end
            end
        elseif( v1ps.isKey(vp_b) && v2ps.isKey(vp_a) )
            v1p = vp_b;
            v2p = vp_a;    
            % Loop (k) over fixed edge ek       
            for k=1:Ez1z2sz
                ek = Ez1z2k{k};
                [z1_a,z2_b] = ind2sub(size(G),ek);
                if(G(v1p,z1)==0 && G(v2p,z1)==0 && G(v1p,z2)==0 && G(v2p,z2)==0)
                    index7 = index7+1;
                    C7(index7,:) = [x v1p v1 z1 z2 v2 v2p x ];
                end
            end  
     
         end        
    end     
end

%end

