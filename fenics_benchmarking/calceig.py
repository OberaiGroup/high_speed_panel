import numpy as np
from dolfin import *
# Test for PETSc and SLEPc

if not has_linear_algebra_backend("PETSc"):
    print("DOLFIN has not been configured with PETSc. Exiting.")
    exit()

if not has_slepc():
    print("DOLFIN has not been configured with SLEPc. Exiting.")
    exit()

nx = ny = 500
fa = 2.0
fb = 3.0
fc = 1.0
# Define the scale epsilon
mesh = RectangleMesh(Point(-1, -1), Point(1, 1), nx, ny)
P1 = VectorElement("Lagrange", mesh.ufl_cell(),1,4)
V = FunctionSpace(mesh, "Lagrange", 1)
#W = FunctionSpace(mesh, P1)

def calceig(epsilon):
#epsilon = 0.01
    rho=Expression('(ep+(erf((-sqrt(pow(x[0]-x1,2)+pow(x[1]-y1,2))+r1)/ep)+1.0)/(4.0*pi*r1*r1) + (erf((-sqrt(pow(x[0]-x2,2)+pow(x[1]-y2,2))+r2)/ep)+1.0)/(4.0*pi*r2*r2))',degree=2,ep=epsilon,r1=0.25,x1=-0.5,y1=0.0,r2=0.25,x2=0.5,y2=0.3)
#rho=Expression('exp(-sqrt(pow(x[0]-x1,2)+pow(x[1]-y1,2)))',degree=2,x1=0.3,y1=0.6)
#rho = Constant(1.0)
    rho_v = interpolate(rho, V)
#
#rho = Expression('s0+s1*(pow(x[0]-x1,2)+pow(x[1]-y1,2)<pow(r1,2))',degree=2,x1=0.3,y1=0.6,r1=0.2,s0=0.epsilon,s1=1.0)
#rho_v  = TrialFunction(V)
#rv = TestFunction(V)
#ar = rho_v*rv*dx-epslion*epsilon*dot(grad(rho_v), grad(rv))*dx
#rL = rv*rho*dx
#rho_v = Function(V)
#solve(ar == rL, rho_v)
#
#vtkfile0 = File('eigen/rho.pvd')
#vtkfile0 << rho_v

# Define basis and bilinear form
    u = TrialFunction(V)
    v = TestFunction(V)
#    a = rho_v*rho_v*dot(grad(u), grad(v))*dx
    a = pow(rho_v,fb)*dot(grad(u), grad(v))*dx
#b = rho_v*u*v*dx
# normalized 
    b = pow(rho_v,fa+fc)*u*v*dx

# Assemble stiffness form
    A = PETScMatrix()
    assemble(a, tensor=A)
    B = PETScMatrix()
    assemble(b, tensor=B)
# Create eigensolver
    eigensolver = SLEPcEigenSolver(A,B)
    eigensolver.parameters["spectrum"] = "target real"
    eigensolver.parameters["problem_type"] = "gen_hermitian"
    eigensolver.parameters['tolerance'] = 1e-9
    eigensolver.parameters['spectral_transform'] = 'shift-and-invert'
    eigensolver.parameters['spectral_shift'] = 1e-9   # Fine grid lambda_min
    eigensolver.parameters['verbose'] = True # for debugging
#eigensolver.parameters["solver"] = "lanczos"
    PETScOptions.set("eps_view")

# Compute all eigenvalues of A x = \lambda x
    print("Computing eigenvalues. This can take a minute.")
    eigensolver.solve(8)

    converged = eigensolver.get_number_converged()
#print "Converged EV: %r" % converged

# Extract largest (first) eigenpair
    r1, c1, rx1, cx1 = eigensolver.get_eigenpair(0)
    r2, c2, rx2, cx2 = eigensolver.get_eigenpair(1)
    r3, c3, rx3, cx3 = eigensolver.get_eigenpair(2)
    r4, c4, rx4, cx4 = eigensolver.get_eigenpair(3)
    r5, c5, rx5, cx5 = eigensolver.get_eigenpair(4)
    r6, c6, rx6, cx6 = eigensolver.get_eigenpair(5)
    r7, c7, rx7, cx7 = eigensolver.get_eigenpair(6)
    r8, c8, rx8, cx8 = eigensolver.get_eigenpair(7)

# Finally, we want to examine the results. The eigenvalue can easily be
# printed. But, the real part of eigenvector is probably most easily
# visualized by constructing the corresponding eigenfunction. This can
# be done by creating a :py:class:`Function
# <dolfin.functions.function.Function>` in the function space ``V``
# and the associating eigenvector ``rx`` with the Function. Then the
# eigenfunction can be manipulated as any other :py:class:`Function
# <dolfin.functions.function.Function>`, and in particular plotted ::

    reig = np.transpose(np.array([epsilon,r1,r2,r3,r4,r5,r6,r7,r8]))
    file1=open('results/eig.txt','a')
#    np.savetxt(file1,reig,delimiter=',',newline=' ')
    np.savetxt(file1,reig)
#

epsilon = 0.1
for ii in range(8):
    calceig(epsilon)
    print('epsilon')
    print(epsilon)
    epsilon = 0.5*epsilon


#print('eigenvalues')
#print(r1,r2,r3,r4,r5,r6,r7,r8)

# Initialize function and assign eigenvector
#u1 = Function(V)
#u2 = Function(V)
#u3 = Function(V)
#u4 = Function(V)
#u5 = Function(V)
#u6 = Function(V)
#u7 = Function(V)
#u8 = Function(V)


#u1.vector()[:] = rx1
#u2.vector()[:] = rx2
#u3.vector()[:] = rx3
#u4.vector()[:] = rx4
#u5.vector()[:] = rx5
#u6.vector()[:] = rx6
#u7.vector()[:] = rx7
#u8.vector()[:] = rx8

#vtkfile1 = File('eigen/evec1.pvd')
#vtkfile2 = File('eigen/evec2.pvd')
#vtkfile3 = File('eigen/evec3.pvd')
#vtkfile4 = File('eigen/evec4.pvd')
#vtkfile5 = File('eigen/evec5.pvd')
#vtkfile6 = File('eigen/evec6.pvd')
#vtkfile7 = File('eigen/evec7.pvd')
#vtkfile8 = File('eigen/evec8.pvd')

#vtkfile1 << u1
#vtkfile2 << u2
#vtkfile3 << u3
#vtkfile4 << u4
#vtkfile5 << u5
#vtkfile6 << u6
#vtkfile7 << u7
#vtkfile8 << u8
