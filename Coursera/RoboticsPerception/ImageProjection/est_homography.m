function [ H ] = est_homography(video_pts, logo_pts)
% est_homography estimates the homography to transform each of the
% video_pts into the logo_pts
% Inputs:
%     video_pts: a 4x2 matrix of corner points in the video
%     logo_pts: a 4x2 matrix of logo points that correspond to video_pts
% Outputs:
%     H: a 3x3 homography matrix such that logo_pts ~ H*video_pts
% Written for the University of Pennsylvania's Robotics:Perception course

% YOUR CODE HERE
A = [];
V_ = video_pts;
V_(:,end+1) = 1.0;
L = logo_pts;
L(:,end+1) = 1.0;
A = zeros(size(V_,1),9);
for n=1:size(video_pts,1)
    v = V_(n,:);
    l = L(n,:);
    a_x = [-v 0 0 0 v*l(1)];
    a_y = [0 0 0 -v v*l(2)];
    A(2*n-1:2*n,:) = [a_x;a_y];
end
[U,S,V] = svd(A);
h=V(:,end);
H=[h(1:3)';h(4:6)';h(7:9)'];
H=H/H(3,3);

