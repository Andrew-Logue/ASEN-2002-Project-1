%Andrew Logue 2/26/20
%csv file reader for tensile test lab
clear
clc
close all

%read in the data using the function importfile()
BrittleData = importfile("C:\Users\aelog\Documents\MATLAB\ASEN\Tensile Lab\ASEN1022_Feb21_Brittle_Data.csv", [9, Inf]);
%Read the data that you stored from the .cpp file into a Matrix
MPre1 = BrittleData{:,:};
[r, c] = size(MPre1);
gaugeLength = 0.0254;

MPost1 = zeros((r - 1) ,2);
%Calculate stress
for i = 1 : (r - 1)
    stress = 0.0;
    stress = MPre1(i, 2) * 4.4482216;
    stress = stress / 80.645;
    MPost1(i, 2) = stress;
end

%Calculate strain
for k = 1 : (r - 1)
    strain = 0.0;
    strain = MPre1(k, 4);
    MPost1(k, 1) = strain;
end

DuctileData = importfile("C:\Users\aelog\Documents\MATLAB\ASEN\Tensile Lab\ASEN1022_Jan28_Ductile_Data.csv", [9, Inf]);
MPre2 = DuctileData{:,:};
[r, c] = size(MPre2);
MPost2 = zeros((r - 1) ,2);

%Calculate stress
for i = 1 : (r - 1)
    stress = 0.0;
    stress = MPre2(i, 2) * 4.4482216;
    stress = stress / 80.645;
    MPost2(i, 2) = stress;
end

%Calculate strain
for k = 1 : (r - 1)
    strain = 0.0;
    strain = MPre2(k, 4);
    MPost2(k, 1) = strain;
end

%yeild strength
YS1 = .002 * 6444.08;
YS2 = .002 * 40824.58;

%tensile strength
TS = max(MPost2(:, 2));

%color
c = linspace(0,.005,length(MPost1(:, 1)));
%Plot brittle data
figure
hold on
scatter(MPost1(:, 1), MPost1(:, 2), 5, c)
plot(.0019725, 106.0229, 'r*')
plot((0:.0019725:.00789), (0:106.0229:424.916), 'r')
plot(.0049162, 140.5443, 'b*')
grid
%line of best fit
%polyfit(MPost1(:, 1), MPost1(:, 2), 3);
%set axis limits
xlim([-0.00001, .005])
ylim([0,200])
%label graph
xlabel('Strain')
ylabel('Stress (MPa)')
title('Stress vs. Strain (Brittle Data)')
legend('Stress strain curve', 'Yield strength', 'Youngs modulus', 'Fracture stress')
hold off

%color
c = linspace(0,.005,length(MPost2(:, 1)));
%Plot ductile data
figure
hold on
scatter(MPost2(:, 1), MPost2(:, 2), 5, c)
plot(.0034759,  180.2611, 'r*')
plot((0:.0034759:.0278072), (0:180.2611:1442.0888), 'r')
plot(.1035, 187.4292, 'b*')
plot(0.0790718715549923, TS, 'm*')
grid
%line of best fit
%polyfit(MPost2(:, 1), MPost2(:, 2), 2);
%set axis limits
xlim([-.00001, .105])
ylim([0, 250])
%label graph
xlabel('Strain')
ylabel('Stress (MPa)')
title('Stress vs. Strain (Ductile Data)')
legend('Stress strain curve', 'Yield strength', 'Youngs modulus', 'Tensile strength', 'Fracture stress')
hold off