%Obtencion de Datos 
%clear all, close all, clc

s = serial('COM7', 'BaudRate', 115200);
fopen(s);

duration = 5;
step = 0.025;
samples = duration / step;

get_v = zeros(1, samples);


disp("In Air");
for i = 1:samples
    dataString = fscanf(s, '%s');
    get_v(i) = str2double(dataString);
end

disp("OFF Air");
fclose(s);
clear s;
% Cargamos el filtro
gy=filter(Hd,get_v);

% Parámetros de la señal
Fs = 1/step; % Frecuencia de muestreo (recíproco del paso de tiempo)
N = length(get_v); % Número de puntos en la señal

% Aplicar la FFT
fft_signal_int = fft(get_v);

fft_signal_out = fft(gy);

% Calcular las frecuencias correspondientes en unidades de pi/sample
frequencies_pi_sample = (0:(N/2))/N;

% Calcular la amplitud del espectro 
amplitude_spectrum_int = abs(fft_signal_int(1:N/2+1));
amplitude_spectrum_out = abs(fft_signal_out(1:N/2+1));
% Convertir a dB
amplitude_spectrum_db_int= 20*log10(amplitude_spectrum_int)-10;
amplitude_spectrum_db_out= 20*log10(amplitude_spectrum_out)-10;

%Ploteamos salida con el filtro 
figure(1);
subplot(1,3,1);
plot(get_v,'r--','Color',[1 0 0 0.5]);
hold on
plot(gy,'b');
grid on
hold off
title('Señal MAX4466');
xlabel('Tiempo');
ylabel('Amplitud');
legend('Native','FIR Low Pass');

% Graficar el espectro en dB
subplot(1,3,2);
plot(frequencies_pi_sample, amplitude_spectrum_db_int,'r--','Color',[1 0 0 0.5]);
hold on
plot(frequencies_pi_sample, amplitude_spectrum_db_out,'b');
hold off
title('Espectro de la señal en dB');
xlabel('Frecuencia (\pi/sample)');
ylabel('Amplitud (dB)');
legend('Native','FIR Low Pass');
grid on
hold off







% figure(2)
% f=[0 0.45 0.45 1];
% m=[300 300 0 0];
% [h,w]=freqz(gy,1);
% plot(f,m, w/pi,abs(h))
% grid on;