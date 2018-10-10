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

# Geometry of Box
# Differs from Albany only in that beam extends in X direction instead of Y
lx = 1
lz = 0.01
ly = 0.01
# Number of elements in each direction
Nx = 40
Nz =  4
Ny =  4
# Create the geometry and mesh
mesh = BoxMesh(Point(0.0, 0.0, 0.0), Point(lx, ly, lz),Nx,Ny,Nz)
V = VectorFunctionSpace(mesh, "Lagrange", 2)
M = FunctionSpace(mesh, "Lagrange", 1)

# Initialize mesh function for interior domains
domains = MeshFunction("size_t", mesh, mesh.topology().dim())
domains.set_all(0)

# Initialize mesh function for boundary domains
boundaries = MeshFunction("size_t", mesh, mesh.topology().dim()-1)
boundaries.set_all(0)
left.mark(boundaries, 1)
right.mark(boundaries, 2)


# Define Dirichlet boundary (x = 0)
b = Constant((0.0, 0.0, 0.0))
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
v  = TestFunction(V)             # Test function
u  = Function(V)                 # Displacement from previous iteration
B  = Constant((0.0, 0.0, 0.0))  # Body force per unit volume

# Kinematics
d = len(u)
I = Identity(d)             # Identity tensor
epsilon = 0.5*(grad(u)+grad(u).T) # Deformation gradient

# Material Properties
E  = 4000; # Pascals, Young's Modulus
nu = 0.25;
mu = Constant( E / ( 2.0*( 1.0 + nu)))
lmbda = Constant( E * nu / ( (1.0 + nu)*(1.0 - 2.0 * nu) ))

# Cauchy Stress (compressible neo-Hookean model)
sig = 2*mu*epsilon+lmbda*tr(epsilon)*I

#petsc test begin
a = inner( grad(v),sig )*dx
print( "a's type:")
print( type( a))
print( " ")
L = dot(t,v)*ds(2)

# Assemble system
assemble(a, tensor=A)
print( "A's Type")
print( type( A) )
print( A)
as_backend_type( A, subclass="PETScMatrix")
b = assemble(L)

# Set PETSc solve type (conjugate gradient) and preconditioner
# (algebraic multigrid)
PETScOptions.set("ksp_type", "cg")
PETScOptions.set("pc_type", "gamg")

# Since we have a singular problem, use SVD solver on the multigrid
# 'coarse grid'
PETScOptions.set("mg_coarse_ksp_type", "preonly")
PETScOptions.set("mg_coarse_pc_type", "svd")

# Set the solver tolerance
PETScOptions.set("ksp_rtol", 1.0e-8)

# Print PETSc solver configuration
PETScOptions.set("ksp_view")
PETScOptions.set("ksp_monitor")

# Create Krylov solver and set operator
solver = PETScKrylovSolver()
solver.set_operator(A)

# Set PETSc options on the solver
solver.set_from_options()
# Solve
solver.solve( u.vector(), b)


#petsc test end 

# Save solution in VTK format
file = File("beam/displacement.pvd");
file << u;

