meshDesign.shape = 'triangle';
meshDesign.n = 3;
meshDesign.m = 5;
meshDesign.baseIndex = 1;
meshDesign.fixedLinksIndexes = [meshDesign.baseIndex];
meshDesign.tform_0_bBase = getTformGivenPosRotm(zeros(3,1),createRotationMatrix(@rz,pi/3));
meshDesign.linkDimension = 0.0425;

stgs.strMesh = [meshDesign.shape,sprintf('_%ix%i',meshDesign.n,meshDesign.m)];

%%

cellCreator = CellMBodyCreation();

cellCreator.createMeshTriangleNodePatternRectangle(...
    'n',meshDesign.n,...
    'm',meshDesign.m,...
    'linkDimension',meshDesign.linkDimension,...
    'cylinder',true);

% Visual
cellCreator.assignLinkProperty('name','stlScale'    ,'value',meshDesign.linkDimension)
cellCreator.assignLinkProperty('name','stlName'     ,'value','nodeSimplifiedTriangle.stl')
cellCreator.assignLinkProperty('name','stlFaceColor','value',[0.5,0.7,0.9],'indexes',1:2:length(cellCreator.cellLinks))
cellCreator.assignLinkProperty('name','stlFaceColor','value',[0.5,0.7,0.3],'indexes',2:2:length(cellCreator.cellLinks))
cellCreator.assignLinkProperty('name','stlEdgeColor','value','k')

% Geometry
cellCreator.assignLinkProperty('name','mass'           ,'value',0.01)       % [kg]
cellCreator.assignLinkProperty('name','inertiaTens_g_g','value',eye(3))     % [kg*m^2]
cellCreator.assignLinkProperty('name','tform_b_g'      ,'value',eye(4))     % [m]

cellCreator.assignLinkProperty('name','tform_0_b'      ,'value',zeros(4))   % [m]
cellCreator.assignLinkProperty('name','tform_0_b'      ,'value',meshDesign.tform_0_bBase,'indexes',meshDesign.baseIndex) % [m]

cellCreator.assignLinkLogicalProperty('name','baseLink','value',1,'indexes',meshDesign.baseIndex)
cellCreator.assignLinkLogicalProperty('name','fixed'   ,'value',1,'indexes',meshDesign.fixedLinksIndexes)

% Joint 
cellCreator.assignJointProperty('name','limitRoM'        ,'value',50*pi/180)  % [rad]
cellCreator.assignJointProperty('name','limitJointVel'   ,'value',20*pi/180)  % [rad/s]
cellCreator.assignJointProperty('name','limitJointTorque','value',7)          % [Nm]
cellCreator.assignJointProperty('name','jointType'       ,'value','revolute') % [char]
cellCreator.assignJointProperty('name','axesRotation'    ,'value',[0 0 1])    % (3,1)
cellCreator.assignJointProperty('name','axesActuated'    ,'value',[0 0 0])    % (3,1)

cellCreator.assignJointProperty('name','coeffViscousFriction'  ,'value',0)
cellCreator.assignJointProperty('name','coeffCoulombFriction'  ,'value',1)
cellCreator.assignJointProperty('name','coeffMotorTorque'      ,'value',0)
cellCreator.assignJointProperty('name','inertiaTensMotor'      ,'value',0)
cellCreator.assignJointProperty('name','transmissionGearRatio' ,'value',0)
cellCreator.assignJointProperty('name','transmissionEfficiency','value',0)

clear meshDesign
