% Lorentz Oscillator model for GaAs
% Written by: Gregory R. Savich, PhD
% Date written/edited: 3/22/2017
% Originally conceived for: OPT211 Midterm 2017.  
% Repurposed for OPT212 Lab 6: 11/27//2018



% Constants
eo=8.85419e-12; %Permittivity of free-space
cc=5e13; % Scaling constant
wto=1*cc; % TO phonon frequency
omega=1.449*cc; % constant
gamma=0.01*cc; % constant
einf=10.9*eo; % dielectric constant at infinity
c=3e8; % speed of light in m/s

lambda=linspace(0,60e-6,1000); % wavelength (in meters, but would be more ideal in microns)--independent variable
nu=c./lambda; % regular frequency
w=2*pi*nu; % angular frequency

% Dielectric Constant according to model
eps = einf + omega.^2./(wto.^2-w.^2-1i.*gamma.*w); % complete dielectric constant

eps1 = real(eps);   %REAL Component of eps
eps2 = imag(eps);     %IMAGINARY Component of eps

n1 = sqrt(.5.*(eps1+(eps1.^2+eps2.^2).^.5));    %Real Part of the refractive index

n2 = sqrt(.5.*(eps1-(eps1.^2+eps2.^2).^.5));    %Imaginary Part of the refractive index

alpha = (4.*pi.*n2)./lambda;    %Absorption Coefficient

R = ((n1-1).^2 + n2.^2)./((n1+1).^2 + n2.^2);   %Reflectivity

%% Plotting Section
figure(1)
hold on
plot(lambda,eps1,'linewidth',2);
plot(lambda, eps2,'linewidth',2);
hold off
title('Dielectric Constant v. Wavelength');
xlabel('Wavelength (m)');
ylabel('Dielectric Constant (a.u.)');
legend('Real Dielectric Constant','Imaginary Dielectric Constant','location','best');
set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
set(gcf, 'position', [100, 100, 800, 500]); %Change size of window
xlim([0 60e-6]);

figure(2)
hold on
plot(lambda,real(n1),'linewidth',2);
plot(lambda, imag(n2),'linewidth',2);
hold off
title('Index of Refraction v. Wavelength');
xlabel('Wavelength (m)');
ylabel('Index of Refraction (a.u.)');
legend('Real Index of Refraction','Imaginary Index of Refraction','location','best');
set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
set(gcf, 'position', [100, 100, 800, 500]); %Change size of window
xlim([0 60e-6]);

figure(3)
subplot(3,1,1)
    plot(lambda,imag(alpha),'linewidth',2);
    title('Absorption Coefficient v. Wavelength');
    xlabel('Wavelength (m)');
    ylabel('Absorption Coefficient (a.u.)');
    legend('Absorption Coefficient','location','best');
    set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
    set(gcf, 'position', [100, 100, 800, 500]); %Change size of window
    xlim([0 60e-6]);

subplot(3,1,2)
    plot(lambda,R,'linewidth',2);
    title('Reflectivity v. Wavelength');
    xlabel('Wavelength (m)');
    ylabel('Reflectivity (a.u.)');
    legend('Reflectivity','location','best');
    set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
    set(gcf, 'position', [100, 100, 800, 500]); %Change size of window
    xlim([0 60e-6]);
    
subplot(3,1,3)
    hold on
    plot(lambda,imag(alpha/1000000),'linewidth',2);
    plot(lambda,R,'linewidth',2);
    hold off
    title('Absorption and Reflectivity vs. Wavelength');
    xlabel('Wavelength (m)');
    ylabel('Absorption and Reflectivity (a.u.)');
    legend('Absorption','Reflectivity','location','best');
    set(findall(gcf,'-property','FontSize'),'FontSize',18); %Changes font size
    set(gcf, 'position', [100, 100, 800, 900]); %Change size of window
    xlim([0 60e-6]);
    
%% Output 
a=length(findobj('type','figure'));
for i=1:a
    figure(i)
    export_fig(sprintf('GaAs-%d.jpg',i), '-m3');
end