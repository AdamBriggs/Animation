clear
clc
%% Adam Briggs
% OPT 212
% Lab Complex Wave Propagation, User Prompts, Animations in Matlab
diary('inter5.txt')
diary on
%% Constants Definition
global amplitude wavelength phase n time xplane yplane xsph ysph T c XPL YPL XSPH YSPH PS NumWave;
c = 3e8;
T = 250; %Number of points in arrays (x,y,t)

%% Constants
% Creates array of points to be used as the x and y variables in the
% plotting space
xplane = linspace(0,2*pi,T);
yplane = linspace(0,2*pi,T);

xsph = linspace(-2*pi,2*pi,T);
ysph = linspace(-2*pi,2*pi,T);

[XPL,YPL] = meshgrid(xplane,yplane);
[XSPH, YSPH] = meshgrid(xsph,ysph);

%% Prompting Section
promptPS = 'Is this wave planar or spherical [P/S]: ';
PS = input(promptPS,'s');

promptAmp = 'Enter the amplitude of the wave: ';
amplitude = input(promptAmp);

promptWav = 'Enter the wavelength of the wave (um): ';
wavelength = input(promptWav);

promptPhase = 'Enter the phase of the wave: ';
phase = input(promptPhase);

promptN = 'Enter the index of refraction of the material: ';
n = input(promptN);

promptTime = 'Enter the time for wave propagation (s): ';
t = input(promptTime);
time = linspace(0,t,T);

if strcmpi(PS,'P')
     promptNumWave = 'How many waves [1/2]: ';
     NumWave = input(promptNumWave);
     
     if NumWave == 1
         Planar1(); %Needs more information. Calls planar1 function
     elseif NumWave == 2
         Planar2(); %Needs more information. Calls planar2 function
     end
     
elseif strcmpi(PS,'S')
    Spherical(); %All values taken care of. Call spherical calculation function
end

%% One Plane Wave
function Planar1()
    % Finish Defining Variables
    global amplitude wavelength phase ang n zp1 c XPL YPL;
	promptWaveAng = 'Enter the wave angle for the wave: ';
    ang = input(promptWaveAng);
    
    if ang < -90 || ang > 90
        disp('Angle out of domain.');
        Planar1();
    end
   
    % Function Definition
    zp1 = @(time) amplitude.*exp(1i.*((2.*pi.*n)./(wavelength).*(XPL.*cosd(ang)...
        +YPL.*sind(ang))-(2.*pi.*c)./(wavelength).*time+phase));
    
    Plotting();
end
%% 2 Plane Waves
function Planar2()
    % Finish Defining Variables
	global amplitude wavelength phase ang n amplitude2 wavelength2 phase2 ang2 zp2 c XPL YPL;
	promptWaveAng = 'Enter the wave angle for the first wave: ';
    ang = input(promptWaveAng);    
    
    promptAmp2 = 'Enter the amplitude of the second wave: ';
    amplitude2 = input(promptAmp2);

    promptWav2 = 'Enter the wavelength of the second wave (um): ';
    wavelength2 = input(promptWav2);
    
   	promptWaveAng2 = 'Enter the wave angle for the second wave: ';
    ang2 = input(promptWaveAng2);
    
   promptPhase2 = 'Enter the phase of the second wave: ';
    phase2 = input(promptPhase2);
    
    % Function Definition
    zp2 = @(time) amplitude.*exp(1i.*((2.*pi.*n)./(wavelength).*(XPL.*cosd(ang)...
        +YPL.*sind(ang))-(2.*pi.*c)./(wavelength).*time+phase)) + ...
        amplitude2.*exp(1i.*((2.*pi.*n)./(wavelength2).*(XPL.*cosd(ang2)+...
        YPL.*sind(ang2))-(2.*pi.*c)./(wavelength2).*time+phase2));
    
    Plotting();
end

%% Spherical Wave
function Spherical()
    %%Finish Defining Variables
    global amplitude wavelength phase n XSPH YSPH zsph c;
    zsph = @(time) amplitude.*exp(1i.*((2.*pi.*n)./(wavelength).*...
        sqrt(XSPH.^2+YSPH.^2)-(2.*pi.*c)./(wavelength).* time +phase));
    
    Plotting();
end

%% Make Movie
function Plotting()
    global zp1 zp2 zsph F XPL YPL XSPH YSPH PS time T NumWave;
    clear F
    F(T) = struct('cdata',[],'colormap',[]);
    for ijk = 1:T
       if strcmpi(PS,'p')
           %Planar
            if NumWave == 1
                surf(XPL,YPL,real(zp1(time(ijk))));
                xlim([0 2*pi]);
                ylim([0 2*pi]);
                c = colorbar;
                c.Label.String = 'Amplitude of Wave';
                title('Animation of Single Planar Wave');
                xlabel('Arb. Units');
                ylabel('Arb. Units');
                set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
                set(gcf, 'position', [100, 100, 800, 500]); %Change size of window
                view(2)
            F(ijk) = getframe(gcf);
            elseif NumWave == 2
                surf(XPL,YPL,real(zp2(time(ijk))));
                xlim([0 2*pi]);
                ylim([0 2*pi]);                
                c = colorbar;
                c.Label.String = 'Amplitude of Wave';
                title('Animation of Two Planar Waves');
                xlabel('Arb. Units');
                ylabel('Arb. Units');
                set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
                set(gcf, 'position', [100, 100, 800, 500]); %Change size of window
                view(2)
                F(ijk) = getframe(gcf);    
            end           
       elseif strcmpi(PS,'s')
           surf(XSPH,YSPH,real(zsph(time(ijk))));
           xlim([-2*pi 2*pi]);
           ylim([-2*pi 2*pi]);
           c = colorbar;
           c.Label.String = 'Amplitude of Wave';
           title('Animation of Spherical Wave');
           xlabel('Arb. Units');
           ylabel('Arb. Units');
           set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
           set(gcf, 'position', [100, 100, 800, 500]); %Change size of window
           view(2)
           F(ijk) = getframe(gcf);
       end
    end
    movie(F);   %Plot the movie
    diary off
end






