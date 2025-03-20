function [mTDL, mPressT, mDrugLT] = WithinSession_Processes(mT, dex, sub_dir, indivIntake_figs, indivIntakefigs_savepath, groupIntake_figs, groupIntakefigs_savepath, saveTabs, tabs_savepath, figsave_type)
    % Analyze Rewarded Lever Pressing Across the Session
    % 97 = rewarded lever presses followed by head entry
    % 99 = rewarded head entries (preceded by lever press)

    % mTDL = mT(dex.all,:);
    % mTDL = mTDL(mTDL.EarnedInfusions>10, :);
    mTDL_subset = intersect(dex.all, find(mT.Acquire=='Acquire' & mT.EarnedInfusions>10));
    mTDL = mT(mTDL_subset, :);
    
    mPressT = table;
    mDrugLT = table;
    
    wb = waitbar(0, ['Running individual within-session intake analysis... (0/' num2str(height(mTDL)) ')']);
    for i=1:height(mTDL)
        
        waitmessage = ['Running individual within-session intake analysis... (' num2str(i), '/' num2str(height(mTDL)) ')'];
        waitbar(i/height(mTDL), wb, waitmessage);

        ET = mTDL.eventTime{i};
        EC = mTDL.eventCode{i};
        doseHE = mTDL.doseHE{i};
        cumulDoseHE = cumsum(doseHE);
        rewHE = ET(EC==99);
        adj_rewLP = ET(EC==97);
        adj_rewLP_div60 = adj_rewLP / 60;
        conc = mTDL.Concentration(i);
    
        TagNumber=repmat([mTDL.TagNumber(i)],length(adj_rewLP),1);
        Session=repmat([mTDL.Session(i)],length(adj_rewLP),1);
        sessionType=repmat([mTDL.sessionType(i)],length(adj_rewLP),1);
        Sex =repmat([mTDL.Sex(i)],length(adj_rewLP),1);
        Strain =repmat([mTDL.Strain(i)],length(adj_rewLP),1);
    
        if i==1
            mPressT=table(TagNumber, Session, adj_rewLP, adj_rewLP_div60, cumulDoseHE, Sex, Strain, sessionType);
        else
            mPressT=[mPressT; table(TagNumber, Session, adj_rewLP, adj_rewLP_div60, cumulDoseHE, Sex, Strain, sessionType)];
        end
        
        infDur = 4; % duration of infusion in seconds
        sessDur = 180; % duration of session in minutes

        [DL, DLTime] = pharmacokineticsMouseOralFent('infusions',[rewHE*1000 (rewHE+(doseHE*infDur*1000))],'duration',sessDur,'type',4,'weight',mTDL.Weight(i)./1000,'mg_mL',conc/100,'mL_S',mTDL.DoseVolume(i)/infDur);
        DL = imresize(DL', [length(DLTime),1]);
        DLTime = DLTime';

        TagNumber = repmat([mTDL.TagNumber(i)],length(DL),1);
        Session = repmat([mTDL.Session(i)],length(DL),1);
        Sex = repmat([mTDL.Sex(i)],length(DL),1);
        Strain = repmat([mTDL.Strain(i)],length(DL),1);
        sessionType = repmat([mTDL.sessionType(i)],length(DL),1);
    
        if i==1
            mDrugLT = table(TagNumber, Session, DL, DLTime, Sex, Strain, sessionType);
        else
            mDrugLT = [mDrugLT; table(TagNumber, Session, DL, DLTime, Sex, Strain, sessionType)];
        end

        if indivIntake_figs 
            figpath = [sub_dir, indivIntakefigs_savepath, 'Tag', char(mTDL.TagNumber(i)), '_Session', char(string(mTDL.Session(i))), '_cumolDose_and_estBrainFent'];
            indiv_sessionIntakeBrainFentFig({adj_rewLP/60, DLTime}, {cumulDoseHE, DL(:)*1000}, figpath, figsave_type);
        end
    end
    close(wb)

    if saveTabs
        writeTabs(mPressT, [sub_dir, tabs_savepath, 'Within_Session_Responses'], {'.mat'})
        writeTabs(mDrugLT, [sub_dir, tabs_savepath, 'Within_Session_DrugLevel'], {'.mat'})
    end

    if indivIntake_figs
        IDs=unique(mPressT.TagNumber);
        for j=1:length(IDs)
            figpath = [sub_dir, indivIntakefigs_savepath, 'Tag', char(IDs(j)), '_allSessionCumulDose'];
            indiv_allSessionFig(mPressT, mPressT.TagNumber==IDs(j), 'adj_rewLP', "Time (m)", ...
                                'cumulDoseHE', "Cumulative Responses", ...
                                 ['ID: ' char(IDs(j))], 'Session', figpath, figsave_type, 'cumbin');

            figpath = [sub_dir, indivIntakefigs_savepath, 'Tag', char(IDs(j)), '_allSessionEstBrainFent'];
            indiv_allSessionFig(mDrugLT, mDrugLT.TagNumber==IDs(j), 'DLTime', "Time (m)", ...
                                'DL', "Estimated Brain Fentanyl (pMOL)", ...
                                 ['ID: ' char(IDs(j))], 'Session', figpath, figsave_type, 'line');
        end

        if any(ismember(fieldnames(dex), 'BE'))

            xtick = [0 90 180];
            xticklab = ["0", "90", "180"];
            legOptions = {'lightness', 'Session'};
            for j = 1:length(IDs)
                subset = (mPressT.TagNumber == IDs(j)) & (mPressT.sessionType == 'BehavioralEconomics');
                if ~isempty(find(subset))
                    figpath = [sub_dir, indivIntakefigs_savepath, 'BE_cumulDose_overlay_Tag_', char(IDs(j))];
                    subTab = mPressT(find(subset), :);
                    grammOptions = {'lightness', subTab.Session};
                    statOptions = {'normalization','cumcount','geom','stairs','edges',0:1:180};
                    pointOptions = {'markers',{'o','s'},'base_size',10};  
                    gramm_GroupFig(subTab, "adj_rewLP", "cumulDoseHE", "Time (m)", "Cumulative Responses", ...
                                   figpath, figsave_type, 'GrammOptions', grammOptions, 'LegOptions', legOptions, 'StatOptions', statOptions, 'PointOptions', pointOptions);
                end
                subset = (mDrugLT.TagNumber == IDs(j)) & (mDrugLT.sessionType == 'BehavioralEconomics');
                if ~isempty(find(subset))
                    figpath = [sub_dir, indivIntakefigs_savepath, 'BE_estBrainFent_overlay_Tag_', char(IDs(j))];
                    subTab = mDrugLT(find(subset), :);
                    grammOptions = {'lightness', subTab.Session};
                    statOptions = {'area'};
                   
                    gramm_GroupFig(subTab, "DLTime", "DL", "Time (m)", "Estimated Brain Fentanyl (pMOL)", ...
                                   figpath, figsave_type, 'GrammOptions', grammOptions, 'LegOptions', legOptions);    
                end
            end
        end
    end
    
    if groupIntake_figs   
        wrapOptions = {mDrugLT.Session,'scale','independent','ncols',5,'column_labels',1}; %'force_ticks',1,
        axOptions = {'LineWidth',1.5,'FontSize',10,'XLim',[0 180],'tickdir','out'};
        legOptions = {'color', 'Strain', 'lightness', 'Sex'};

        % Drug Level by Strain and Sex
        figpath = [sub_dir, groupIntakefigs_savepath, 'Drug Level Grouped by Sex and Strain'];
        grammOptions = {'color', mDrugLT.Strain, 'lightness', mDrugLT.Sex'};
        statOptions = {'geom', 'area', 'setylim',1};
        gramm_GroupFig(mDrugLT, "DLTime", "DL", "Time (m)", "Estimated Brain Fentanyl (pMOL)", figpath, figsave_type, ...
                      'GrammOptions', grammOptions, 'StatOptions', statOptions, 'WrapOptions', wrapOptions, 'AxOptions', axOptions, 'LegOptions', legOptions)

        % Drug Level by Strain and Sex during Training
        figpath = [sub_dir,groupIntakefigs_savepath, 'Drug Level Grouped by Sex and Strain during Training'];
        grammOptions = {'color', mDrugLT.Strain, 'lightness', mDrugLT.Sex', 'subset', mDrugLT.sessionType=='Training'};
        gramm_GroupFig(mDrugLT, "DLTime", "DL", "Time (m)", "Estimated Brain Fentanyl (pMOL)", figpath, figsave_type, ...
                      'GrammOptions', grammOptions, 'StatOptions', statOptions, 'WrapOptions', wrapOptions, 'AxOptions', axOptions, 'LegOptions', legOptions)

        % Drug Level by Sex and Session during Training Sessions 5, 10, 15
        figpath = [sub_dir, groupIntakefigs_savepath, 'Drug Level Grouped by Sex and Session 5 10 15'];
        subset = (mDrugLT.Session==5 | mDrugLT.Session==10 | mDrugLT.Session==15);
        grammOptions = {'color', mDrugLT.Strain, 'lightness', mDrugLT.Sex, 'subset', subset};
        statOptions = {'geom', 'line', 'setylim', 1};
        wrapOptions = {mDrugLT.Session,'scale','independent','ncols',3,'column_labels',1}; %'force_ticks',1,
        gramm_GroupFig(mDrugLT, "DLTime", "DL", "Time (m)", "Estimated Brain Fentanyl (pMOL)", figpath, figsave_type, ...
                       'GrammOptions', grammOptions, 'StatOptions', statOptions, 'WrapOptions', wrapOptions, 'AxOptions', axOptions, 'LegOptions', legOptions)

        % Cumulative responses (rewarded head entries) by Sex and Session during Training Sessions 5, 10, 15
        figpath = [sub_dir, groupIntakefigs_savepath, 'Mean Responses Grouped by Sex and Session 5 10 15'];
        subset = (mPressT.Session==5 | mPressT.Session==10 | mPressT.Session==15);
        grammOptions = {'color', mPressT.Strain, 'lightness', mPressT.Sex, 'subset', subset};
        statOptions = {'normalization','cumcount','geom','stairs','edges',0:1:180};
        wrapOptions = {mPressT.Session,'scale','independent','ncols',3,'column_labels',1}; %'force_ticks',1,
        gramm_GroupFig(mPressT, "adj_rewLP_div60", "cumulDoseHE", "Time (m)", "Cumulative Responses", figpath, figsave_type, ...
                       'GrammOptions', grammOptions, 'StatOptions', statOptions, 'WrapOptions', wrapOptions, 'AxOptions', axOptions, 'LegOptions', legOptions)
    end
end