meshDesign.shape = 'triangle';
meshDesign.n = 1;
meshDesign.m = 1;
meshDesign.baseIndex = 1;
meshDesign.fixedLinksIndexes = [meshDesign.baseIndex];
meshDesign.tform_0_bBase = getTformGivenPosRotm(zeros(3,1),createRotationMatrix(@rz,0));
meshDesign.linkDimension = 0.2;

stgs.strMesh = [meshDesign.shape,sprintf('_%ix%i',meshDesign.n,meshDesign.m)];

%%

cellCreator = CellMBodyCreation();

cellCreator.createMeshTriangleNode(...
    'n',meshDesign.n,...
    'm',meshDesign.m,...
    'linkDimension',meshDesign.linkDimension);

cellCreator.assignLinkProperty('name','tform_0_b','value',zeros(4))   % [m]
cellCreator.assignLinkProperty('name','tform_0_b','value',meshDesign.tform_0_bBase,'indexes',meshDesign.baseIndex) % [m]

%-------------------------------------------------------------------------%
% Link 1
%
% Visual
cellCreator.assignLinkProperty('indexes',1,'name','stlScale'    ,'value',meshDesign.linkDimension)
cellCreator.assignLinkProperty('indexes',1,'name','stlName'     ,'value','nodeSimplifiedTriangle.stl')
cellCreator.assignLinkProperty('indexes',1,'name','stlFaceColor','value',[0.5,0.7,0.9])
cellCreator.assignLinkProperty('indexes',1,'name','stlEdgeColor','value','k')
% Geometry
cellCreator.assignLinkProperty('indexes',1,'name','mass'           ,'value',2.23)       % [kg]
cellCreator.assignLinkProperty('indexes',1,'name','inertiaTens_g_g','value',[8.0063196e+03,-1.5334697e+02,-4.9061582e+00;-1.5334697e+02,1.8055578e+03,-1.6891085e+02;-4.9061582e+00,-1.6891085e+02,7.9952881e+03]/1e6)     % [kg*m^2]
cellCreator.assignLinkProperty('indexes',1,'name','tform_b_g'      ,'value',eye(4))     % [m]
cellCreator.assignLinkProperty('indexes',1,'name','baseLink'       ,'value',1)
cellCreator.assignLinkProperty('indexes',1,'name','fixed'          ,'value',1)

%-------------------------------------------------------------------------%
% Link 2
%
% Visual
cellCreator.assignLinkProperty('indexes',2,'name','stlScale'    ,'value',meshDesign.linkDimension)
cellCreator.assignLinkProperty('indexes',2,'name','stlName'     ,'value','nodeSimplifiedTriangle.stl')
cellCreator.assignLinkProperty('indexes',2,'name','stlFaceColor','value',[0.45,0.67,0])
cellCreator.assignLinkProperty('indexes',2,'name','stlEdgeColor','value','k')
% Geometry
cellCreator.assignLinkProperty('indexes',2,'name','mass'           ,'value',1.88)       % [kg]
cellCreator.assignLinkProperty('indexes',2,'name','inertiaTens_g_g','value',[5.4190152e+03,-3.0646328e+02,8.6480289e+01;-3.0646328e+02,1.9468778e+03,-2.9818500e+02;8.6480289e+01,-2.9818500e+02,5.8450336e+03]/1e6)     % [kg*m^2]
cellCreator.assignLinkProperty('indexes',2,'name','tform_b_g'      ,'value',eye(4))     % [m]
cellCreator.assignLinkProperty('indexes',2,'name','baseLink'       ,'value',0)
cellCreator.assignLinkProperty('indexes',2,'name','fixed'          ,'value',0)


%-------------------------------------------------------------------------%
% Joint
%

cellCreator.assignJointProperty('name','limitRoM'        ,'value',50*pi/180)  % [rad]
cellCreator.assignJointProperty('name','limitJointVel'   ,'value',20*pi/180)  % [rad/s]
cellCreator.assignJointProperty('name','limitJointTorque','value',7)          % [Nm]
cellCreator.assignJointProperty('name','jointType'       ,'value','revolute') % [char]
cellCreator.assignJointProperty('name','axesRotation'    ,'value',[0 0 1])    % (3,1)
cellCreator.assignJointProperty('name','axesActuated'    ,'value',[0 0 1])    % (3,1)

cellCreator.assignJointProperty('name','coeffViscousFriction'  ,'value',0.5)
cellCreator.assignJointProperty('name','coeffCoulombFriction'  ,'value',0)
cellCreator.assignJointProperty('name','coeffMotorTorque'      ,'value',0)
cellCreator.assignJointProperty('name','inertiaTensMotor'      ,'value',0)
cellCreator.assignJointProperty('name','transmissionGearRatio' ,'value',1)
cellCreator.assignJointProperty('name','transmissionEfficiency','value',1)

clear meshDesign
