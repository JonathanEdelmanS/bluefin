using DataFrames, CSV, Plots

timesteps = ["0083", "0128", "0327", "1050"]


name = "Real"

GasSatRad=plot(xlims=(0,4000), title = name)
GasSatSim=plot(xscale=:log, title = name)
GasMassPercent=plot(xscale=:log, title = name)
WaterMassPercent=plot(xscale=:log, title = name,)


times = CSV.read("../problems/1DRadial/1Dradial"*name*"_time.csv"
    , comment="#", DataFrame)

for timestep in timesteps
    CSVread = CSV.read("../problems/1DRadial/1Dradial"*name*"_spatial_auxvars_" * timestep * ".csv"
    , comment="#", DataFrame);

    s = CSVread.saturation_gas
    r = CSVread.x

    t = times.time[parse(Int,timestep)]

    plot!(GasSatRad,r,s , xlabel = "r")
    
    sim = r.^2 / t
    plot!(GasSatSim, sim, s,v, xlabel = "r^2/t")

    GasMassFraction = CSVread.x1
    WaterMassFraction = CSVread.y0


    plot!(GasMassPercent, sim, GasMassFraction, xlabel = "r^2/t")
    plot!(WaterMassPercent, sim, WaterMassFraction, xlabel = "r^2/t")

end

xT = 25.605268318889
GasMassTimes = times.x1
WaterMassTimes = times.y0

simTime = xT^2 ./ times.time[2:end]
scatter!(GasMassPercent, simTime, GasMassTimes[2:end])
scatter!(WaterMassPercent, simTime, WaterMassTimes[2:end])




savefig(GasSatRad,"GasSaturationVsR.png")
savefig(GasSatSim,"GasSaturationVsSimVar.png")
savefig(GasMassPercent,"GasMassPercent.png")
savefig(WaterMassPercent,"WaterMassPercent.png")



