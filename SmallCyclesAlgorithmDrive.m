clc; close all; clear variables;

% Input Data Group 
% Note:  change this
data_group = 'dalal_01';


% Input
[data_path1,~,~] = fileparts(mfilename('fullpath'));
data_path2 = 'DrV_Data';
data_folders = dir(fullfile(data_path1,data_path2,data_group));
data_file2 = 'conmat.txt';
i=1;
for folder = data_folders'
    if(folder.name(1)~='.' && folder.isdir)
        Data1(i) = folder;
        disp(Data1(i));
        i=i+1;
    end
    
end


% Output
result_path1 = 'Results_345678';
result_path2 = fullfile(data_path1,data_path2,result_path1);

if ~exist(result_path2, 'dir')
  mkdir(result_path2);
end


result_latex = fullfile(result_path2,['table_' data_group '.txt']);
[tableFID, msg] = fopen(result_latex,'w');


for data1 = Data1
    fprintf(tableFID,'%s & ',data1.name);    

    data_filename = fullfile(data_path1,data_path2,data_group,data1.name,data_file2);
    resultname = fullfile(data_path1,data_path2,result_path1,[data1.name '_345678_cycles.txt']);
    resultFID = fopen(resultname,'w');

    %% Graph
    %G = G+G.';
    G = dlmread(data_filename);
    n=G(1,1);
    G=G(2:end,:);
    m = sum(sum(triu(G)));


    fmt1 = [ '%' num2str(ceil(log10(n))) '.0f ' ]  ;

    % Hash E(G)
    EG = containers.Map('KeyType','uint32','ValueType','uint8');
    [v1s, v2s] = find(G);
    for i=1:length(v1s)
        v1 = v1s(i);
        v2 = v2s(i);
        EG(sub2ind(size(G),v1,v2)) = 1;
    end

    %% Initialize
    MAX_CYCLES = 1e4;
    C3 = zeros(MAX_CYCLES,4,'uint32');   index3 = 0;
    C4 = zeros(MAX_CYCLES,5,'uint32');   index4 = 0;
    C5 = zeros(MAX_CYCLES,6,'uint32');   index5 = 0;
    C6 = zeros(MAX_CYCLES,7,'uint32');   index6 = 0;
    C7 = zeros(MAX_CYCLES,8,'uint32');   index7 = 0;
    C8 = zeros(MAX_CYCLES,9,'uint32');   index8 = 0;

    %% MAIN LOOP
    fprintf(tableFID,'%.0f & ',n); 
    fprintf(tableFID,'%.0f & ',m); 
    t=cputime;
    for x=1:n
        x    ;
        Algorithm3
        Algorithm4
        Algorithm5
        Algorithm6
        Algorithm7
        Algorithm8
        G(x,:) = 0;
        G(:,x) = 0;
    end
    time = cputime-t;

    C3 = C3(1:index3,:)
    sizeC3 = size(C3,1);

    C4 = C4(1:index4,:)
    sizeC4 = size(C4,1);

    C5 = C5(1:index5,:)
    sizeC5 = size(C5,1);

    C6 = C6(1:index6,:)
    sizeC6 = size(C6,1);

    C7 = C7(1:index7,:)
    sizeC7 = size(C7,1);

    C8 = C8(1:index8,:)
    sizeC8 = size(C8,1);

    if(sizeC3>0)
        fprintf(resultFID,'%.0f induced cycle(s) of length 3:\n',sizeC3);
        for i=1:sizeC3
            fprintf(resultFID,fmt1,C3(i,:));
            fprintf(resultFID,'\n');
        end
        fprintf(resultFID,'\n');
    end
    fprintf(tableFID,'%.0f & ',sizeC3); 


    if(sizeC4>0)
        fprintf(resultFID,'%.0f induced cycle(s) of length 4:\n',sizeC4);
        for i=1:sizeC4
            fprintf(resultFID,fmt1,C4(i,:));
            fprintf(resultFID,'\n');
        end
        fprintf(resultFID,'\n');
    end

    fprintf(tableFID,'%.0f & ',sizeC4);

    if(sizeC5>0)
        fprintf(resultFID,'%.0f induced cycle(s) of length 5:\n',sizeC5);
        for i=1:sizeC5
            fprintf(resultFID,fmt1,C5(i,:));
            fprintf(resultFID,'\n');
        end
        fprintf(resultFID,'\n');
    end

    fprintf(tableFID,'%.0f & ',sizeC5);

    if(sizeC6>0)
        fprintf(resultFID,'%.0f induced cycle(s) of length 6:\n',sizeC6);
        for i=1:sizeC6
            fprintf(resultFID,fmt1,C6(i,:));
            fprintf(resultFID,'\n');
        end
        fprintf(resultFID,'\n');
    end

    fprintf(tableFID,'%.0f & ',sizeC6);

    if(sizeC7>0)
        fprintf(resultFID,'%.0f induced cycle(s) of length 7:\n',sizeC7);
        for i=1:sizeC7
            fprintf(resultFID,fmt1,C7(i,:));
            fprintf(resultFID,'\n');
        end
        fprintf(resultFID,'\n');
    end

    fprintf(tableFID,'%.0f & ',sizeC7);

    if(sizeC8>0)
        fprintf(resultFID,'%.0f isometric cycle(s) of length 8:\n',sizeC8);
        for i=1:sizeC8
            fprintf(resultFID,fmt1,C8(i,:));
            fprintf(resultFID,'\n');
        end
        fprintf(resultFID,'\n');
    end
    fprintf(tableFID,'%.0f &',sizeC8);
    fprintf(tableFID,'%.2f \\\\\n',time);




    fclose(resultFID);


end

fclose(tableFID);