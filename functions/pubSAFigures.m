function pubSAFigures(mT, runType, dex, figFold, figsave_type)
% pubSAFigures Generates Clean Subset of Figures for Publication
% pT = the master behavior table from main_MouseSABehavior
% dt = current date time variable
% figFold = Name of the subfolder to save in (relative, folder name is suffiecient

for rt = 1:length(runType)
    expStr = char(string(runType(rt)));

    pT = mT(dex.(string(expStr)),:);
    if runType(rt) == 'ER'
        titles = {'Self-Administration', 'Session 15', 'Extinction', 'Reinstatement'}; % titles of subplots 1-4 for each figure
    elseif runType(rt) == 'BE'
        titles = {'Self-Administration', 'Session 15', 'Behavioral Economics', 'Retraining'};
    elseif runType(rt) == 'SA'
        titles = {'Self-Administration', 'Session 15'};
    end

    %% Active Lever All
    fnum = 1;
    figNames{fnum} = fullfile(figFold,[expStr, '_ActiveLeverAcquireVnonAquire']);
    subset = {{'Acquire', {'Acquire','NonAcquire'}}};
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'ActiveLever';
    yLabs{fnum} = 'Active Lever';
    cVars{fnum} = 'LHbAAV';
    grammOptions{fnum} = {'color', pT.LHbAAV, 'lightness', pT.Acquire};
    orderOptions{fnum} = {'color', {'Jaws', 'Control'}, 'lightness', {'NonAcquire','Acquire'}};
    legendOptions{fnum} = {'x','LHb AAV'};
    colorOptions{fnum} = {'hue_range',[25 385],'lightness_range',[95 60],'chroma_range',[50 70]};
    donut{fnum} = true;
    forceY{fnum} = false;

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Jaws Active Lever, Acquirers
    fnum = 2;
    figNames{fnum} = fullfile(figFold,[expStr, '_ActiveLeverJawsAcquire']);
    subset = {{'LHbAAV', {'Jaws'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'ActiveLever';
    yLabs{fnum} = 'Active Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[40 310],'lightness_range',[85 35],'chroma_range',[30 70]};
    donut{fnum} = false;
    forceY{fnum} = [200 200 200 200];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});
    
    %% Control Active Lever, Acquirers
    fnum = 3;
    figNames{fnum} = fullfile(figFold,[expStr, '_ActiveLeverControlAcquire']);
    subset = {{'LHbAAV', {'Control'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'ActiveLever';
    yLabs{fnum} = 'Active Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[85 -200],'lightness_range',[85 75],'chroma_range',[75 90]};
    donut{fnum} = false;
    forceY{fnum} = [200 200 200 200];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});
    
    %% Jaws Active Lever
    fnum = 4;
    figNames{fnum} = fullfile(figFold,[expStr, '_ActiveLeverJaws']);
    subset = {{'LHbAAV', {'Jaws'}}};
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'ActiveLever';
    yLabs{fnum} = 'Active Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex, 'lightness',pT.Acquire};
    orderOptions{fnum} = {'color',{'Female','Male'}, 'lightness',{'NonAcquire','Acquire'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[40 310],'lightness_range',[95 65],'chroma_range',[50 90]};
    donut{fnum} = true;
    forceY{fnum} = false;

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});
    
    %% Control Active Lever
    fnum = 5;
    figNames{fnum} = fullfile(figFold,[expStr, '_ActiveLeverControl']);
    subset = {{'LHbAAV', {'Control'}}};
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'ActiveLever';
    yLabs{fnum} = 'Active Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex, 'lightness',pT.Acquire};
    orderOptions{fnum} = {'color',{'Female','Male'}, 'lightness',{'NonAcquire','Acquire'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[85 -200],'lightness_range',[85 75],'chroma_range',[75 90]};
    donut{fnum} = true;
    forceY{fnum} = false;

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Jaws Inactive Lever, Acquirers
    fnum = 6;
    figNames{fnum} = fullfile(figFold,[expStr, '_InactiveLeverJawsAcquire']);
    subset = {{'LHbAAV', {'Jaws'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'InactiveLever';
    yLabs{fnum} = 'Inactive Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[40 310],'lightness_range',[85 35],'chroma_range',[30 70]};
    donut{fnum} = false;
    forceY{fnum} = [200 200 200 200];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Control Inactive Lever, Acquirers
    fnum = 7;
    figNames{fnum} = fullfile(figFold,[expStr, '_InactiveLeverControlAcquire']);
    subset = {{'LHbAAV', {'Control'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'InactiveLever';
    yLabs{fnum} = 'Inactive Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[85 -200],'lightness_range',[85 75],'chroma_range',[75 90]};
    donut{fnum} = false;
    forceY{fnum} = [200 200 200 200];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});
    
    %% Jaws Inactive Lever
    % SS note: Bar graph axes being set weird compared to the rest, why?
    fnum = 8;
    figNames{fnum} = fullfile(figFold,[expStr, '_InactiveLeverJaws']);
    subset = {{'LHbAAV', {'Jaws'}}};
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'InactiveLever';
    yLabs{fnum} = 'Inactive Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex, 'lightness',pT.Acquire};
    orderOptions{fnum} = {'color',{'Female','Male'}, 'lightness',{'NonAcquire','Acquire'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[40 310],'lightness_range',[95 65],'chroma_range',[50 90]};
    donut{fnum} = false;
    forceY{fnum} = false;

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Control Inactive Lever
    % SS note: Bar graph axes being set weird compared to the rest, why?
    fnum = 9;
    figNames{fnum} = fullfile(figFold,[expStr, '_InactiveLeverControl']);
    subset = {{'LHbAAV', {'Control'}}};
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'InactiveLever';
    yLabs{fnum} = 'Inactive Lever';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex, 'lightness',pT.Acquire};
    orderOptions{fnum} = {'color',{'Female','Male'}, 'lightness',{'NonAcquire','Acquire'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[85 -200],'lightness_range',[85 75],'chroma_range',[75 90]};
    donut{fnum} = false;
    forceY{fnum} = false;

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Jaws Head Entries, Acquirers
    fnum = 10;
    figNames{fnum} = fullfile(figFold,[expStr, '_HeadEntriesJawsAcquire']);
    subset = {{'LHbAAV', {'Jaws'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'HeadEntries';
    yLabs{fnum} = 'Head Entries';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[40 310],'lightness_range',[95 65],'chroma_range',[50 90]};
    donut{fnum} = false;
    forceY{fnum} = [600 600 600 600];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Control HeadEntries, Acquirers
    fnum = 11;
    figNames{fnum} = fullfile(figFold,[expStr, '_HeadEntriesLeverControlAcquire']);
    subset = {{'LHbAAV', {'Control'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'HeadEntries';
    yLabs{fnum} = 'Head Entries';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[85 -200],'lightness_range',[85 75],'chroma_range',[75 90]};
    donut{fnum} = false;
    forceY{fnum} = [600 600 600 600];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Jaws Latency, Acquirers
    fnum = 12;
    figNames{fnum} = fullfile(figFold,[expStr, '_LatencyJawsAcquire']);
    subset = {{'LHbAAV', {'Jaws'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'HeadEntries';
    yVars{fnum} = 'Latency';
    yLabs{fnum} = 'Head Entry Latency';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[40 310],'lightness_range',[95 65],'chroma_range',[50 90]};
    donut{fnum} = false;
    forceY{fnum} = [200 200 200 200];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});
  
    %% Control Latency, Acquirers
    fnum = 13;
    figNames{fnum} = fullfile(figFold,[expStr, '_LatencyControlAcquire']);
    subset = {{'LHbAAV', {'Control'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'Latency';
    yLabs{fnum} = 'Head Entry Latency';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[85 -200],'lightness_range',[85 75],'chroma_range',[75 90]};
    donut{fnum} = false;
    forceY{fnum} = [200 200 200 200];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Jaws Intake, Acquirers
    fnum = 14;
    figNames{fnum} = fullfile(figFold,[expStr, '_IntakeJawsAcquire']);
    subset = {{'LHbAAV', {'Jaws'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'Intake';
    yLabs{fnum} = 'Fentanyl Intake (ug/kg)';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[40 310],'lightness_range',[95 65],'chroma_range',[50 90]};
    donut{fnum} = false;
    forceY{fnum} = [4000 4000 4000 4000];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

    %% Control Intake, Acquirers
    fnum = 15;
    figNames{fnum} = fullfile(figFold,[expStr, '_IntakeControlAcquire']);
    subset = {{'LHbAAV', {'Control'}} ...
        {'Acquire', {'Acquire'}} ...
        };
    subInds{fnum} = getSubInds(pT, subset);
    yVars{fnum} = 'Intake';
    yLabs{fnum} = 'Fentanyl Intake (ug/kg)';
    cVars{fnum} = 'Sex';
    grammOptions{fnum} = {'color',pT.Sex};
    orderOptions{fnum} = {'color',{'Female','Male'}};
    legendOptions{fnum} = {'x','Sex'};
    colorOptions{fnum} = {'hue_range',[85 -200],'lightness_range',[85 75],'chroma_range',[75 90]};
    donut{fnum} = false;
    forceY{fnum} = [4000 4000 4000 4000];

    plotPubFig(pT, expStr, yVars{fnum}, yLabs{fnum}, forceY{fnum}, cVars{fnum}, subInds{fnum}, titles, figNames{fnum}, figsave_type, donut{fnum}, ...
        'GrammOptions', grammOptions{fnum}, 'ColorOptions', colorOptions{fnum}, ...
        'OrderOptions', orderOptions{fnum}, 'LegendOptions', legendOptions{fnum});

end
end

%%
function [g] = plotPubFig(pT, runType, yVar, yLab, forceY, cVar, subInd, titles, figName, figsave_type, donut, varargin)
    % try
    p = inputParser;
    addParameter(p, 'GrammOptions', {});            
    addParameter(p, 'ColorOptions', {})
    addParameter(p, 'OrderOptions', {});          
    addParameter(p, 'LegendOptions', {});
    
    parse(p, varargin{:});
    
    if runType == 'ER'
        sp_subInd = {subInd & (pT.sessionType=='PreTraining' | pT.sessionType=='Training'), ...
            subInd & (pT.sessionType=='PreTraining' | pT.sessionType=='Training') & pT.Session>14, ...
            subInd & (pT.sessionType=='Extinction'), ...
            subInd & pT.sessionType=='Reinstatement'};
        xLim = {[0, 15.5], [0.5 2.5], [15.5 25.5], [0.5 2.5]};
    elseif runType == 'BE'
        sp_subInd = {subInd & (pT.sessionType=='PreTraining' | pT.sessionType=='Training'), ...
            subInd & (pT.sessionType=='PreTraining' | pT.sessionType=='Training') & pT.Session>14, ...
            subInd & (pT.sessionType=='BehavioralEconomics'), ...
            subInd & (pT.sessionType=='ReTraining')};
        xLim = {[0, 15.5], [0.5 2.5], [15.5 20.5], [0.5 2.5]};
    elseif runType == 'SA'
        sp_subInd = {subInd & (pT.sessionType=='PreTraining' | pT.sessionType=='Training'), ...
            subInd & (pT.sessionType=='PreTraining' | pT.sessionType=='Training') & pT.Session>14};
        xLim = {[0, 15.5], [0.5 2.5]};
    end
    
    stat_set = {{'geom',{'black_errorbar','point','line'},'type','sem','dodge',0,'setylim',1,'width',1}, ...
        {'geom',{'black_errorbar','bar'},'type','sem','dodge',1.75,'width',1.5}};
    point_set = {{'base_size', 9}, {'base_size', 6}};
    if length(titles)==2
        f1=figure('Position',[1 300 600 300]);
    else
        f1=figure('Position',[1 300 1200 300]);
    end
    clear g;
    yMax = 0;

    noDat = zeros([length(sp_subInd), 1]);
    for sp = 1:length(sp_subInd)
        if isempty(pT.(yVar)(sp_subInd{sp}))
            noDat(sp) = 1;
        else
            if mod(sp,2) == 1
                g(1,sp)=gramm('x',pT.Session,'y',pT.(yVar),'subset', sp_subInd{sp}, p.Results.GrammOptions{:});
                g(1,sp).stat_summary(stat_set{1}{:});
                g(1,sp).set_point_options('markers',{'o','s'}, point_set{1}{:});
                g(1,sp).set_names('x','Session','y', yLab,'color',cVar);
                g(1,sp).no_legend;
            elseif mod(sp,2) == 0
                g(1,sp)=gramm('x', pT.(cVar),'y', pT.(yVar), 'subset', sp_subInd{sp}, p.Results.GrammOptions{:});
                g(1,sp).stat_summary(stat_set{2}{:});
                g(1,sp).set_point_options('markers',{'o','s'}, point_set{2}{:});
                g(1,sp).geom_jitter('alpha',.6,'dodge',1.75,'width',0.05);
                g(1,sp).set_names(p.Results.LegendOptions{:});
            end
            g(1,sp).set_text_options('font','Helvetica','base_size',13,'legend_scaling',.75,'legend_title_scaling',.75);
            g(1,sp).set_color_options(p.Results.ColorOptions{:});
            g(1,sp).set_order_options(p.Results.OrderOptions{:});
            g(1,sp).set_title(titles{sp});
        end
    end
    if exist('g', 'var')
        g.draw;
    end
    
    yMax = nan([length(sp_subInd), 1]);
    maxStat = nan([length(sp_subInd), 1]);
    for sp = 1:length(sp_subInd)
        if ~noDat(sp)
            for s = 1:length(g(1,sp).results.stat_summary)
                maxStat(s) = nanmax(g(1,sp).results.stat_summary(s).yci(:));
            end
            yMax(sp)=nanmax(maxStat);
        end
    end
    
    yMax = (ceil(yMax/10)*10)+10;
    
    if length(yMax)==4
        yMax(1:2)=max(yMax(1:2));
        yMax(3:4)=max(yMax(3:4));
    elseif length(yMax)==2
        yMax(1:2)=max(yMax(1:2));
    end

    if isnumeric(forceY)
       yMax=forceY;
    end
    
    for sp = 1:length(sp_subInd)
        %g(1,sp).axe_property('LineWidth', 1.5, 'XLim', xLim{sp}, 'YLim', [0 yMax(sp)], 'TickDir','out');
        if ~noDat(sp)
            % Title
            set(g(1,sp).title_axe_handle.Children ,'FontSize',12);
        
            if mod(sp,2) == 1
                % Marker Manipulation
                set(g(1,sp).results.stat_summary(1).point_handle,'MarkerEdgeColor',[0 0 0]);
                set(g(1,sp).results.stat_summary(2).point_handle,'MarkerEdgeColor',[0 0 0]);
                try
                    set(g(1,sp).results.stat_summary(3).point_handle,'MarkerEdgeColor',[0 0 0]);
                    set(g(1,sp).results.stat_summary(4).point_handle,'MarkerEdgeColor',[0 0 0]);
                catch
                end
            elseif mod(sp,2) == 0
                % Marker Manipulation
                set(g(1,sp).results.geom_jitter_handle(1),'MarkerEdgeColor',[0 0 0]);
                set(g(1,sp).results.geom_jitter_handle(2),'MarkerEdgeColor',[0 0 0]);
                set(g(1,sp).results.stat_summary(1).bar_handle,'EdgeColor',[0 0 0]);
                set(g(1,sp).results.stat_summary(2).bar_handle,'EdgeColor',[0 0 0]);
                try
                    set(g(1,sp).results.geom_jitter_handle(3),'MarkerEdgeColor',[0 0 0]);
                    set(g(1,sp).results.geom_jitter_handle(4),'MarkerEdgeColor',[0 0 0]);
                    set(g(1,sp).results.stat_summary(3).bar_handle,'EdgeColor',[0 0 0]);
                    set(g(1,sp).results.stat_summary(4).bar_handle,'EdgeColor',[0 0 0])
                catch
                end
            end
        end
    end

    % Axes Limits
    if ~noDat(1)
        set(g(1,1).facet_axes_handles,'YLim',[0 yMax(1)],'XLim',[0 15.5]);
    end

    if ~noDat(2)
        if strcmp(cVar,'LHbAAV')
            set(g(1,2).facet_axes_handles,'YLim',[0 yMax(2)],'XTickLabel',{'Control','Jaws'});
        elseif strcmp(cVar,'Sex')
            set(g(1,2).facet_axes_handles,'YLim',[0 yMax(2)],'XTickLabel',{char(9792),char(9794)});
        end
    end

     % Axes Limits
    if length(sp_subInd) > 2
        if ~noDat(3)
            if runType == 'ER'
                set(g(1,3).facet_axes_handles,'YLim',[0 yMax(3)],'XLim',[15 25.5],'XTick',[16 20 25],'XTickLabel',{'1','5','10'});
            elseif runType == 'BE'
                set(g(1,3).facet_axes_handles,'YLim',[0 yMax(3)],'XLim',[15 20.5],'XTick',[16 18 20],'XTickLabel',{'222','70','20'});
            end
        end
        
        if ~noDat(4)
            try
                if strcmp(cVar,'LHbAAV')
                    set(g(1,4).facet_axes_handles,'YLim',[0 yMax(4)],'XTickLabel',{'Control','Jaws'});
                elseif strcmp(cVar,'Sex')
                    set(g(1,4).facet_axes_handles,'YLim',[0 yMax(4)],'XTickLabel',{char(9792),char(9794)});
                end
            catch
            end
        end
    end
    
    % Remove & Move Axes
    if ~noDat(2)
        set(g(1,2).facet_axes_handles,'YColor',[1 1 1]);
        set(g(1,2).facet_axes_handles,'YLabel',[],'YTick',[]);
    
        if height(g(1, 2).results.geom_jitter_handle)==4
            pos1=g(1,2).facet_axes_handles.OuterPosition;
            set(g(1,2).facet_axes_handles,'OuterPosition',[pos1(1)-.04,pos1(2),pos1(3)-.04,pos1(4)]);
            pos2=g(1,2).title_axe_handle.OuterPosition;
            set(g(1,2).title_axe_handle,'OuterPosition',[pos2(1)-.05,pos2(2),pos2(3),pos2(4)]);
        elseif height(g(1, 2).results.geom_jitter_handle)==2
            pos1=g(1,2).facet_axes_handles.OuterPosition;
            set(g(1,2).facet_axes_handles,'OuterPosition',[pos1(1)-.03,pos1(2),pos1(3)-.1,pos1(4)]);
            pos2=g(1,2).title_axe_handle.OuterPosition;
            set(g(1,2).title_axe_handle,'OuterPosition',[pos2(1)-.08,pos2(2),pos2(3),pos2(4)])
        end
    end

   
    if length(sp_subInd) > 2
         if ~noDat(3)
            % Remove & Move Axes
            set(g(1,4).facet_axes_handles,'YColor',[1 1 1]);
            set(g(1,4).facet_axes_handles,'YLabel',[],'YTick',[]);
            pos5=g(1,3).facet_axes_handles.OuterPosition;
            set(g(1,3).facet_axes_handles,'OuterPosition',[pos5(1),pos5(2),pos5(3)-.065,pos5(4)]);
            pos6=g(1,3).title_axe_handle.OuterPosition;
            set(g(1,3).title_axe_handle,'OuterPosition',[pos6(1)-.035,pos6(2),pos6(3),pos6(4)]);
            if height(g(1, 2).results.geom_jitter_handle)==4
                pos3=g(1,4).facet_axes_handles.OuterPosition;
                set(g(1,4).facet_axes_handles,'OuterPosition',[pos3(1)-.09,pos3(2),pos3(3)-.04,pos3(4)]);
                pos4=g(1,4).title_axe_handle.OuterPosition;
                set(g(1,4).title_axe_handle,'OuterPosition',[pos4(1)-.09,pos4(2),pos4(3),pos4(4)]);
            elseif height(g(1, 2).results.geom_jitter_handle)==2
                pos3=g(1,4).facet_axes_handles.OuterPosition;
                set(g(1,4).facet_axes_handles,'OuterPosition',[pos3(1)-.08,pos3(2),pos3(3)-.11,pos3(4)]);
                pos4=g(1,4).title_axe_handle.OuterPosition;
                set(g(1,4).title_axe_handle,'OuterPosition',[pos4(1)-.135,pos4(2),pos4(3),pos4(4)]);
            end
        end
    end

     for sp = 1:length(sp_subInd)
         if ~noDat(sp)
            set(g(1,sp).facet_axes_handles,'LineWidth', 1.5, 'TickDir','out');
         end
     end
    
    % Export Figure
    for fst = 1:length(figsave_type)
        if strcmp(figsave_type{fst}, '.pdf')
            exportgraphics(gcf,[figName, figsave_type{fst}], 'ContentType','vector')
        else
            exportgraphics(gcf,[figName, figsave_type{fst}]);
        end
        disp(['saved figure: ', figName, figsave_type{fst}])
    end
    
    
    if donut
        plotDonut(pT, subInd, g, figName, figsave_type)
    end
    % catch
    % disp('oh no! had to skip a figure, wonder why??')
    % end
end
    
function plotDonut(pT, subInd, g, figName, figsave_type)
    % Donut Chart for Overlay
    groupStats = grpstats(pT(pT.Session==1 & subInd, :),["Sex","LHbAAV","Acquire"],["mean","sem"],"DataVars",'ActiveLever');
    % groupStats = sortrows(groupStats,"Acquire",'descend');
    f2=figure('Position',[1 300 575 575]);
    d=donutchart(groupStats.GroupCount, strrep(groupStats.Properties.RowNames, '_', ' '));
    d.InnerRadius=.45;
    % SS note: can't figure out how to make sure these colors correspond
    % to the figure when there are groups with no data
    % for s = 1:length(g(1,1).results.stat_summary)
    %     d.ColorOrder(s,1:3)=g(1,1).results.stat_summary(s).point_handle.MarkerFaceColor; % SS note: the hell is going on here w/ the stat summary indexing?
    % end
    d.FontSize=12.5;
    d.FontName='Arial Rounded MT Bold';
    
    % Export Figure
    for fst = 1:length(figsave_type)
        if strcmp(figsave_type{fst}, '.pdf')
            exportgraphics(gcf,[figName, '_Donut', figsave_type{fst}], 'ContentType','vector')
        else
            exportgraphics(gcf,[figName, '_Donut', figsave_type{fst}]);
        end
        disp(['saved figure: ', figName, '_Donut', figsave_type{fst}])
    end

end