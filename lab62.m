function varargout = lab62(varargin)
% LAB62 MATLAB code for lab62.fig
%      LAB62, by itself, creates a new LAB62 or raises the existing
%      singleton*.
%
%      H = LAB62 returns the handle to a new LAB62 or the handle to
%      the existing singleton*.
%
%      LAB62('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LAB62.M with the given input arguments.
%
%      LAB62('Property','Value',...) creates a new LAB62 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before lab62_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to lab62_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help lab62

% Last Modified by GUIDE v2.5 06-Oct-2019 17:28:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @lab62_OpeningFcn, ...
                   'gui_OutputFcn',  @lab62_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before lab62 is made visible.
function lab62_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to lab62 (see VARARGIN)

% Choose default command line output for lab62
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes lab62 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = lab62_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
clear all;
close all;
S=load('R6_08.txt');
N=length(S);
Fs=500;
T=1/Fs;
tmax=N/Fs;
t=0:T:tmax-T;
ECG=S(1:N,1);
Puls_R=S(1:N,2);
Puls_IR=S(1:N,3);
subplot(4,1,1)

plot(t,ECG);
subplot(4,1,4);

plot(t,Puls_R);
hold on
C=500;
plot(t,Puls_IR-C);
for n=3:N
    Y(n)=ECG(n)-ECG(n-2);
end
%axes(axes3)
axes(handles.axes3);
plot(t,Y);
for i=1:N
    Y1(i)=abs(Y(i));
end
%axes(axes5);
axes(handles.axes5);
plot(t,Y1);
Limit=25;
XLimit(1)=0;
XLimit(2)=tmax-T;
YLimit(1:2)=Limit;
L=line(XLimit,YLimit);
set(L,'LineStyle','--');
Jmax=100;
k=0;
j=Jmax;
for i=1:N
    j=j+1;
    if (Y(i)>Limit)&&(j>Jmax)
        k=k+1;
        QRS(k)=i;
        j=0;
    end
end
axes(handles.axes5);
YLimits=get(hAxes4,'YLim');
for i=1:k
    XLimits(1:2)=QRS(i)*T;
    HLine=line(XLimits,YLimits);
    set(HLine,'LineStyle','--');
end
D1=0;
for i=1:(k-1)
    clear m1
    m1=Puls_R(QRS(i):QRS(i+1));
    D1=D1+(max(m1)-min(m1));
end
D1=D1/(k-1);
D2=0;
for i=1:(k-1)
    clear m2
    m2=Puls_RI(QRS(i):QRS(i+1));
    D2=D2+(max(m2)-min(m2));
end
D2=D2/(k-1);
a=(D2/D1);
SaO2=((0.872-0.16*a)/(0.14*a+0.754))*100;
hTxt1=uicontrol(hFig,'Style','text','String','SaO2=','Position',[20,20,2,5],'Backgroundcolor',[1 1 1]);
    hEd=uicontrol(hFig,'Style','edit','Position',[20,30,2,10],'Backgroundcolor',[1 1 1],'HorizontalAlignment','left');
    set(hEd,'String',num2str(SaO2));