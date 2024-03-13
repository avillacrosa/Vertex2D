function [X, Xg] = BuildTopo(Geo, Set)
    nx = Geo.nx + 2; 
	ny = Geo.ny + 2;
	if strcmpi(Set.BC,'periodic')
		nx = nx + 1;
		ny = ny + 1;
    end
    % if ~isempty(Set.confR)
    %     x = 0:(nx-1);
	%     y = 0:(ny-1);
	%     [x,y] = meshgrid(x,y);
    %     x(1:2:end,:) = x(1:2:end,:) - 0.5;
    %     x = x - mean(mean(x));
    %     y = y - mean(mean(y));
    %     r = sqrt(x.^2 + y.^2);
    %     Xg = false(size(r));
    %     innerR = r < Set.confR;
    %     for i = 1:size(x,1)
    %         row = innerR(i,:);
    %         idx1 = find(row,1,'first');
    %         idx2 = find(row,1,'last');
    %         Xg(i,idx1-1) = true;
    %         Xg(i,idx2+1) = true;
    %     end
    %     for j = 1:size(x,2)
    %         col = innerR(:,j);
    %         idx1 = find(col,1,'first');
    %         idx2 = find(col,1,'last');
    %         Xg(idx1-1,j) = true;
    %         Xg(idx2+1,j) = true;
    %     end
    %     Xg = reshape(Xg,size(x,1)*size(x,2),1);
    %     x=reshape(x,size(x,1)*size(x,2),1);
    %     y=reshape(y,size(y,1)*size(y,2),1);
    %     X = [x y];
    %     rIdx = vecnorm(X,2,2) < Set.confR;
    %     allIdx = rIdx | Xg;
    %     X = X(allIdx,:);
    %     Xg = Xg(allIdx,:);
    % else 
        x = 0:(nx-1);
        y = 0:(ny-1);
        [x,y] = meshgrid(x,y);
        Xg = false(size(x));
        Xg(1,:)   = true;
        Xg(:,1)   = true;
        Xg(end,:) = true;
        Xg(:,end) = true;
        % x(1:2:end,:) = x(1:2:end,:) - 0.5;
        % y(:,1:2:end) = y(:,1:2:end) - 0.5;
        x=reshape(x,size(x,1)*size(x,2),1);
        y=reshape(y,size(y,1)*size(y,2),1);
        Xg = reshape(Xg,size(x,1)*size(x,2),1);
        X=[x y];
    % end
    X(:,1) = X(:,1) - mean(X(:,1));
    X(:,2) = X(:,2) - mean(X(:,2));
end