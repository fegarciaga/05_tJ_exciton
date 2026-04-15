using ITensors
using ITensorMPS
using DelimitedFiles
using LinearAlgebra

ITensors.enable_debug_checks()

function ITensors.space(::SiteType"2tJ";
                        conserve_qns=false)
    if conserve_qns
        return [QN("Nt", 0, -1) => 1, Qn("Nt", 1, -1) => 4,
                QN("Nt", 2, -1) => 4]
    else
        return 9
    end
end

ITensors.val(::ValName"AEmpBEmp", ::SiteType"2tJ") = 1
ITensors.val(::ValName"AupBEmp", ::SiteType"2tJ")  = 2
ITensors.val(::ValName"AdnBEmp", ::SiteType"2tJ")  = 3
ITensors.val(::ValName"AEmpBup", ::SiteType"2tJ")  = 4
ITensors.val(::ValName"AEmpBdn", ::SiteType"2tJ")  = 5
ITensors.val(::ValName"AupBup",  ::SiteType"2tJ")  = 6
ITensors.val(::ValName"AupBdn",  ::SiteType"2tJ")  = 7
ITensors.val(::ValName"AdnBup",  ::SiteType"2tJ")  = 8
ITensors.val(::ValName"AdnBdn",  ::SiteType"2tJ")  = 9

ITensors.state(::StateName"AEmpBEmp", ::SiteType"2tJ") = [1.0, 0, 0, 0, 0, 0, 0, 0, 0]
ITensors.state(::StateName"AupBEmp",  ::SiteType"2tJ") = [0, 1.0, 0, 0, 0, 0, 0, 0, 0]
ITensors.state(::StateName"AdnBEmp",  ::SiteType"2tJ") = [0, 0, 1.0, 0, 0, 0, 0, 0, 0]
ITensors.state(::StateName"AEmpBup",  ::SiteType"2tJ") = [0, 0, 0, 1.0, 0, 0, 0, 0, 0]
ITensors.state(::StateName"AEmpBdn",  ::SiteType"2tJ") = [0, 0, 0, 0, 1.0, 0, 0, 0, 0]
ITensors.state(::StateName"AupBup",   ::SiteType"2tJ") = [0, 0, 0, 0, 0, 1.0, 0, 0, 0]
ITensors.state(::StateName"AupBdn",   ::SiteType"2tJ") = [0, 0, 0, 0, 0, 0, 1.0, 0, 0]
ITensors.state(::StateName"AdnBup",   ::SiteType"2tJ") = [0, 0, 0, 0, 0, 0, 0, 1.0, 0]
ITensors.state(::StateName"AdnBdn",   ::SiteType"2tJ") = [0, 0, 0, 0, 0, 0, 0, 0, 1.0]

function ITensors.op!(Op::ITensor, ::OpName"Nt", ::SiteType"2tJ", s::Index)
    Op[s' => 2, s => 2] = 1
    Op[s' => 3, s => 3] = 1
    Op[s' => 4, s => 4] = 1
    Op[s' => 5, s => 5] = 1
    Op[s' => 6, s => 6] = 2
    Op[s' => 7, s => 7] = 2
    Op[s' => 8, s => 8] = 2
    return Op[s' => 9, s => 9] = 2
end

function ITensors.op!(Op::ITensor, ::OpName"Caup", ::SiteType"2tJ", s::Index)
    Op[s' => 1, s => 2] = 1
    Op[s' => 4, s => 6] = -1
    return Op[s' => 5, s => 7] = -1
end

function ITensors.op!(Op::ITensor, ::OpName"Cadagup", ::SiteType"2tJ", s::Index)
    Op[s' => 2, s => 1] = 1
    Op[s' => 6, s => 4] = -1
    return Op[s' => 7, s => 5] = -1
end

function ITensors.op!(Op::ITensor, ::OpName"Cadn", ::SiteType"2tJ", s::Index)
    Op[s' => 1, s => 3] = 1
    Op[s' => 4, s => 8] = -1
    return Op[s' => 5, s => 9] = -1
end

function ITensors.op!(Op::ITensor, ::OpName"Cadagdn", ::SiteType"2tJ", s::Index)
    Op[s' => 3, s => 1] = 1
    Op[s' => 8, s => 4] = -1
    return Op[s' => 9, s => 5] = -1
end

function ITensors.op!(Op::ITensor, ::OpName"Cbup", ::SiteType"2tJ", s::Index)
    Op[s' => 1, s => 4] = 1
    Op[s' => 2, s => 6] = 1
    return Op[s' => 3, s => 8] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Cbdagup", ::SiteType"2tJ", s::Index)
    Op[s' => 4, s => 1] = 1
    Op[s' => 6, s => 2] = 1
    return Op[s' => 8, s => 3] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Cbdn", ::SiteType"2tJ", s::Index)
    Op[s' => 1, s => 5] = 1
    Op[s' => 2, s => 7] = 1
    return Op[s' => 3, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Cbdagdn", ::SiteType"2tJ", s::Index)
    Op[s' => 5, s => 1] = 1
    Op[s' => 7, s => 2] = 1
    return Op[s' => 9, s => 3] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"F", ::SiteType"2tJ", s::Index)
    Op[s' => 1, s => 1] = 1
    Op[s' => 2, s => 2] = -1
    Op[s' => 3, s => 3] = -1
    Op[s' => 4, s => 4] = -1
    Op[s' => 5, s => 5] = -1
    Op[s' => 6, s => 6] = 1
    Op[s' => 7, s => 7] = 1
    Op[s' => 8, s => 8] = 1
    return Op[s' => 9, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Naup", ::SiteType"2tJ", s::Index)
    Op[s' => 2, s => 2] = 1
    Op[s' => 6, s => 6] = 1
    return Op[s' => 7, s => 7] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Nadn", ::SiteType"2tJ", s::Index)
    Op[s' => 3, s => 3] = 1
    Op[s' => 8, s => 8] = 1
    return Op[s' => 9, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Na", ::SiteType"2tJ", s::Index)
    Op[s' => 2, s => 2] = 1
    Op[s' => 3, s => 3] = 1
    Op[s' => 6, s => 6] = 1
    Op[s' => 7, s => 7] = 1
    Op[s' => 8, s => 8] = 1
    return Op[s' => 9, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Nbup", ::SiteType"2tJ", s::Index)
    Op[s' => 4, s => 4] = 1
    Op[s' => 6, s => 6] = 1
    return Op[s' => 8, s => 8] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Nbdn", ::SiteType"2tJ", s::Index)
    Op[s' => 5, s => 5] = 1
    Op[s' => 7, s => 7] = 1
    return Op[s' => 9, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Nb", ::SiteType"2tJ", s::Index)
    Op[s' => 4, s => 4] = 1
    Op[s' => 5, s => 5] = 1
    Op[s' => 6, s => 6] = 1
    Op[s' => 7, s => 7] = 1
    Op[s' => 8, s => 8] = 1
    return Op[s' => 9, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Sza", ::SiteType"2tJ", s::Index)
    Op[s' => 2, s => 2] = 0.5
    Op[s' => 3, s => 3] = -0.5
    Op[s' => 6, s => 6] = 0.5
    Op[s' => 7, s => 7] = 0.5
    Op[s' => 8, s => 8] = -0.5
    return Op[s' => 9, s => 9] = -0.5
end

function ITensors.op!(Op::ITensor, ::OpName"Szb", ::SiteType"2tJ", s::Index)
    Op[s' => 4, s => 4] = 0.5
    Op[s' => 5, s => 5] = -0.5
    Op[s' => 6, s => 6] = 0.5
    Op[s' => 7, s => 7] = -0.5
    Op[s' => 8, s => 8] = 0.5
    return Op[s' => 9, s => 9] = -0.5
end

function ITensors.op!(Op::ITensor, ::OpName"Spa", ::SiteType"2tJ", s::Index)
    Op[s' => 2, s => 3] = 1
    Op[s' => 6, s => 8] = 1
    return Op[s' => 7, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Sma", ::SiteType"2tJ", s::Index)
    Op[s' => 3, s => 2] = 1
    Op[s' => 8, s => 6] = 1
    return Op[s' => 9, s => 7] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Spb", ::SiteType"2tJ", s::Index)
    Op[s' => 4, s => 5] = 1
    Op[s' => 6, s => 7] = 1
    return Op[s' => 8, s => 9] = 1
end

function ITensors.op!(Op::ITensor, ::OpName"Smb", ::SiteType"2tJ", s::Index)
    Op[s' => 5, s => 4] = 1
    Op[s' => 6, s => 8] = 1
    return Op[s' => 9, s => 8] = 1
end

ITensors.has_fermion_string(::OpName"Cadagup", ::SiteType"2tJ") = true
ITensors.has_fermion_string(::OpName"Caup", ::SiteType"2tJ") = true
ITensors.has_fermion_string(::OpName"Cadagdn", ::SiteType"2tJ") = true
ITensors.has_fermion_string(::OpName"Cadn", ::SiteType"2tJ") = true
ITensors.has_fermion_string(::OpName"Cbdagup", ::SiteType"2tJ") = true
ITensors.has_fermion_string(::OpName"Cbup", ::SiteType"2tJ") = true
ITensors.has_fermion_string(::OpName"Cbdagdn", ::SiteType"2tJ") = true
ITensors.has_fermion_string(::OpName"Cbdn", ::SiteType"2tJ") = true

function Build_H(N, t, J, Jinter, mu1, mu2)
    os = OpSum()
    for i in 1:N-1
        # Hopping
        os += -t, "Cadagup", i, "Caup", i+1
        os += -t, "Cadagup", i+1, "Caup", i
        os += -t, "Cadagdn", i, "Cadn", i+1
        os += -t, "Cadagdn", i+1, "Cadn", i

        os += -t, "Cbdagup", i, "Cbup", i+1
        os += -t, "Cbdagup", i+1, "Cbup", i
        os += -t, "Cbdagdn", i, "Cbdn", i+1
        os += -t, "Cbdagdn", i+1, "Cbdn", i

        # Exchange
        os += J, "Sza", i, "Sza", i+1
        os += J/2, "Spa", i, "Sma", i+1
        os += J/2, "Spa", i+1, "Sma", i

        os += J, "Szb", i, "Szb", i+1
        os += J/2, "Spb", i, "Smb", i+1
        os += J/2, "Spb", i+1, "Smb", i

    end

    for i in 1:N
        os += Jinter, "Sza", i, "Szb", i
        os += Jinter/2, "Spa", i, "Smb", i
        os += Jinter/2, "Sma", i, "Spb", i

        #Chemical potential
        os += -mu1, "Na", i
        os += -mu2, "Nb", i
    end
    return os
end

N = 24
sites = siteinds("2tJ", N)

t = 1
J = 4
Jinter = 1
mu1 = 1
mu2 = 0.8
H = MPO(Build_H(N, t, J, Jinter, mu1, mu2), sites)
state = ["AEmpBEmp" for i in 1:N]

for i in N:-1:1
    state[i] = (isodd(i) ? "AupBEmp" : "AEmpBdn")
end
ψ = randomMPS(sites, state, 10)

sweeps = Sweeps(20)
maxdim!(sweeps, 20, 20, 30, 30, 50, 50, 100, 100, 100)
noise!(sweeps, 1E-6, 1E-7, 1E-8, 1E-9)
cutoff!(sweeps, 1E-8)
E, ϕ = dmrg(H, ψ, sweeps)
