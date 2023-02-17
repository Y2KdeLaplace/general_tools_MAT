% reality monitoring && neurofeedback
% written by Yiheng Hu(2023.2.7)
% remember to 'clear all'!
% remember to change parameters of width, height and marker
function demo(subName, CurRun, marker)
% addpath('fun_tools/')
rng('shuffle','twister')
try
    %% debug
    close all
    clear
    sca
    if nargin == 0
        subName = 'test';
        CurRun = 1;
        marker = 0;
        nf = false;
    end
    nf = true;
    
    %% set up EEG marker
    if marker==1
        ioObj = io64;
        status = io64(ioObj);
        if status == 0
            disp('inpoutx64.dll successfully installed.')
        else
            error('inpoutx64.dll installation failed.')
        end
        address = hex2dec('3FF8');
        io64(ioObj,address,0);
    end
    
    %% parameters
    filename=[subName '_NFRM_EEG_behavior_' num2str(CurRun)];
    white=[1 1 1];
    black=[0 0 0];
    gray=(white+black)./2;
    
    data.trialnumber          = 42;% 42 trials/run
    data.time.paddingtime     = 2;
    
    %loading images
    stimuli.size         = 350;
    images_info = dir('image_lib\*.bmp');
    images = zeros(stimuli.size, stimuli.size, 3, length(images_info));
    ftmp = [];
    stmp = [];
    for i = 1:length(images_info)
        [X,~]=imread(['image_lib\' images_info(i).name]);
%         X=imresize(X, 0.45);
        images(:,:,:,i)=X;
        if any(ismember(images_info(i).name,'f'))
            ftmp = [ftmp,i];
        elseif any(ismember(images_info(i).name,'s'))
            stmp = [stmp,i];
        end
%         [X,cmap]=imread([num2str(i) '.bmp']);%Index image X is uint8 array. Color image cmap is double matrix
%         RGB=imresize(RGB, 0.75);% or RGB = imresize(RGB, [64 NaN]);%scaled image
%         image(:,:,:,i)=ind2rgb(X,cmap);%tranform index image into RGB image resulting double array
    end
    stimuli.face = images(:,:,:,ftmp);
    stimuli.scene = images(:,:,:,stmp);
    clear X ftmp stmp
    
    %% beginning setting
    AssertOpenGL;
%     Screen('Preference','VisualDebugLevel', 0);%disable all visual alerts
%     Screen('Preference','SuppressAllWarnings', 1);%disable all output to the command window
    PsychDefaultSetup(2);                                                  % call some default settings for setting up Psychtoolbox
    screenid = max(Screen('Screens'));                                     % Get the screen numbers and select the maximum of these numbers.
    white = WhiteIndex(screenid);                                          % Define black and white (white will be 1 and black 0)
    black = BlackIndex(screenid);
    gray = white / 2;
    
    [win, rect] = PsychImaging('OpenWindow', screenid, gray);              % Open an on screen window using PsychImaging and color it grey.
    ifi = Screen('GetFlipInterval', win);                                  % Measure the vertical refresh rate of the monitor
    Screen('BlendFunction', win, 'GL_SRC_ALPHA',...
        'GL_ONE_MINUS_SRC_ALPHA');                                         % Set the blend funciton for the screen
    Priority(MaxPriority(win));                                            % Set maximum priority level
    Screen('Flip', win);                                                   % Initial flip
    [xc, yc] = RectCenter(rect);                                           % Get the centre coordinate of the window
    waitframes = 1;                                                        % Numer of frames to wait before re-drawing
    devicenumber = -1;
    HideCursor;
    
    
    %% key buttons
    KbName('UnifyKeyNames');
    two_button=KbName('2@');
    three_button=KbName('3#');
    space_button=KbName('space');
    
    %% Instruction
    instruction1=double('实验中请把视线集中在屏幕中间的白点');
    instruction2=double('\n y');
    instruction3=double('\n x');
    Screen('TextSize', win, 24);
    Screen('TextFont', win, 'Simsun');
    DrawFormattedText(win,[instruction1 instruction2 instruction3],'center','center',black);
    Screen('DrawDots', win, [xc yc],10,white,[],2);
    vbl=Screen('Flip', win);
    
    %key buttons | Press any key to proceed
%     KbName('UnifyKeyNames');
%     keyIsDown=0;
%     while ~keyIsDown
%         [keyIsDown, ~, ~] = KbCheck(devicenumber);
%     end
    KbWait;
    
    t0=GetSecs;
    while (GetSecs-t0)<data.time.paddingtime
        Screen('DrawDots', win, [xc yc],10,black, [], 2);
        vbl = Screen('Flip', win, vbl + (waitframes - 0.5) * ifi);
    end
    
    
    
    
    
    
    for i=1:data.trialnumber
        
    end
    

    
    WaitSecs(2);
    
    Priority(0);
    Screen('CloseAll');
    IOPort('CloseAll');
    sca;
    ShowCursor;
    
catch
    %this "catch" section executes in case of an error in the "try" section
    %above.  Importantly, it closes the onscreen window if its open.
    Screen('CloseAll');
    ShowCursor;
    Priority(0); %Usage: oldPriority=Priority([newPriority])
    psychrethrow(psychlasterror); %same as 'rethrow': reissure error; rethrow(err),usually used in 'try-catch' statement
    
end %try..catch..

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% tmp function
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function seq = balanced_seqmaker(nlines, ntrials)
seq = repmat(randperm(nlines),1,ntrials/nlines);
seq = seq(randperm(ntrials))';



% Priority(topPriorityLevel);
% vbl = Screen('Flip', window);
% for frame = 1:numFrames
% 
%     % Color the screen blue
%     Screen('FillRect', window, [0 0 0.5]);
% 
%     % Tell PTB no more drawing commands will be issued until the next flip
%     Screen('DrawingFinished', window);
% 
%     % One would do some additional stuff here to make the use of
%     % "DrawingFinished" meaningful / useful
% 
%     % Flip to the screen
%     vbl = Screen('Flip', window, vbl + (waitframes - 0.5) * ifi);
% 
% end
% Priority(0);
