meshDesign.shape = 'square';
meshDesign.initialConfiguration = 'flat';
meshDesign.n = 8;
meshDesign.m = 8;
meshDesign.baseIndex = 1;
meshDesign.fixedLinksIndexes = [meshDesign.baseIndex];
meshDesign.tform_0_bBase = getTformGivenPosRotm(zeros(3,1),createRotationMatrix(@rz,0));
meshDesign.linkDimension = 0.0482;

switch meshDesign.initialConfiguration
    case 'flat'
        meshDesign.rzi_pj0_cj0 = 0;
        meshDesign.rzj_pj0_cj0 = 0;
    case 'cylinder'
        meshDesign.rzi_pj0_cj0 = 2*pi/meshDesign.n;
        meshDesign.rzj_pj0_cj0 = 0;
end

stgs.strMesh = [meshDesign.shape,sprintf('_%ix%i',meshDesign.n,meshDesign.m)];

%%

cellCreator = CellMBodyCreation();

cellCreator.createMeshSquareNode(...
    'n',meshDesign.n,...
    'm',meshDesign.m,...
    'linkDimension',meshDesign.linkDimension,...
    'rzi_pj0_cj0',meshDesign.rzi_pj0_cj0,...
    'rzj_pj0_cj0',meshDesign.rzj_pj0_cj0);

% Visual
cellCreator.assignLinkProperty('name','stlScale'    ,'value',meshDesign.linkDimension*[1 1 1])
cellCreator.assignLinkProperty('name','stlName'     ,'value','nodeSquare.stl')
cellCreator.assignLinkProperty('name','stlFaceColor','value',[0.50,0.70,0.90],'indexes',find(mod(reshape(1:meshDesign.n*meshDesign.m,[],meshDesign.n)' - (1:meshDesign.n)',2)'==0))
cellCreator.assignLinkProperty('name','stlFaceColor','value',[0.45,0.75,0.85],'indexes',find(mod(reshape(1:meshDesign.n*meshDesign.m,[],meshDesign.n)' - (1:meshDesign.n)',2)'==1))
cellCreator.assignLinkProperty('name','stlFaceColor','value',[0.00,0.40,0.40],'indexes',meshDesign.fixedLinksIndexes)
cellCreator.assignLinkProperty('name','stlEdgeColor','value','none')

% Geometry
cellCreator.assignLinkProperty('name','mass'           ,'value',0.01)       % [kg]
cellCreator.assignLinkProperty('name','inertiaTens_g_g','value',eye(3)/1e6)     % [kg*m^2]
cellCreator.assignLinkProperty('name','tform_b_g'      ,'value',eye(4))     % [m]

cellCreator.assignLinkProperty('name','tform_0_b'      ,'value',zeros(4))   % [m]
cellCreator.assignLinkProperty('name','tform_0_b'      ,'value',meshDesign.tform_0_bBase,'indexes',meshDesign.baseIndex) % [m]

cellCreator.assignLinkLogicalProperty('name','baseLink','value',1,'indexes',meshDesign.baseIndex)
cellCreator.assignLinkLogicalProperty('name','fixed'   ,'value',1,'indexes',meshDesign.fixedLinksIndexes)

% Joint 
cellCreator.assignJointProperty('name','limitRoM'        ,'value',50*pi/180)   % [rad]
cellCreator.assignJointProperty('name','limitJointVel'   ,'value',20*pi/180)   % [rad/s]
cellCreator.assignJointProperty('name','limitJointTorque','value',7)           % [Nm]
cellCreator.assignJointProperty('name','jointType'       ,'value','spherical') % [char]
cellCreator.assignJointProperty('name','axesRotation'    ,'value',[1 1 1])     % (3,1)
cellCreator.assignJointProperty('name','axesActuated'    ,'value',[0 0 0])     % (3,1)

cellCreator.assignJointProperty('name','coeffViscousFriction'  ,'value',0) %[]
cellCreator.assignJointProperty('name','coeffCoulombFriction'  ,'value',0) %[]
cellCreator.assignJointProperty('name','coeffMotorTorque'      ,'value',1.2) %[]
cellCreator.assignJointProperty('name','inertiaTensMotor'      ,'value',0.05) %[]
cellCreator.assignJointProperty('name','transmissionGearRatio' ,'value',12) %[]
cellCreator.assignJointProperty('name','transmissionEfficiency','value',0.9) %[]

clear meshDesign
