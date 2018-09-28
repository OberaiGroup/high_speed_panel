import matplotlib.pyplot as plt
from dolfin import *

parameters["form_compiler"]["cpp_optimize"] = True
parameters["form_compiler"]["representation"] = "uflacs"

class Left(SubDomain):
    def inside(self, x, on_boundary):
        return near(x[0], 0.0)

class Right(SubDomain):
    def inside(self, x, on_boundary):
        return near(x[0], 1.0)
#
# Initialize sub-domain instances
left = Left()
right = Right()
#
lx = 1
lz = 1
ly = 0.01
mesh = BoxMesh(Point(0.0, 0.0, 0.0), Point(lx, ly, lz),20,20,20)
V = VectorFunctionSpace(mesh, "Lagrange", 1)
M = FunctionSpace(mesh, "Lagrange", 1)

# Initialize mesh function for interior domains
domains = MeshFunction("size_t", mesh, mesh.topology().dim())
domains.set_all(0)

# Initialize mesh function for boundary domains
boundaries = MeshFunction("size_t", mesh, mesh.topology().dim()-1)
boundaries.set_all(0)
left.mark(boundaries, 1)
right.mark(boundaries, 2)


# Define Dirichlet boundary (x = 0 or x = 1)
b = Constant((0.0, 0.0, 0.0))
#r = Expression(("3cale*0.0",
#                "scale*(y0 + (x[1] - y0)*cos(theta) - (x[2] - z0)*sin(theta) - x[1])",
#                "scale*(z0 + (x[1] - y0)*sin(theta) + (x[2] - z0)*cos(theta) - x[2])"),
#                scale = 0.6, y0 = 0.5, z0 = 0.5, theta = pi/3, degree=2)
t = Expression(("scale*0.0",
                "-scale*1.0",
                "scale*0.0"),
                scale = 0.01, degree=2)


bcl = DirichletBC(V, b, boundaries, 1)
bcs = [bcl]


dx = Measure('dx', domain=mesh, subdomain_data=domains)

# Define new measures associated with  the boundaries 
ds = Measure('ds', domain=mesh, subdomain_data=boundaries)

# Define functions
du = TrialFunction(V)            # Incremental displacement
v  = TestFunction(V)             # Test function
u  = Function(V)                 # Displacement from previous iteration
B  = Constant((0.0, 0.0, 0.0))  # Body force per unit volume

# Kinematics
d = len(u)
I = Identity(d)             # Identity tensor
epsilon = 0.5*(grad(u)+grad(u).T) # Deformation gradient

# Elasticity parameters
#mu=Expression(("s0 + s1*((x[1] >= 0.0)&(x[1] < lyi)) + s2*((x[1] >= lyi)&(x[1] <= ly))"),s0=1.0,s1=5.0,s2=0.0,ly=3.1,lyi=1.1,element = M.ufl_element())

mu = Constant("1000.0")
lmbda = Constant("1000.0")

# Cauchy Stress (compressible neo-Hookean model)
sig = 2*mu*epsilon+lmbda*tr(epsilon)*I

#Weak residual 
Fn = inner(grad(v),sig)*dx-dot(B, v)*dx - dot(t,v)*ds(2) 
# Solve variational problem
solve(Fn == 0, u, bcs)


# Save solution in VTK format
file = File("beam/displacement.pvd");
file << u;
