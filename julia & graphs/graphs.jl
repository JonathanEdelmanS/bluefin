using DataFrames, CSV, Plots


tempsgraph= plot(xscale=:log, ylabel = "Temperature", xlabel = "r^2/t", title = "Temperature Graph", legend=:bottomright)
pressuresgraph= plot(xscale=:log, ylabel = "Pressure", xlabel = "r^2/t", title = "Pressure Graph", legend=:bottomright)

name = "ideal"
for name in ["ideal","real"]
onetime =  CSV.read("../problems/theisbrinecoslidernon_iso/theis_brineco2_nonisothermal_"*name*"_out_line_0036.csv"
, comment="#", DataFrame)

onedepth = CSV.read("../problems/theisbrinecoslidernon_iso/theis_brineco2_nonisothermal_"*name*"_out.csv"
    , comment="#", DataFrame)




r = 1.8992399239924
t = 1000000

temps = onetime.temperature
pressures = onetime.pgas
depths = onetime.x
sim = depths.^2 / t


plot!(tempsgraph, sim, temps, label = "One Time (Radius varies) "*name)
plot!(pressuresgraph, sim, pressures, label = "One Time (Radius varies) " *name,)


times = onedepth.time[2:end]
temps = onedepth.temperature[2:end]
pressures = onedepth.pgas[2:end]
sim = r^2 ./ times

scatter!(tempsgraph, sim, temps, label = "One Radius (Time varies) "*name)
scatter!(pressuresgraph, sim, pressures, label = "One Radius (Time varies) "*name)
end


savefig(tempsgraph, "IdealRealSimilaritySolutionTemperature.png")
savefig(pressuresgraph,"IdealRealSimilaritySolutionPressure.png")

#=
for timestep in timesteps
    CSVread = CSV.read("1Dradial/peacock_run_exe_tmp_1Dradial_spatial_auxvars_" * timestep * ".csv"
    , comment="#", DataFrame);

    s = CSVread.saturation_gas
    r = CSVread.x

    t = times.time[parse(Int,timestep)]

    plot!(GasSatRad,r,s)
    
    sim = r.^2 / t
    plot!(GasSatSim, sim, s)

    GasMassFraction = CSVread.x1
    WaterMassFraction = CSVread.y0


    plot!(GasMassPercent, sim, GasMassFraction)
    plot!(WaterMassPercent, sim, WaterMassFraction)

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



=#