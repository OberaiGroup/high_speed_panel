% Find an approximate solution to a system of equations
% f(x)=0
% by Newton's method
%
% f (input) : vector function f(x)
% fx (input) : function that determines the Jacobian matrix: fx(x)
% x0 (input) : initial guess
% tol (input) : convergence tolerance
% xc (output) : approximate solution
%
function x_now = solveSystemByNewton( f, fx, x0, tol )
  % rename and init working variables
  n = size(x0);
  x_now = x0;
  k=0;
  MNBE = norm(f(x_now),Inf);

  while MNBE > tol;
      % calculate new x guess
      fc = f(x_now);
      delta = fx(x_now)\fc;
      x_new = x_now-delta';

      % update information
      x_now = x_new;
      MNBE = norm(f(x_now),Inf);
      k=k+1;

  end
end
