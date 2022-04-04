strTime = [datestr(now,'yyyy-mm-dd'),'_h',datestr(now,'HH-MM')];

%% Desired shape

f1 = @(x,y) 3*(x-0.07).^2-3*(y).^2; t1 = 10;
f2 = @(x,y) 7*(x-0.07).^2;          t2 = 15;
f3 = @(x,y) 3*(y.^2);               t3 = 25;
f4 = @(x,y) -3.5*(y.^2);

stgs.desiredShape.fun = @(x,y,t) (t<=t1)*f1(x,y) + (t>t1 & t<=t2)*f2(x,y) + (t>t2 & t<=t3)*f3(x,y) + (t>t3)*f4(x,y);
stgs.desiredShape.fun = @(x,y,t) stgs.desiredShape.fun(x,y,t)-stgs.desiredShape.fun(0,0,t)+0.055;
stgs.desiredShape.invertNormals = 1;

clear f1 f2 f3 f4

%% Saving & Logger

stgs.saving.workspace.run         = 1;
stgs.saving.workspace.name        = ['kinRel_',stgs.strMesh,'_',strTime,'.mat'];
stgs.saving.workspace.clearCasadi = 0;

%% StateKin Settings

stgs.stateKin.nullSpace.decompositionMethod    = 'qrFull';
stgs.stateKin.nullSpace.rankRevealingMethod    = 'limitParFunRatioSingularValues';
stgs.stateKin.nullSpace.toleranceRankRevealing = [10 1e-5];

%% Integration Settings

stgs.integrator.maxTimeStep      = 1e-2;
stgs.integrator.limitMaximumTime = 35;

stgs.integrator.odeOpts.solver = @ode45;
stgs.integrator.odeOpts.RelTol = 1e-3;
stgs.integrator.odeOpts.AbsTol = 1e-6;
stgs.integrator.assumeConst_dxdt = 1;
stgs.integrator.baumgarteIntegralCoefficient = 5e1;
stgs.integrator.regTermDampPInv = 1e-6;

stgs.integrator.statusTracker.workspacePrint.run        = 1;
stgs.integrator.statusTracker.workspacePrint.frameRate  = 10;
stgs.integrator.statusTracker.timeTrackerFile.run       = 1;
stgs.integrator.statusTracker.timeTrackerFile.frameRate = 100;               %[Hz]
stgs.integrator.statusTracker.timeTrackerFile.baseName  = ['kinRel_',stgs.strMesh]; %[char]
stgs.integrator.statusTracker.limitMaximumTime          = stgs.integrator.limitMaximumTime;

%% Controller

stgs.controller.casadi.optimizationType = 'conic';
stgs.controller.casadi.solver           = 'osqp';

stgs.controller.regTermDampPInv = 1e-6;

stgs.controller.costFunction.weightTaskOrientation  = 1;
stgs.controller.costFunction.weightTaskMinVariation = 500;
stgs.controller.costFunction.weightTaskMinOptiVar   = 0;

stgs.controller.costFunction.gainLinkAngVelStarAligned        = 30;
stgs.controller.costFunction.gainLinkAngVelStarOpposite       = 100;
stgs.controller.costFunction.useFeedForwardTermLinkAngVelStar = 1;

stgs.controller.constraints.eq2inep            = 0;
stgs.controller.constraints.limitPassiveAngVel = 5*pi/180; % "controller" limit (there is also the model limit)
stgs.controller.constraints.limitMotorVel      = 5*pi/180; % "controller" limit (there is also the model limit)
stgs.controller.constraints.limitRoM           = 50*pi/180; % "controller" limit (there is also the model limit)

stgs.controller.constraints.byPassModelLimits = 1;

%% Noise

stgs.noise.inputCompression.bool         = 0;
stgs.noise.inputCompression.maxValue     = 0.2;
stgs.noise.inputCompression.probMaxValue = 0.1;

stgs.noise.errorStateEstimation.bool         = 0;
stgs.noise.errorStateEstimation.maxValue     = 1*stgs.controller.constraints.limitMotorVel;
stgs.noise.errorStateEstimation.probMaxValue = 0.05;

%% Visualization Settings

stgs.visualizer.run              = 1;
stgs.visualizer.frameRate        = 20;
stgs.visualizer.limitMaximumTime = stgs.integrator.limitMaximumTime;

stgs.visualizer.statusTracker.workspacePrint.run        = 0;
stgs.visualizer.statusTracker.workspacePrint.frameRate  = 10;

stgs.visualizer.origin.dimCSYS            = cellCreator.cellLinks{1}.linkDimension/5;
stgs.visualizer.mBody.bodyCSYS.show       = 0;
stgs.visualizer.mBody.bodyCSYS.dim        = cellCreator.cellLinks{1}.linkDimension/10;
stgs.visualizer.mBody.jointCSYS.show      = 0;
stgs.visualizer.mBody.jointCSYS.dim       = cellCreator.cellLinks{1}.linkDimension/10;

stgs.visualizer.joint.cone.show      = 0;
stgs.visualizer.joint.cone.stlName   = 'cone45.stl';
stgs.visualizer.joint.cone.angleIn   = 50*pi/180;
stgs.visualizer.joint.cone.angleDe   = 10*pi/180;
stgs.visualizer.joint.cone.color     = 'g';
stgs.visualizer.joint.cone.faceAlpha = 0.1;
stgs.visualizer.joint.cone.dim       = cellCreator.cellLinks{1}.linkDimension/6;

stgs.visualizer.joint.sphere.show           = 0;
stgs.visualizer.joint.sphere.stlName        = 'sphere.stl';
stgs.visualizer.joint.sphere.colorBodyFrame = 0;
stgs.visualizer.joint.sphere.showNAct       = 0;
stgs.visualizer.joint.sphere.colorNAct      = [1 1 1];
stgs.visualizer.joint.sphere.faceAlpha      = 0.5;
stgs.visualizer.joint.sphere.dimMin         = cellCreator.cellLinks{1}.linkDimension/6;
stgs.visualizer.joint.sphere.dimMax         = cellCreator.cellLinks{1}.linkDimension;

stgs.visualizer.desiredShape.fun.show          = 1;
stgs.visualizer.desiredShape.fun.edgeColor     = [0.5 0.7 0.9];
stgs.visualizer.desiredShape.fun.faceColor     = [0.5 0.7 0.9];
stgs.visualizer.desiredShape.fun.edgeAlpha     = 0.5;
stgs.visualizer.desiredShape.fun.faceAlpha     = 0.1;
stgs.visualizer.desiredShape.fun.update        = 1;
stgs.visualizer.desiredShape.normal.show       = 0;
stgs.visualizer.desiredShape.normal.color      = 'b';
stgs.visualizer.desiredShape.normal.linewidth  = 3;
stgs.visualizer.desiredShape.normal.dim        = cellCreator.cellLinks{1}.linkDimension/10;
stgs.visualizer.desiredShape.points.show       = 0;
stgs.visualizer.desiredShape.points.color      = 'k';
stgs.visualizer.desiredShape.points.colorFace  = 'k';
stgs.visualizer.desiredShape.points.markerSize = 10;
stgs.visualizer.desiredShape.points.markerSym  = 'o';

stgs.visualizer.figure.backgroundColor = 'white';
stgs.visualizer.figure.windowState     = 'maximized';
stgs.visualizer.figure.position        = [617 157 741 782];
stgs.visualizer.figure.showAxis        = 1;

stgs.visualizer.livePerformances.run           = 1;
stgs.visualizer.livePerformances.prctileValues = [10 90];

stgs.visualizer.cameraView.mBodySimulation.values        = [230 40];
stgs.visualizer.cameraView.initialRotation.run           = 0;
stgs.visualizer.cameraView.initialRotation.durationTotal = 3;
stgs.visualizer.cameraView.initialRotation.pause.start   = 1;
stgs.visualizer.cameraView.initialRotation.pause.end     = 1;
stgs.visualizer.cameraView.initialRotation.values        = [0,0];
stgs.visualizer.cameraView.finalRotation.run             = 0;
stgs.visualizer.cameraView.finalRotation.durationTotal   = 5;
stgs.visualizer.cameraView.finalRotation.pause.start     = 1;
stgs.visualizer.cameraView.finalRotation.pause.end       = 1;
stgs.visualizer.cameraView.finalRotation.values          = [90,0];

stgs.visualizer.background{1}.stlName = '../../cad/studies/008_icub-simp-rep/leg.stl';
stgs.visualizer.background{1}.tform_0_originSTL = getTformGivenPosRotm(zeros(3,1),createRotationMatrix(@rx,0));
stgs.visualizer.background{1}.scale     = [1 1 1]/1e3;
stgs.visualizer.background{1}.FaceColor = [0.7 0.7 0.7];
stgs.visualizer.background{1}.EdgeColor = 'none';
stgs.visualizer.background{1}.FaceAlpha = 0.3;

%stgs.visualizer.background = {};

stgs.visualizer.gif.save             = 0;
stgs.visualizer.gif.name             = ['kinRel_',stgs.strMesh,'_',strTime,'.gif'];
stgs.visualizer.gif.compressionRatio = 2;

stgs.visualizer.video.save    = 1;
stgs.visualizer.video.name    = ['kinRel_',stgs.strMesh,'_',strTime,'.mp4'];
stgs.visualizer.video.quality = 5;

%%

clear strTime
