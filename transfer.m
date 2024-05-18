function [path] = transfer(varargin)
% Function for saving given variables to a transfer file
% for including and automatically updating latex scripts
    path = varargin{1}
    fileID = fopen(path,'w');
    %nargin
    for i = 2:1:nargin
        val = "";
        if isa(varargin{i},"sym")
            val = latex(varargin{i});
        elseif isa(varargin{i},"float")
            val = string(round(varargin{i},4,"significant"))
        else
            val = string(varargin{i});
        end
        nam = erase(inputname(i),"_")
        % i'd rather have it with \t than , but cant get it to work in latex
        fprintf(fileID,'%s,%s\n',nam,val);
        %inputname(i)
        %varargin{i}
    end
    fclose(fileID);
end
