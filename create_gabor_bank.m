function gabor_bank = create_gabor_bank
    %% 
    l_exp = 1:4;
    wavelengths = 2.*(2.^l_exp);
    orientations = linspace(0,135,3); % todo:  make this random?

    gabor_bank = gabor(wavelengths,orientations);

end