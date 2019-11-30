%I = imagem de entrada (maracana1)
%ponto = Ponto escolhido

I = imread('maracana1.jpg');

[M N C] = size(I);

%Pontos da camera
cpoints = [
   160, 138, 1
   158, 110, 1
   124, 157, 1
   123, 126, 1
   240, 130, 1
   248, 220, 1
   32,  203, 1];

 wpoints = [0,    0,      0,    1
            0,    0,      2.44, 1
            0,    -7.32,  0,    1
            0,    -7.32,  2.44, 1
            5.5,  5.5,    0,    1
            16.5, -23.82, 0,    1
            0,    -23.82, 0,    1];
 
%Calcula a matriz de projeção
PMatrix = dltI(cpoints, wpoints,12);

rs_1 = PMatrix(1:3,1:2);

rs_2 = PMatrix(1:3,4:4);

PMatrix_nc3 = [rs_1 rs_2];

h = image(I);
p = ginput(1);
while(p(1) > 0 && p(1) < N && p(2) > 0 && p(2) < M)
    ponto = [round(p(1)) round(p(2)) 1];
    
    ponto_mundo = (PMatrix_nc3^-1) * ponto';

    ponto_mundo = ponto_mundo / ponto_mundo(3);

    ponto_mundo_altura = [ponto_mundo(1) ponto_mundo(2) 1.80 1];

    cabeca_na_imagem = PMatrix * ponto_mundo_altura';
    cabeca_na_imagem = cabeca_na_imagem / cabeca_na_imagem(3);
    cabeca_na_imagem_x = round(cabeca_na_imagem(1));
    cabeca_na_imagem_y = round(cabeca_na_imagem(2));
    
    if(cabeca_na_imagem_y < 1)
        cabeca_na_imagem_y = 1;
    end
    if(cabeca_na_imagem_x < 1)
        cabeca_na_imagem_x = 1;
    end
    
    I(cabeca_na_imagem_y, cabeca_na_imagem_x, :) = 255;
    pes_x = ponto(1);
    pes_y = ponto(2);

    v1 =  double([pes_x - cabeca_na_imagem_x, pes_y - cabeca_na_imagem_y]);
    v1 = v1 / norm(v1);

    pv = double([cabeca_na_imagem_x cabeca_na_imagem_y]);
    while(pv(1) + pv(2)*M < pes_x + pes_y*M)
        pv = pv + v1;
        I(round(pv(2)), round(pv(1)), :) = 255;
    end
    h = image(I);
    drawnow;
    p = ginput(1);
end

