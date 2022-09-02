function out = proximal_resize_RGB(img, p, q)
    % =========================================================================
    % Redimensioneaza imaginea img astfel încât aceasta save fie de dimensiune p x q.
    % Imaginea img este colorata.
    % =========================================================================

    % initializam cu 0 canalele
    red_channel=blue_channel=green_channel=zeros(size(img,1));
    % TODO: Extrage canalul rosu al imaginii.
    red_channel=img(:,:,1);
    % TODO: Extrage canalul verde al imaginii.
    green_channel=img(:,:,2);
    % TODO: Extrage canalul albastru al imaginii.
    blue_channel=img(:,:,3);
    % TODO: Aplica functia proximal pe cele 3 canale ale imaginii.
    red_final=proximal_resize(red_channel,p,q);
    green_final=proximal_resize(green_channel,p,q);
    blue_final=proximal_resize(blue_channel,p,q);
    % TODO: Formeaza imaginea finala concatenând cele 3 canale de culori.
    out=cat(3,red_final,green_final,blue_final);
endfunction
