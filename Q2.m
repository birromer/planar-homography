I = imread('maracana2.jpg');
%ponto = Ponto escolhido

[M N C] = size(I);

%Pontos da camera
cpoints = [
   266, 238, 1
   268, 61,  1
   550, 60,  1
   575, 100, 1
   473, 98,  1
   507, 177, 1
];

 wpoints = [0,    0,       0.01, 1
            0,    40.32,   0.0, 1
            16.5, 40.32,   0.01, 1
            16.5, 29.32,   0.01, 1
            11,   29.32,   0.01, 1
            11,   11,      0.01, 1
         ];
 
%Calcula a matriz de projeção
PMatrix = dltII(cpoints, wpoints);

PMatrix_nc3 = PMatrix;

h = image(I);
p = ginput(1);

while(p(1) > 0 && p(1) < N && p(2) > 0 && p(2) < M)
    ponto = [round(p(1)) round(p(2)) 1];
    ponto_mundo = (PMatrix_nc3^-1) * ponto';

    ponto_mundo = ponto_mundo / ponto_mundo(3);

    ponto_sup_mundo = [ponto_mundo(1) 52.82 1];
    ponto_inf_mundo = [ponto_mundo(1) -14.5   1];

    ponto_sup_camera = PMatrix * ponto_sup_mundo';
    ponto_inf_camera = PMatrix * ponto_inf_mundo';

    ponto_sup_camera = ponto_sup_camera / ponto_sup_camera(3);
    ponto_inf_camera = ponto_inf_camera / ponto_inf_camera(3);

    I(round(ponto_sup_camera(2)),round(ponto_sup_camera(1)), 1) = 255;
    I(round(ponto_sup_camera(2)),round(ponto_sup_camera(1)), 2) = 0;
    I(round(ponto_sup_camera(2)),round(ponto_sup_camera(1)), 3) = 0;
    I(round(ponto_inf_camera(2)),round(ponto_inf_camera(1)), 1) = 255;
    I(round(ponto_inf_camera(2)),round(ponto_inf_camera(1)), 2) = 0;
    I(round(ponto_inf_camera(2)),round(ponto_inf_camera(1)), 3) = 0;

    v1 = double(ponto_inf_camera - ponto_sup_camera);
    v1 = v1 / norm(v1);

    pv = ponto_sup_camera;
    while(pv(1) + pv(2)*M < ponto_inf_camera(1) + ponto_inf_camera(2)*M)
        pv = pv + v1;
        I(round(pv(2)), round(pv(1)), 1) = 255;
        I(round(pv(2)), round(pv(1)), 2) = 0;
        I(round(pv(2)), round(pv(1)), 3) = 0;
    end
    h = image(I);
    drawnow;
    p = ginput(1);
end



