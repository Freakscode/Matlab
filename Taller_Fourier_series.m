clc; clear all; close all;

Fs = 1200
L = 2000
t = -pi:1/L:pi;
w = 2*pi/(2*pi)*5;
a=input('Digite cuántos armónicos quiere calcular');
while a == 0
    disp('Digite un valor diferente de cero')
    a=input('Digite cuántos armónicos quiere calcular')
end
n = 1:2:a;
Sg=0;
for j=1:length(n)
    for i=1:length(t)
        Sg_sin(j,i) = sin(n(j)*w*t(i))/n(j);
    end
    Sg=Sg+Sg_sin(j,:);
end

figure(1)
plot(t, Sg),xlabel('Tiempo'), ylabel('Valores de Serie de Fourier')
title('Señal Fundamental', 'FontAngle','italic')
legend('STF')

Y=fft(Sg)
Y=fft(Sg)
P2 = abs(Y/L)
P1 = P2(1:L/2+1)
P1(2:end-1) = 2*P1(2:end-1)
f = (Fs*(0:(L/2))/L)
figure(2)
plot(f, P1, 'm--'), xlabel('Frecuencia'), ylabel('Amplitud'),
title('Señal Fundamental', 'FontAngle','italic')
legend('Espectro de señal')

opt = input('¿Desea gráficar de nuevo la función con diferentes armónicos? [Sí - 1; No - 2]')
switch opt
    case 1
        a=input('Digite cuántos armónicos quiere calcular');
        while a == 0
            disp('Digite un valor diferente de cero')
            a=input('Digite cuántos armónicos quiere calcular')
        end
        n = 1:2:a;
        Sg=0;
        for j=1:length(n)
            for i=1:length(t)
                Sg_sin(j,i) = sin(n(j)*w*t(i))/n(j);
            end
            Sg=Sg+Sg_sin(j,:);
        end
        figure(4)
        plot(t, Sg),xlabel('Tiempo'), ylabel('Valores de Fourier')
        title('Señal Fundamental', 'FontAngle','italic')
        legend('STF')

        Y=fft(Sg)

        Y=fft(Sg)
        P2 = abs(Y/L)
        P1 = P2(1:L/2+1)
        P1(2:end-1) = 2*P1(2:end-1)
        f = (Fs*(0:(L/2))/L)
        figure(5)
        plot(f, P1)
        plot(f, P1, 'r-o'), xlabel('Frecuencia'), ylabel('Amplitud'),
        title('Señal Fundamental', 'FontAngle','italic')
        legend('Espectro de señal')

    case 2

        %% Como ejercicio académico se decidió configurar parte del algoritmo para agregar ruido a la señal y generar un filtro

        noi = input('¿Desea agregar ruido a la señal? [Sí - 1; No-2]')
        switch noi
            case 1
                a=input('Digite cuántos armónicos quiere calcular');
                while a == 0
                    disp('Digite un valor diferente de cero')
                    a=input('Digite cuántos armónicos quiere calcular');
                end
                n = 1:2:a;
                Sg=0;
                for j=1:length(n)
                    for i=1:length(t)
                        Sg_sin(j,i) = sin(n(j)*w*t(i))/n(j);
                    end
                    Sg=Sg+Sg_sin(j,:);
                end
                Sg_noise= Sg + randn(size(t));

                figure(4)
                plot(t, Sg_noise),xlabel('Tiempo'), ylabel('Valores de la señal');
                title('Señal "contaminada"', 'FontAngle','italic');
                legend('STF');

                Y=fft(Sg_noise)
                P2 = abs(Y/L)
                P1 = P2(1:L/2+1)
                P1(2:end-1) = 2*P1(2:end-1)
                f = (Fs*(0:(L/2))/L)
                figure(5)
                plot(f, P1)
                plot(f, P1, 'r-o'), xlabel('Frecuencia'), ylabel('Amplitud'),
                title('Señal Fundamental', 'FontAngle','italic')
                legend('Espectro de señal')

                idx = P2 > 0.3;
                sg_flt = Y.*idx
                sg_flt_t=ifft(sg_flt)
                figure(6)
                plot(Sg_noise, 'b--');
                hold on
                plot(sg_flt_t, 'r-');
                legend("Señal Original", "Señal Filtrada");
            case 2
                close
        end


end
