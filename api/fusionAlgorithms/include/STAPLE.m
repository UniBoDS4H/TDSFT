%% Vectorized MATLAB implementation of the STAPLE algorithm by Warfield et al.
% This code currently only supports the case of binary segmentations.
% 
% Function:  [W, p, q] = STAPLE(D)
% Parameter: D, data matrix of segmentations, dimensions VOXELS x RATERS
% Returns:   W, est. weight matrix for each voxel
%            p, est. vector of sensitivities for each expert
%            q, est. vector of specificities for each expert
%
% You can simply threshold the resulting matrix W to get an estimated ground truth segmentation,
% e.g. T = (W >= .5)
%
% Literature: Warfield, Simon K., Kelly H. Zou, and William M. Wells. 
%            "Simultaneous truth and performance level estimation (STAPLE): 
%            an algorithm for the validation of image segmentation." 
%           Medical Imaging, IEEE Transactions on 23.7 (2004): 903-921.
%
% Andreas Husch
% 2013-07-10, 2015-07-06, 2016-05-10
% mail@andreashusch.de
%% Example for usage:
% %Using test data (2D prostate segmentations) from original publication
% s1 = nrrdread('seg001.nrrd');
% s2 = nrrdread('seg002.nrrd');
% s3 = nrrdread('seg003.nrrd');
% s4 = nrrdread('seg004.nrrd');
% s5 = nrrdread('seg005.nrrd');
% imageDims = size(s1);
% D = [s1(:), s2(:), s3(:), s4(:), s5(:)]; % pixels in rows, raters in columns
% [W, p, q]= STAPLE(D);
% % p,q values of your raters:
% p
% q
% Estimated ground truth image:
% gtImage = reshape((W >= .5), imageDims);
% figure, imagesc(gtImage)


%% Vectorized implementation of the classical STAPLE-Algorithm by Warfield et al. for binary segmentations
function [W, p, q] = STAPLE(D)
    %% Inputs & Checks
     if(size(D,2) > size(D,1))
         warning('Number of raters is larger than the number of voxels! Is the input transposed correctly?');
     end
     D = double(D);
     N = size(D,2); %Number of raters
     
    %% Parameters
    MAX_ITERATIONS = 100;
    EPSILON = 0.00001; % convergence criterion
    
    % Initial sensitivity and specificity parameter p(j),q(j) for all
    % raters j
    p(1:N) = 0.99999; 
    q(1:N) = 0.99999;
    Tprior = (sum(D(:))/length(D(:))); % note dependence on (sub)volume size, final result depends on this prior (which is not an implementation issue but a basic limitation of the EM approach)

    avgW = 1;
    W = zeros(1,length(D));
    
    %% EM
    %E-Schritt
    for step=1:MAX_ITERATIONS      
        % The following  code is equivalent to this loop by MUCH faster
        %     for i = 1:length(D)
        %         W(i) = ((prod(p(D(i,:))) * prod(1 - p(~D(i,:)))) * Tprior) / ... 
        %                ((prod(p(D(i,:))) * prod(1 - p(~D(i,:)))) * Tprior + (prod(q(~D(i,:))) * prod(1 - q(D(i,:))))) * (1- Tprior) ;
        %         %NOTE that prod([]) = 1
        %     end       
        P = repmat(p,length(D), 1);
        Q = repmat(q,length(D), 1);
        P_given_D = P .* D; %TODO: use bsxfun instead of repmat?
        P_given_D(P_given_D(:)== 0) = 1; %
        Q_given_D = 1 - Q .* D;
        Q_given_D(Q_given_D(:)== 0) = 1; % alternative: initialise with 1 and set Q_given_D(D) = 1- P(D) 
        compP_given_not_D  = 1 - P .* ~D;
        compP_given_not_D(compP_given_not_D(:)== 0) = 1;
        compQ_given_not_D  = Q .* ~D;
        compQ_given_not_D(compQ_given_not_D(:)== 0) = 1;

        % W(i) can be interpreted as the prob. of voxel i being true (i.e. is part of the ground-truth y) for given p(1:N), q(1:N) 
        W = (prod(P_given_D') .* prod(compP_given_not_D') * Tprior) ./ ...
           ((prod(P_given_D') .* prod(compP_given_not_D') * Tprior) + (prod(Q_given_D') .* prod(compQ_given_not_D') * (1 - Tprior))); %#ok<UDIM>

        % Convergence?
        if(abs(avgW - sum(W) / length(W)) < EPSILON)
            break;
        end
        avgW = sum(W) / length(W);

        % M-Step
        p = (W * D) / sum(W(:)); % W * D = sum(W(D))
        q = ((1 -  W) * ~D) / sum(1 - W(:)); 
    end
end