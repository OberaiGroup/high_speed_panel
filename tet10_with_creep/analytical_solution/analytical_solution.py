import numpy as np

# Find an approximate solution to a system of equations
# f(x)=0
# by Newton's method
#
# f (input) : vector function f(x)
# fx (input) : function that determines the Jacobian matrix: fx(x)
# x0 (input) : initial guess
# tol (input) : convergence tolerance
# xc (output) : approximate solution
def solveSystemByNewton( f, fx, x0, tol ):
    # rename and init working variables
    n = size(x0)
    x_now = x0
    k=0
    MNBE = norm(f(x_now),Inf)

    while MNBE > tol:
        # calculate new x guess
        fc = f(x_now)
        J  =  fx( x_now)
        delta = np.linalg.solve(fx(x_now), fc)
        x_new = x_now-delta

        # update information
        x_now = x_new
        solution = f(x_now)
        MNBE = np.linalg.norm( solution, np.inf)
        k=k+1

    return x_now

def eq_100( kappa, alpha_hat, beta_hat, mu, delta, beta, T_t, T_0):

    term_1 = kappa/2 *((alpha_hat * beta_hat**2)**2 -1)

    term_2_a = alpha_hat**(-2/3) * beta_hat**(2/3) * delta
    term_2_b = alpha_hat**(4/3)  * beta_hat**(-4/3) * delta**(-2)
    term_2 = mu/3 * (term_2_a - term_2_b)

    term_3 = alpha_hat * beta_hat**(2) * beta *( T_t - T_0)

    ans = term_1 + term_2 - term_3

    return ans



def eq_101( delta_dot, B, mu, c_1, alpha_hat, beta_hat, delta):

    term_1 = delta_dot

    term_2_a = sqrt(2/27) * B * mu**(c_1)
    term_2_b = 2/3 * alpha_hat**(4/3) * beta_hat**(-4/3) * delta**(-2)
    term_2_c = 2/3 * alpha_hat**(-2/3) * beta_hat**(2/3) * delta

    term_2_d = delta + 2 * alpha_hat**(2) * beta_hat * delta**(4)

    term_2 = term_2_a * abs( term_2_b - term_2_c)**c_1 * term_2_d

    ans = term_1 - term_2

    return ans


    
def eq_101( delta_dot, B, mu, c_1, alpha_hat, beta_hat, delta, gamma):

    term_1 = delta_dot

    term_2_a = 2/3 * alpha_hat**(4/3) * beta_hat**(-4/3) * delta**(-2)
    term_2_b = 2/3 * alpha_hat**(-2/3) * beta_hat**(2/3) * delta

    term_2_c = gamma

    term_2_d = delta + 2 * alpha_hat**(2) * beta_hat * delta**(4)

    term_2 = sqrt(2/27) * (B * mu**c_1 * abs( term_2_a - term_2_b)**c_1 + term_2_c) * term_2_d

    ans = term_1 - term_2

    return ans



def eq_103( tau_dot, K):

    gamma = sqrt( 2/3) * tau_dot / K

    return gamma



def eq_104( kappa, alpha_hat, beta_hat, mu, delta, beta, T_t, T_0):

    term_1 = kappa / 2 * ( (alpha_hat * beta_hat**(2))**2 - 1)

    term_2_a = alpha_hat**(4/3) * beta_hat**(-4/3) * delta*(-2)
    term_2_b = alpha_hat * beta_hat**(4) * delta
    term_2   =  mu/3 * (term_2_a - term_2_b)

    term_3 = alpha_hat * beta_hat**(4) * beta * (T_t - T_0)

    tau = term_1 + term_2 - term_3

    return tau

class alpha_hat:
    t_final = 0.0
    t_init  = 0.0

    initial = 0.0
    final   = 0.0

    rate = 0.0

    def __init__(self, t0, tf, initial_value, final_value):
        self.t_final = tf
        self.t_init  = t0

        self.initial = initial_value
        self.final   = final_value

        self.rate = (self.final - self.initial) / (self.t_final - self.t_init)

    def get_value(self, time):
        ans = self.rate * time + self.initial
        return ans

## Problem parameters
# Start, final time; seconds
t0 = 0
tf = 5

# Start, final temperature; kelvin
T0 = 443
Tf = 743

## Material properties for Tin
# Young's Modulus; MPa
E = 4.52E4
# Poisson's ratio; unitless
nu = 0.33
# Yield strength; MPa
sigma_Y = 30
# Hardening Modulus; MPa
H = 60
# Linear thermal expansion coeff.; 1/kelvin
alpha_L = 2.2E-5
# Stress exponent; unitless
c_1 = 9.7
# Relaxation parameter; 1/second
A_bar = 1.0
# Reference stress parameter; MPa
sigma_0 = 25.66
# Activation energy; kJoule/Mole
Q = 31.4
# Gas Constant; kJoule/(Mole Kelvin)
R = 8.3145E-3
# Initial and final values of alpha_hat
alpha_hat_init  = 0.0
alpha_hat_final = 0.2

## Solution parameter
# Tolerance of newton solves:
tolerance = 1E-6
# Max number of iterations for Newton step
max_iters = 1E4
# Number of evaluation points between t0 and tf
num_t = 1E2


a_hat = alpha_hat( t0, tf, alpha_hat_init, alpha_hat_final)

time = t0
dt = (tf-t0)/(num_t +1)
while time < tf:
    time += dt







    print("Time is %f" % time)

















