function out = proximal_2x2_RGB(img, STEP = 0.1)
    % ==============================================================================================
    % Aplica Interpolare Proximala pe imaginea 2 x 2 definita img cu puncte intermediare echidistante.
    % img este o imagine colorata RGB -Red, Green, Blue.
    % =============================================================================================
    
    % initializam cu 0 canalele
    red_channel=blue_channel=green_channel=zeros(size(img,1));
    % TODO: Extrage canalul rosu al imaginii.
    red_channel=img(:,:,1);
    % TODO: Extrage canalul verde al imaginii.
    green_channel=img(:,:,2);
    % TODO: Extrage canalul albastru al imaginii.
    blue_channel=img(:,:,3);
    % TODO: Aplic? functia proximal pe cele 3 canale ale imaginii.
    red_final=proximal_2x2(red_channel,STEP);
    green_final=proximal_2x2(green_channel,STEP);
    blue_final=proximal_2x2(blue_channel,STEP);
    % TODO: Formeaza imaginea finala concatenând cele 3 canale de culori.
    out=cat(3,red_final,green_final,blue_final);
endfunction
