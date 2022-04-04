%% Visualization Settings

linkDimension = 0.05;
dimensionVideo = [16/9 1]* 900;

stgs.visualizer.run              = 1;
stgs.visualizer.frameRate        = 24;
stgs.visualizer.limitMaximumTime = inf;

stgs.visualizer.statusTracker.workspacePrint.run        = 0;
stgs.visualizer.statusTracker.workspacePrint.frameRate  = 10;

stgs.visualizer.origin.dimCSYS            = linkDimension/5;
stgs.visualizer.mBody.bodyCSYS.show       = 0;
stgs.visualizer.mBody.bodyCSYS.dim        = linkDimension/10;
stgs.visualizer.mBody.jointCSYS.show      = 0;
stgs.visualizer.mBody.jointCSYS.dim       = linkDimension/10;

stgs.visualizer.joint.cone.show      = 0;
stgs.visualizer.joint.cone.stlName   = 'cone45.stl';
stgs.visualizer.joint.cone.angleIn   = 50*pi/180;
stgs.visualizer.joint.cone.angleDe   = 10*pi/180;
stgs.visualizer.joint.cone.color     = 'g';
stgs.visualizer.joint.cone.faceAlpha = 0.1;
stgs.visualizer.joint.cone.dim       = linkDimension/6;

stgs.visualizer.joint.sphere.show           = 0;
stgs.visualizer.joint.sphere.stlName        = 'sphere.stl';
stgs.visualizer.joint.sphere.colorBodyFrame = 1;
stgs.visualizer.joint.sphere.showNAct       = 0;
stgs.visualizer.joint.sphere.colorNAct      = [1 1 1];
stgs.visualizer.joint.sphere.faceAlpha      = 0.5;
stgs.visualizer.joint.sphere.dimMin         = linkDimension/6;
stgs.visualizer.joint.sphere.dimMax         = linkDimension;

stgs.visualizer.desiredShape.fun.show          = 1;
stgs.visualizer.desiredShape.fun.edgeColor     = [0.5 0.7 0.9];
stgs.visualizer.desiredShape.fun.faceColor     = [0.5 0.7 0.9];
stgs.visualizer.desiredShape.fun.edgeAlpha     = 0.5;
stgs.visualizer.desiredShape.fun.faceAlpha     = 0.1;
stgs.visualizer.desiredShape.fun.update        = 1;
stgs.visualizer.desiredShape.normal.show       = 0;
stgs.visualizer.desiredShape.normal.color      = [0.5 0.7 0.9];
stgs.visualizer.desiredShape.normal.linewidth  = 3;
stgs.visualizer.desiredShape.normal.dim        = linkDimension/10;
stgs.visualizer.desiredShape.points.show       = 0;
stgs.visualizer.desiredShape.points.color      = 'k';
stgs.visualizer.desiredShape.points.colorFace  = 'k';
stgs.visualizer.desiredShape.points.markerSize = 10;
stgs.visualizer.desiredShape.points.markerSym  = 'o';

stgs.visualizer.figure.backgroundColor = 'white';
stgs.visualizer.figure.windowState     = 'normal';
stgs.visualizer.figure.position        = [1 41 dimensionVideo];
stgs.visualizer.figure.showAxis        = 1;

stgs.visualizer.livePerformances.run           = 1;
stgs.visualizer.livePerformances.prctileValues = [10 90];

stgs.visualizer.cameraView.mBodySimulation.values        = [230 40];
stgs.visualizer.cameraView.initialRotation.run           = 1;
stgs.visualizer.cameraView.initialRotation.durationTotal = 13;
stgs.visualizer.cameraView.initialRotation.pause.start   = 2;
stgs.visualizer.cameraView.initialRotation.pause.end     = 7;
stgs.visualizer.cameraView.initialRotation.values        = [0,90];
stgs.visualizer.cameraView.finalRotation.run             = 1;
stgs.visualizer.cameraView.finalRotation.durationTotal   = 6;
stgs.visualizer.cameraView.finalRotation.pause.start     = 1;
stgs.visualizer.cameraView.finalRotation.pause.end       = 2;
stgs.visualizer.cameraView.finalRotation.values          = [90,0];

stgs.visualizer.background{1}.stlName = 'C:\Users\fbergonti\OneDrive - Fondazione Istituto Italiano Tecnologia\element_morphing-cover-design\cad\studies\008_icub-simp-rep/leg.stl';
stgs.visualizer.background{1}.tform_0_originSTL = getTformGivenPosRotm(zeros(3,1),createRotationMatrix(@rx,0));
stgs.visualizer.background{1}.scale     = [1 1 1]/1e3;
stgs.visualizer.background{1}.FaceColor = [0.7 0.7 0.7];
stgs.visualizer.background{1}.EdgeColor = 'none';
stgs.visualizer.background{1}.FaceAlpha = 0.3;

%stgs.visualizer.background = {};

stgs.visualizer.gif.save             = 0;
stgs.visualizer.gif.name             = ['iCubThigh.gif'];
stgs.visualizer.gif.compressionRatio = 2;

stgs.visualizer.video.save    = 1;
stgs.visualizer.video.name    = ['iCubThigh.mp4'];
stgs.visualizer.video.quality = 100;
