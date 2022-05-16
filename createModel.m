clear
clc
close all
fclose('all');
setup_mbodysim

%%

stgs.nameSim = 'mesh-3x3';

%% create model

switch stgs.nameSim
    case 'mesh-3x3'
        meshDesign.initialConfiguration = 'flat';
        meshDesign.n = 3;
        meshDesign.m = 3;
    case 'mesh-8x8'
        meshDesign.initialConfiguration = 'flat';
        meshDesign.n = 8;
        meshDesign.m = 8;
    case 'mesh-20x20'
        meshDesign.initialConfiguration = 'flat';
        meshDesign.n = 20;
        meshDesign.m = 20;
    case 'iCubThigh'
        meshDesign.initialConfiguration = 'cylinder';
        meshDesign.n = 4;
        meshDesign.m = 8;
end

configModel
model = Model(cellCreator.cellAdjacency,cellCreator.cellLinks,stgs.unitMeas);

%% evaluate initial configuration

switch stgs.nameSim
    case 'mesh-3x3'
        stgs.desiredShape.fun = @(x,y)-5*(x.^2+y.^2);
    case 'mesh-8x8'
        stgs.desiredShape.fun = @(x,y)-2*(x.^2+y.^2);
    case 'mesh-20x20'
        stgs.desiredShape.fun = @(x,y) (2*(x-0.46).^2)-0.4232;
    case 'iCubThigh'
        stgs.desiredShape.fun = @(x,y) (2*x.^2)+(2*y.^2);
end
