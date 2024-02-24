%% Prelude

% This matlab code creates flickering gabor patches. The parameters can be 
% edited according to your requirements. It requires Psychtoolbox installed
% already. The Gabor patch is being created using CreateProceduralGabor 
% function from the Psychtoolbox. The flickering effect can be made by 
% modulating the contrast. Flickering gabor patches can be used to understand 
% frequency following phenomenon in different brain regions.

% You can change the parameters here---------------------------------------

res           = 3*[323 323]; %Resolution
phase         = 0;
sc            = 50.0;
sfreq         = 0.1; %Spatial frequency
tilt          = 0;
aspectratio   = 1.0;
nonsymmetric  = 0;

% Parameters to make flicker-----------------------------------------------

frequency     = 5;   % flicker frequency in Hz
duration      = 1;   % duration of the flicker in seconds
fps           = 60;
time          = 0:1/fps:duration;
sig           = sin(2 * pi * (frequency/2) * time);

contrastModulation = abs(100 * sin(2 * pi * (frequency/2) * time)); 
% See Read me for more information about this line

tw = res(1);
th = res(2);

% Open a Psychtoolbox window-----------------------------------------------
PsychDefaultSetup(2);
rect = [0 0 1366 768];
Screen('Preference', 'SkipSyncTests', 0 );
screenNumber = max(Screen('Screens'));
PsychImaging('PrepareConfiguration');
window = PsychImaging('OpenWindow', screenNumber, 0.5, rect);  


% Making the flickering----------------------------------------------------
for i = 1 : length(time)

        gabortex = CreateProceduralGabor(window, tw, th, nonsymmetric, ...
            [0.5 0.5 0.5 0.0],0,[-1 1]);
        Screen('DrawTexture', window, gabortex, [], [], tilt, ...
            [], [], [], [], kPsychDontDoRotation, ...
            [phase, sfreq, sc, contrastModulation(i), aspectratio, 0, 0, 0]);
        Screen('Flip', window);

end

sca; % Closing the screen