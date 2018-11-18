#***   This is a sample stego program written by Pavel.  ***
#***   It is written for demonstration purposes only,    ***
#***   DO NOT rely on it if you have something to hide   ***

#***   It uses LSB to hide a string with bitwise NOT     ***
#***   Not that easy to detect due to 7 bit encoding     ***
#***   with bitwise operator                             ***

#Main function to proof the concept
function [result] = stego()
  #Load image file
  origin = imread('bf3.jpg');
  #Show the original image
  subplot(2,1,1);
  imshow(origin);
  subplot(2,1,2);
  #Hide the text
  newimg = tostego(origin, 'DwaT.inc rocks!');
  #Show the image with hidden text
  imshow(newimg);
  imwrite(newimg, 'out.bmp');
  #Extract the text back
  extract_data(newimg)
endfunction

function [newimg] = tostego(origin, data)
  newimg = origin;
  hidden = double(data);
  hidden_bin = vec(dec2bin(hidden));
  for i=1:length(hidden_bin)
    newimg(i) = bitset(origin(i+1), 1, ~bin2dec(hidden_bin(i)));
  endfor
  newimg(end)=length(data);
endfunction

function [hidden_data] = extract_data(origin)
  for i=1:length(origin)
    hidden_bin(i)=dec2bin(~bitget(origin(i),1));
  endfor
  hidden_data=reshape(char(bin2dec(reshape(hidden_bin(1:origin(end)*7),[],7))),1,[]);
endfunction