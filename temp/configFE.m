meshDesign.shape = 'square';
meshDesign.baseIndex = 61;
meshDesign.fixedLinksIndexes = [meshDesign.baseIndex 69];
meshDesign.tform_0_bBase = getTformGivenPosRotm(zeros(3,1),createRotationMatrix(@rz,0));

switch meshDesign.shape
    case 'triangle'
        meshDesign.visual.stlName = 'nodeSimplifiedTriangle.stl';
    case 'square'
        meshDesign.visual.stlName = 'nodeSimplifiedSquare.stl';
end

load('../../models/rc_iit_017_p_026/data.mat')
stgs.strMesh = [meshDesign.shape,'_FE'];

%%

cellCreator = CellMBodyCreation();

cellCreator.createMeshDataFE(...
    'links',links,...
    'vertices',vertices,...
    'baseIndex',meshDesign.baseIndex,...
    'tform_0_bBase',meshDesign.tform_0_bBase,...
    'fixedLinksIndexes',meshDesign.fixedLinksIndexes,...
    'stlScaleHeight',10,...
    'stlName',meshDesign.visual.stlName,...
    'stlFaceColorO',[0.5,0.7,0.9],...
    'stlFaceColorE',[0.5,0.7,0.9],...
    'stlEdgeColor','k');

% Geometry
cellCreator.assignLinkProperty('name','mass'           ,'value',0.01)       %[kg]
cellCreator.assignLinkProperty('name','inertiaTens_g_g','value',eye(3))     %[kg*m^2]
cellCreator.assignLinkProperty('name','tform_b_g'      ,'value',eye(4))     

% Joint 
cellCreator.assignJointProperty('name','limitRoM'        ,'value',50*pi/180)   % [rad]
cellCreator.assignJointProperty('name','limitJointVel'   ,'value',20*pi/180)   % [rad/s]
cellCreator.assignJointProperty('name','limitJointTorque','value',7)           % [Nm]
cellCreator.assignJointProperty('name','jointType'       ,'value','spherical') % [char]
cellCreator.assignJointProperty('name','axesRotation'    ,'value',[1 1 1])     % (3,1)
cellCreator.assignJointProperty('name','axesActuated'    ,'value',[0 0 0])     % (3,1)

cellCreator.assignJointProperty('name','coeffViscousFriction'  ,'value',0)
cellCreator.assignJointProperty('name','coeffCoulombFriction'  ,'value',1)
cellCreator.assignJointProperty('name','coeffMotorTorque'      ,'value',0)
cellCreator.assignJointProperty('name','inertiaTensMotor'      ,'value',0)
cellCreator.assignJointProperty('name','transmissionGearRatio' ,'value',0)
cellCreator.assignJointProperty('name','transmissionEfficiency','value',0)

clear links vertices meshDesign
