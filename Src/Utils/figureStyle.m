function figureStyle(f)
% 	grid minor
% 	grid on
	box on
	ax = f.CurrentAxes;
	ax.LineWidth = 1.8;
% 	ax.GridLineStyle = 'none';
% 	ax.GridColor = 'k';
% 	ax.GridAlpha = 0.2;
	ax.FontSize = 20; 
% 	ax.FontWeight = 'bold'; 
% 	ax.TickLabelInterpreter = 'latex';
	lines = findobj(ax,'Type','line');
	for li = 1:length(lines)
		lines(li).LineWidth=2;
		lines(li).MarkerSize=4;
	end
	ax.XLabel.Interpreter = 'latex';
	ax.XLabel.FontSize    = 20;
% 	ax.XLabel.FontName    = 'SansSerif';
	ax.YLabel.Interpreter = 'latex';
	ax.YLabel.FontSize    = 20;
% 	ax.YLabel.FontName    = 'SansSerif';
	if length(ax.YAxis) == 2
		ax.YAxis(1).Color = 'k';
		ax.YAxis(2).Color = 'r';
	else
		ax.YAxis.Color = 'k';
	end
	if ~isempty(ax.Legend)
% 		ax.Legend.Interpreter = 'latex';
		ax.Legend.FontSize    = 12;
% 		ax.Legend.Location    = 'best';
	end
	if ~isempty(ax.Colorbar)
		c = ax.Colorbar;
% 		c.Label.Interpreter = 'latex';
		c.FontSize = 20;
		set(c,'TickLabelInterpreter','latex')
	end
	if ~isempty(ax.Title)
		ax.Title.Interpreter = 'latex';
		ax.Title.FontSize    = 18;
	end
	f.Position = [100 100 800 800];
end