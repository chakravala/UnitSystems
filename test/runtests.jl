using UnitSystems, Test

for S ∈ UnitSystems.Systems
    U = eval(S)
    S ∉ (:MetricTurn,:MetricSpatian,:MetricGradian,:MetricDegree,:MetricArcminute,:MetricArcsecond) && @testset "UnitSystem: $S" begin
        S≠:FFF && @testset "Dimensionless constants" begin
            @test μₑᵤ ≈ electronmass(U)/dalton(U)
            @test μₚᵤ ≈ protonmass(U)/dalton(U)
            @test μₚₑ ≈ protonmass(U)/electronmass(U)
            @test 1/αinv ≈ (elementarycharge(U)/charge(PlanckGauss,U))^2
            @test αG ≈ (electronmass(U)/mass(PlanckGauss,U))^2
            @test 1/αinv ≈ elementarycharge(U)^2*rationalization(U)/4π/vacuumpermittivity(U)/planckreduced(U)/lightspeed(U)
            @test 1/αinv ≈ vacuumpermeability(U)*lightspeed(U)*(elementarycharge(U)*lorentz(U))^2*rationalization(U)/4π/planckreduced(U)
            @test 1/αinv ≈ electrostatic(U)*elementarycharge(U)^2/planckreduced(U)/lightspeed(U)
            @test 1/αinv ≈ elementarycharge(U)^2*rationalization(U)/2vacuumpermittivity(U)/lightspeed(U)/planck(U)
            @test 1/αinv ≈ lightspeed(U)*vacuumpermeability(U)*rationalization(U)*lorentz(U)^2/2klitzing(U)
            @test 1/αinv ≈ elementarycharge(U)^2*vacuumimpedance(U)/2planck(U)
        end
        @testset "Fundamental constants" begin
            @testset "lightspeed" begin
                S≠:FFF && @test lightspeed(U) ≈ 1/lorentz(U)/sqrt(vacuumpermeability(U)*vacuumpermittivity(U))
                @test lightspeed(U) ≈ αinv*sqrt(hartree(U)*gravity(U)/electronmass(U))
                @test lightspeed(U) ≈ planckreduced(U)/αinv/electronmass(U)/electronradius(U)*gravity(U)
                S≠:FFF && @test lightspeed(U) ≈ elementarycharge(U)^2*electrostatic(U)/planckreduced(U)*αinv
                @test lightspeed(U) ≈ electronmass(U)^2*gravitation(U)/planckreduced(U)/αG
            end
            S≠:FFF && @testset "planck" begin
                @test planck(U) == turn(U)*planckreduced(U)
                @test planck(U) ≈ 2elementarycharge(U)*lorentz(U)/josephson(U)
                @test planck(U) ≈ 8/αinv/rationalization(U)/lightspeed(U)/vacuumpermeability(U)/josephson(U)^2
                @test planck(U) ≈ 4lorentz(U)^2/josephson(U)^2/klitzing(U)
            end
            @testset "planckmass" begin
                @test planckmass(U) ≈ sqrt(planckreduced(U)*lightspeed(U)/gravitation(U))
                @test planckmass(U) ≈ electronmass(U)/sqrt(αG)
                @test planckmass(U) ≈ 2rydberg(U)*planck(U)/lightspeed(U)*αinv^2/sqrt(αG)*gravity(U)
            end
            @testset "gravitation" begin
                @test gravitation(U) ≈ planckreduced(U)*lightspeed(U)/planckmass(U)^2
                @test gravitation(U) ≈ planckreduced(U)*lightspeed(U)*αG/electronmass(U)^2
                @test gravitation(U) ≈ lightspeed(U)^3/αinv^4*αG/8π/rydberg(U)^2/planck(U)/gravity(U)^2
                @test gravitation(U) ≈ einstein(U)*lightspeed(U)^4/8π
            end
            @testset "einstein" begin
                @test einstein(U) ≈ 8π*gravitation(U)/lightspeed(U)^4
                @test einstein(U) ≈ 8π*planckreduced(U)/lightspeed(U)^3/planckmass(U)^2
                @test einstein(U) ≈ 8π*planckreduced(U)*αG/lightspeed(U)^3/electronmass(U)^2
                @test einstein(U) ≈ αG/αinv^4/rydberg(U)^2/planck(U)/lightspeed(U)/gravity(U)^2
            end
        end
        @testset "Atomic constants" begin
            @testset "dalton" begin
                @test dalton(U) ≈ molarmass(U)/avogadro(U)
                @test dalton(U) ≈ electronmass(U)/μₑᵤ
                @test dalton(U) ≈ protonmass(U)/μₚᵤ
                @test dalton(U) ≈ 2rydberg(U)*planck(U)/μₑᵤ/lightspeed(U)*αinv^2*gravity(U)
                @test dalton(U) ≈ planckmass(U)*sqrt(αG)/μₑᵤ
            end
            @testset "protonmass" begin
                @test protonmass(U) ≈ μₚᵤ*dalton(U)
                @test protonmass(U) ≈ μₚᵤ*molarmass(U)/avogadro(U)
                @test protonmass(U) ≈ μₚₑ*electronmass(U)
                @test protonmass(U) ≈ μₚₑ*2rydberg(U)*planck(U)/lightspeed(U)*αinv^2*gravity(U)
                @test protonmass(U) ≈ planckmass(U)*μₚₑ*sqrt(αG)
            end
            @testset "electronmass" begin
                @test electronmass(U) ≈ μₑᵤ*dalton(U)
                @test electronmass(U) ≈ μₑᵤ*molarmass(U)/avogadro(U)
                @test electronmass(U) ≈ protonmass(U)/μₚₑ
                @test electronmass(U) ≈ 2rydberg(U)*planck(U)/lightspeed(U)*αinv^2*gravity(U)
                @test electronmass(U) ≈ planckmass(U)*sqrt(αG)
            end
            @testset "hartree" begin
                @test hartree(U) ≈ electronmass(U)/gravity(U)*(lightspeed(U)/αinv)^2
                @test hartree(U) ≈ planckreduced(U)*lightspeed(U)/αinv/bohr(U)
                @test hartree(U) ≈ planckreduced(U)^2/electronmass(U)/bohr(U)^2*gravity(U)
                @test hartree(U) ≈ 2rydberg(U)*planck(U)*lightspeed(U)
                @test hartree(U) ≈ planckmass(U)*sqrt(αG)*(lightspeed(U)/αinv)^2/gravity(U)
            end
            @testset "rydberg" begin
                @test rydberg(U) ≈ hartree(U)/2planck(U)/lightspeed(U)
                @test rydberg(U) ≈ electronmass(U)*lightspeed(U)/αinv^2/2planck(U)/gravity(U)
                @test rydberg(U) ≈ 1/αinv/4π/bohr(U)
                @test rydberg(U) ≈ electronmass(U)*electronradius(U)*lightspeed(U)/2planck(U)/bohr(U)/gravity(U)
                @test rydberg(U) ≈ electronmass(U)*lightspeed(U)/αinv^2/4π/planckreduced(U)/gravity(U)
                @test rydberg(U) ≈ planckmass(U)*lightspeed(U)*sqrt(αG)/αinv^2/2planck(U)/gravity(U)
            end
            @testset "bohr" begin
                @test bohr(U) ≈ planckreduced(U)/electronmass(U)/lightspeed(U)*αinv*gravity(U)
                S≠:FFF && @test bohr(U) ≈ planckreduced(U)^2/electrostatic(U)/electronmass(U)/elementarycharge(U)^2*gravity(U)
                @test bohr(U) ≈ electronradius(U)*αinv^2
                @test bohr(U) ≈ 1/αinv/4π/rydberg(U)
            end
            @testset "electronradius" begin
                @test electronradius(U) ≈ planckreduced(U)/αinv/electronmass(U)/lightspeed(U)*gravity(U)
                @test electronradius(U) ≈ bohr(U)/αinv^2
                S≠:FFF && @test electronradius(U) ≈ elementarycharge(U)^2*electrostatic(U)/electronmass(U)/lightspeed(U)^2*gravity(U)
                @test electronradius(U) ≈ 2planck(U)*rydberg(U)*bohr(U)/electronmass(U)/lightspeed(U)*gravity(U)
                @test electronradius(U) ≈ 1/αinv^3/4π/rydberg(U)
            end
        end
        @testset "Thermodynamic constants" begin
            @testset "molarmass" begin
                @test molarmass(U) ≈ dalton(U)*avogadro(U)
                @test molarmass(U) ≈ avogadro(U)*electronmass(U)/μₑᵤ
                @test molarmass(U) ≈ avogadro(U)*protonmass(U)/μₚᵤ
                @test molarmass(U) ≈ avogadro(U)*2rydberg(U)*planck(U)/μₑᵤ/lightspeed(U)*αinv^2*gravity(U)
            end
            @testset "avogadro" begin
                @test avogadro(U) ≈ molargas(U)/boltzmann(U)
                @test avogadro(U) ≈ molarmass(U)/dalton(U)
                @test avogadro(U) ≈ molarmass(U)*μₑᵤ/electronmass(U)
                @test avogadro(U) ≈ molarmass(U)*μₑᵤ*lightspeed(U)/αinv^2/2rydberg(U)/planck(U)/gravity(U)
            end
            @testset "boltzmann" begin
                @test boltzmann(U) == molargas(U)/avogadro(U)
                @test boltzmann(U) ≈ dalton(U)*universal(U)/molarmass(U)
                @test boltzmann(U) ≈ electronmass(U)*universal(U)/μₑᵤ/molarmass(U)
                @test boltzmann(U) ≈ 2molargas(U)*rydberg(U)*planck(U)/molarmass(U)/μₑᵤ/lightspeed(U)*αinv^2*gravity(U)
            end
            @testset "molargas" begin
                @test molargas(U) == boltzmann(U)*avogadro(U)
                @test molargas(U) ≈ boltzmann(U)*molarmass(U)/dalton(U)
                @test molargas(U) ≈ boltzmann(U)*molarmass(U)*μₑᵤ/electronmass(U)
                @test molargas(U) ≈ boltzmann(U)*molarmass(U)*μₑᵤ*lightspeed(U)/αinv^2/2planck(U)/rydberg(U)/gravity(U)
            end
            S≠:Cosmological && @testset "stefan" begin
                @test stefan(U) ≈ 2π^5*boltzmann(U)^4/15planck(U)^3/lightspeed(U)^2
                @test stefan(U) ≈ π^2*boltzmann(U)^4/60planckreduced(U)^3/lightspeed(U)^2
                @test stefan(U) ≈ 32π^5*planck(U)/15lightspeed(U)^6*αinv^8*(molargas(U)*rydberg(U)/μₑᵤ/molarmass(U)*gravity(U))^4
            end
            S≠:Cosmological && @testset "radiationdensity" begin
                @test radiationdensity(U) ≈ 4stefan(U)/lightspeed(U)
                @test radiationdensity(U) ≈ 8π^5*boltzmann(U)^4/15planck(U)^3/lightspeed(U)^3
                @test radiationdensity(U) ≈ π^2*boltzmann(U)^4/15planckreduced(U)^3/lightspeed(U)^3
                @test radiationdensity(U) ≈ 2^7*π^5*planck(U)/15lightspeed(U)^7*αinv^8*(molargas(U)*rydberg(U)/μₑᵤ/molarmass(U)*gravity(U))^4
            end
        end
        S≠:FFF && @testset "Electromagnetic constants" begin
            @testset "rationalization" begin
                @test rationalization(U) ≈ 4π*biotsavart(U)/vacuumpermeability(U)/lorentz(U)
                @test rationalization(U) ≈ 4π*electrostatic(U)*vacuumpermittivity(U)
                @test rationalization(U) ≈ vacuumimpedance(U)*vacuumpermittivity(U)*lightspeed(U)
            end
            @testset "vacuumpermeability" begin
                @test vacuumpermeability(U) ≈ 1/vacuumpermittivity(U)/(lightspeed(U)*lorentz(U))^2
                @test vacuumpermeability(U) ≈ 4π*electrostatic(U)/rationalization(U)/(lightspeed(U)*lorentz(U))^2
                @test vacuumpermeability(U) ≈ 2planck(U)/αinv/rationalization(U)/lightspeed(U)/(elementarycharge(U)*lorentz(U))^2
                @test vacuumpermeability(U) ≈ 2klitzing(U)/αinv/rationalization(U)/lightspeed(U)/lorentz(U)^2
            end
            @testset "vacuumpermittivity" begin
                @test vacuumpermittivity(U) ≈ 1/vacuumpermeability(U)/(lightspeed(U)*lorentz(U))^2
                @test vacuumpermittivity(U) ≈ rationalization(U)/4π/electrostatic(U)
                @test vacuumpermittivity(U) ≈ rationalization(U)*elementarycharge(U)^2*αinv/2planck(U)/lightspeed(U)
                @test vacuumpermittivity(U) ≈ rationalization(U)/2klitzing(U)/lightspeed(U)*αinv
            end
            @testset "electrostatic" begin
                @test electrostatic(U) ≈ rationalization(U)/4π/vacuumpermittivity(U)
                @test electrostatic(U) ≈ vacuumpermeability(U)*rationalization(U)*(lorentz(U)*lightspeed(U))^2/4π
                @test electrostatic(U) ≈ planckreduced(U)*lightspeed(U)/αinv/elementarycharge(U)^2
                @test electrostatic(U) ≈ klitzing(U)*lightspeed(U)/αinv/2π
                @test electrostatic(U) ≈ biotsavart(U)/lorentz(U)/vacuumpermeability(U)/vacuumpermittivity(U)
                @test electrostatic(U) ≈ magnetostatic(U)*lightspeed(U)^2
            end
            @testset "magnetostatic" begin
                @test magnetostatic(U) == lorentz(U)*biotsavart(U)
                @test magnetostatic(U) ≈ vacuumpermeability(U)*lorentz(U)^2*rationalization(U)/4π
                @test magnetostatic(U) ≈ electrostatic(U)/lightspeed(U)^2
                @test magnetostatic(U) ≈ planckreduced(U)/αinv/lightspeed(U)/elementarycharge(U)^2
                @test magnetostatic(U) ≈ klitzing(U)/αinv/2π/lightspeed(U)
            end
            @testset "lorentz" begin
                @test lorentz(U) ≈ 1/lightspeed(U)/sqrt(vacuumpermeability(U)*vacuumpermittivity(U))
                @test lorentz(U) ≈ biotsavart(U)/vacuumpermeability(U)/vacuumpermittivity(U)/electrostatic(U)
                @test lorentz(U) ≈ 4π*biotsavart(U)/rationalization(U)/vacuumpermeability(U)
                @test lorentz(U) == magnetostatic(U)/biotsavart(U)
            end
            @testset "biotsavart" begin
                @test biotsavart(U) ≈ vacuumpermeability(U)*lorentz(U)*rationalization(U)/4π
                @test biotsavart(U) ≈ lorentz(U)*vacuumpermeability(U)*vacuumpermittivity(U)*electrostatic(U)
                @test biotsavart(U) == magnetostatic(U)/lorentz(U)
                @test biotsavart(U) ≈ electrostatic(U)*sqrt(vacuumpermeability(U)*vacuumpermittivity(U))/lightspeed(U)
            end
            @testset "elementarycharge" begin
                @test elementarycharge(U) ≈ sqrt(2planck(U)/αinv/vacuumimpedance(U))
                @test elementarycharge(U) ≈ 2lorentz(U)/josephson(U)/klitzing(U)
                @test elementarycharge(U) ≈ sqrt(planck(U)/klitzing(U))
                @test elementarycharge(U) ≈ planck(U)*josephson(U)/2lorentz(U)
                @test elementarycharge(U) ≈ faraday(U)/avogadro(U)
            end
            @testset "faraday" begin
                @test faraday(U) == elementarycharge(U)*avogadro(U)
                @test faraday(U) ≈ avogadro(U)*sqrt(2planck(U)/αinv/vacuumimpedance(U))
                @test faraday(U) ≈ 2avogadro(U)*lorentz(U)/josephson(U)/klitzing(U)
                @test faraday(U) ≈ avogadro(U)*sqrt(planck(U)/klitzing(U))
                @test faraday(U) ≈ planck(U)*josephson(U)*avogadro(U)/2lorentz(U)
            end
            @testset "vacuumimpedance" begin
                @test vacuumimpedance(U) ≈ vacuumpermeability(U)*rationalization(U)*lightspeed(U)*lorentz(U)^2
                @test vacuumimpedance(U) ≈ rationalization(U)/vacuumpermittivity(U)/lightspeed(U)
                @test vacuumimpedance(U) ≈ rationalization(U)*lorentz(U)*sqrt(vacuumpermeability(U)/vacuumpermittivity(U))
                @test vacuumimpedance(U) ≈ 2planck(U)/αinv/elementarycharge(U)^2
                @test vacuumimpedance(U) ≈ 2klitzing(U)/αinv
            end
            @testset "conductancequantum" begin
                @test conductancequantum(U) ≈ 2elementarycharge(U)^2/planck(U)
                @test conductancequantum(U) ≈ 4/αinv/vacuumimpedance(U)
                @test conductancequantum(U) ≈ 2/klitzing(U)
                @test conductancequantum(U) ≈ planck(U)*josephson(U)^2/2lorentz(U)^2
                @test conductancequantum(U) ≈ 2faraday(U)^2/planck(U)/avogadro(U)^2
            end
            @testset "klitzing" begin
                @test klitzing(U) == planck(U)/elementarycharge(U)^2
                @test klitzing(U) ≈ vacuumimpedance(U)*αinv/2
                @test klitzing(U) ≈ 2/conductancequantum(U)
                @test klitzing(U) ≈ 4lorentz(U)^2/planck(U)/josephson(U)^2
                @test klitzing(U) ≈ planck(U)*avogadro(U)^2/faraday(U)^2
            end
            @testset "josephson" begin
                @test josephson(U) ≈ 2elementarycharge(U)*lorentz(U)/planck(U)
                @test josephson(U) ≈ lorentz(U)*sqrt(8/αinv/planck(U)/vacuumimpedance(U))
                @test josephson(U) ≈ lorentz(U)*sqrt(4/planck(U)/klitzing(U))
                @test josephson(U) ≈ 1/magneticfluxquantum(U)
                @test josephson(U) ≈ 2faraday(U)*lorentz(U)/planck(U)/avogadro(U)
            end
            @testset "magneticfluxquantum" begin
                @test magneticfluxquantum(U) ≈ planck(U)/2elementarycharge(U)/lorentz(U)
                @test magneticfluxquantum(U) ≈ sqrt(planck(U)*vacuumimpedance(U)*αinv/8)/lorentz(U)
                @test magneticfluxquantum(U) ≈ sqrt(planck(U)*klitzing(U)/4)/lorentz(U)
                @test magneticfluxquantum(U) == 1/josephson(U)
                @test magneticfluxquantum(U) ≈ planck(U)*avogadro(U)/2faraday(U)/lorentz(U)
            end
            @testset "magneton" begin
                @test magneton(U) ≈ elementarycharge(U)*planckreduced(U)*lorentz(U)/2electronmass(U)
                @test magneton(U) ≈ planckreduced(U)*lorentz(U)^2/electronmass(U)/josephson(U)/klitzing(U)
                @test magneton(U) ≈ planck(U)^2*josephson(U)/8π/electronmass(U)
                @test magneton(U) ≈ lorentz(U)*planckreduced(U)*faraday(U)/2electronmass(U)/avogadro(U)
                @test magneton(U) ≈ elementarycharge(U)*lightspeed(U)*lorentz(U)/αinv^2/8π/rydberg(U)/gravity(U)
            end
        end
    end
end

@testset "CGS conversions" begin
    @test molarmass(Natural) == molarmass(CGS) == 1000molarmass(Metric)

    C = 100𝘤

    @test charge(Metric,ESU) ≈ C/10
    @test charge(Metric,EMU) ≈ 1/10
    @test charge(Metric,Gauss) ≈ C/10

    @test current(Metric,ESU) ≈ C/10
    @test current(Metric,EMU) ≈ 1/10
    @test current(Metric,Gauss) ≈ C/10

    @test electricpotential(Metric,ESU) ≈ 1e8/C
    @test electricpotential(Metric,EMU) ≈ 1e8
    @test electricpotential(Metric,Gauss) ≈ 1e8/C

    @test electricfield(Metric,ESU) ≈ 1e6/C
    @test electricfield(Metric,EMU) ≈ 1e6
    @test electricfield(Metric,Gauss) ≈ 1e6/C

    @test electricdisplacement(Metric,ESU) ≈ 4π*C/1e5
    @test electricdisplacement(Metric,EMU) ≈ 4π/1e5
    @test electricdisplacement(Metric,Gauss) ≈ 4π*C/1e5

    @test electricdipolemoment(Metric,ESU) ≈ 10C
    @test electricdipolemoment(Metric,EMU) ≈ 10
    @test electricdipolemoment(Metric,Gauss) ≈ 10C

    @test magneticdipolemoment(Metric,ESU) ≈ 1e3*C
    @test magneticdipolemoment(Metric,EMU) ≈ 1e3
    @test magneticdipolemoment(Metric,Gauss) ≈ 1e3

    @test magneticfield(Metric,ESU) ≈ 4π*C/1e3
    @test magneticfield(Metric,EMU) ≈ 4π/1e3
    @test magneticfield(Metric,Gauss) ≈ 4π/1e3

    @test magneticfluxdensity(Metric,ESU) ≈ 1e4/C
    @test magneticfluxdensity(Metric,EMU) ≈ 1e4
    @test magneticfluxdensity(Metric,Gauss) ≈ 1e4

    @test magneticflux(Metric,ESU) ≈ 1e8/C
    @test magneticflux(Metric,EMU) ≈ 1e8
    @test magneticflux(Metric,Gauss) ≈ 1e8

    @test resistance(Metric,ESU) ≈ 1e9/C^2
    @test resistance(Metric,EMU) ≈ 1e9
    @test resistance(Metric,Gauss) ≈ 1e9/C^2

    @test resistivity(Metric,ESU) ≈ 1e11/C^2
    @test resistivity(Metric,EMU) ≈ 1e11
    @test resistivity(Metric,Gauss) ≈ 1e11/C^2

    @test capacitance(Metric,ESU) ≈ C^2/1e9
    @test capacitance(Metric,EMU) ≈ 1e-9
    @test capacitance(Metric,Gauss) ≈ C^2/1e9

    @test inductance(Metric,ESU) ≈ 1e9/C^2
    @test inductance(Metric,EMU) ≈ 1e9
    @test inductance(Metric,Gauss) ≈ 1e9/C^2

    # extra

    @test conductance(Metric,ESU) ≈ C^2/1e9
    @test conductance(Metric,EMU) ≈ 1e-9
    @test conductance(Metric,Gauss) ≈ C^2/1e9

    @test chargedensity(Metric,ESU) ≈ C/1e7
    @test chargedensity(Metric,EMU) ≈ 1e-7
    @test chargedensity(Metric,Gauss) ≈ C/1e7

    @test magneticpotential(Metric,ESU) ≈ 4π/10*C
    @test magneticpotential(Metric,EMU) ≈ 4π/10
    @test magneticpotential(Metric,Gauss) ≈ 4π/10

    @test susceptibility(Metric,ESU) ≈ 1/4π
    @test susceptibility(Metric,EMU) ≈ 1/4π
    @test susceptibility(Metric,Gauss) ≈ 1/4π

    # magnetisation ?

    #@test magneticpolarization(Metric,ESU) ≈ 1e2/4π/𝘤
    #@test magneticpolarization(Metric,EMU) ≈ 1e4/4π
    #@test magneticpolarization(Metric,Gauss) ≈ 1e4/4π

    @test polestrength(Metric,ESU) ≈ 10C
    @test polestrength(Metric,EMU) ≈ 10
    @test polestrength(Metric,Gauss) ≈ 10

    #@test reluctance(Metric,ESU) ≈ 4π/1e9 ?N/A?
    @test reluctance(Metric,EMU) ≈ 4π/1e9
    @test reluctance(Metric,Gauss) ≈ 4π/1e9

    # other

    @test currentdensity(Metric,ESU) ≈ C/1e5
    @test currentdensity(Metric,EMU) ≈ 1e-5
    @test currentdensity(Metric,Gauss) ≈ C/1e5

    @test permittivity(ESU,Metric) ≈ ε₀
    @test permeability(EMU,Metric) ≈ μ₀
    @test permeability(Gauss,Metric) ≈ μ₀

    @test specificsusceptibility(ESU,Metric) ≈ 4π/1e3
    @test specificsusceptibility(EMU,Metric) ≈ 4π/1e3
    @test specificsusceptibility(Gauss,Metric) ≈ 4π/1e3

    @test demagnetizingfactor(ESU,Metric) ≈ 1/4π
    @test demagnetizingfactor(EMU,Metric) ≈ 1/4π
    @test demagnetizingfactor(Gauss,Metric) ≈ 1/4π

    @test electricpolarizability(Metric,EMU) ≈ 1e-5 # ??
    @test electricpolarizability(Metric,ESU) ≈ 1e6/4π/ε₀
    @test electricpolarizability(Metric,Gauss) ≈ 1e6/4π/ε₀

    @test magneticpolarizability(Metric,ESU) ≈ 1e6/4π
    @test magneticpolarizability(Metric,EMU) ≈ 1e6/4π
    @test magneticpolarizability(Metric,Gauss) ≈ 1e6/4π

    # uncertain:
    @test electricflux(Metric,ESU) ≈ 1e10/C
    @test electricflux(Metric,EMU) ≈ 1e10
    @test electricflux(Metric,Gauss) ≈ 1e10/C
    @test magneticmoment(Metric,ESU) ≈ 1e10/C # prefer: 10/𝘤
    @test magneticmoment(Metric,EMU) ≈ 1e10 # prefer: 1e3
    @test magneticmoment(Metric,Gauss) ≈ 1e10 # prefer: 1e3
    @test specificmagnetization(ESU,Metric) ≈ 1e7/C # prefer: 1
    @test specificmagnetization(EMU,Metric) ≈ 1e7 # prefer: 1
    @test specificmagnetization(Gauss,Metric) ≈ 1e7 # prefer: 1
end
