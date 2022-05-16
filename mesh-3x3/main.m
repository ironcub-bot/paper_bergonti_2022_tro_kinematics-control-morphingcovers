clear
clc
close all
fclose('all');
setup_mbodysim

%% user settings

stgs.simulation_with_noise         = true;
stgs.run_motor_placement_algorithm = true;

%% create model


if stgs.run_motor_placement_algorithm
    load('init.mat','cellCreator','mBodyPosQuat_0','model','stateKin','stgs')
    [model,sensitivity,genAlgrthm] = selectMotorPositioning('model',model,'state',stateKin,'cellCreator',cellCreator,'stgs',stgs);
else
    load('init.mat','mBodyPosQuat_0','model','stgs')
end

%% kinRel Simulation

stgs.startFile = stgs.saving.workspace.name;
configKinRel_3x3
data = runSimKinRel('model',model,'stgs',stgs,'mBodyPosQuat_0',mBodyPosQuat_0,'nameControllerClass','ControllerKinRel');
if stgs.visualizer.run
    visualizeResultsKinRel(stgs.saving.workspace.name)
end

%% visualizer functions

function visualizeResultsKinRel(nameMatfile)
    if exist(nameMatfile,'file')
        load(nameMatfile)
        dataLiveStatistics{1} = struct('data',abs(data.errorOrientationNormals),'title','Error alignment normal vectors','ylabel','Angle $[deg]$');
        dataLiveStatistics{2} = struct('data',abs(data.errorPositionNormals),'title','Node position error','ylabel','Distance $[m]$');
        dataLiveStatistics{3} = struct('data',abs(data.motorsAngVel),'title','Motor Angular velocity','ylabel','Velocity $[\frac{rad}{s}]$');
        dataLiveStatistics{4} = struct('data',abs(data.nDoF),'title','degrees of freedom','ylabel','DoF $[]$');    visual = VisualizerMatlab('data',data,'stgs',stgs,'model',model,'functionDesiredNormal',contr.csdFn.normalDes,'dataLiveStatistics',dataLiveStatistics);
        visual.runVisualizer()
        visual.save()
    else
        warning('Visualizer: file %s doesn''t exists',nameMatfile)
    end
end
