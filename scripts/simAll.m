
tic;f1_00;t = toc; fileID = fopen(sprintf('f1_00 - t=%.f',t),'w'); fclose(fileID); pause(60);
tic;f1_01;t = toc; fileID = fopen(sprintf('f1_01 - t=%.f',t),'w'); fclose(fileID); pause(60);
tic;f1_10;t = toc; fileID = fopen(sprintf('f1_10 - t=%.f',t),'w'); fclose(fileID); pause(60);
tic;f1_11;t = toc; fileID = fopen(sprintf('f1_11 - t=%.f',t),'w'); fclose(fileID);
tic;f2_00;t = toc; fileID = fopen(sprintf('f2_00 - t=%.f',t),'w'); fclose(fileID);
tic;f2_01;t = toc; fileID = fopen(sprintf('f2_01 - t=%.f',t),'w'); fclose(fileID);
tic;f2_10;t = toc; fileID = fopen(sprintf('f2_10 - t=%.f',t),'w'); fclose(fileID);
tic;f2_11;t = toc; fileID = fopen(sprintf('f2_11 - t=%.f',t),'w'); fclose(fileID);
tic;f4_0 ;t = toc; fileID = fopen(sprintf('f4_0  - t=%.f',t),'w'); fclose(fileID);
tic;f4_1 ;t = toc; fileID = fopen(sprintf('f4_1  - t=%.f',t),'w'); fclose(fileID);
tic;f3_1 ;t = toc; fileID = fopen(sprintf('f3_1  - t=%.f',t),'w'); fclose(fileID);
tic;f3_0 ;t = toc; fileID = fopen(sprintf('f3_0  - t=%.f',t),'w'); fclose(fileID);

function f1_00
    sim1_00
end
function f1_01
    sim1_01
end
function f1_10
    sim1_10
end
function f1_11
    sim1_11
end
function f2_00
    sim2_00
end
function f2_01
    sim2_01
end
function f2_10
    sim2_10
end
function f2_11
    sim2_11
end
function f4_0
    sim4_0
end
function f4_1
    sim4_1
end
function f3_1
    sim3_1
end
function f3_0
    sim3_0
end
