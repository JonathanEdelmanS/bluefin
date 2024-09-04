using DataFrames, CSV, Plots

onetime =  CSV.read("../problems/theis_brineco2_csvout_line_0028.csv"
, comment="#", DataFrame)

onedepth = CSV.read("../problems/theis_brineco2_csvout.csv"
    , comment="#", DataFrame)

#tempsgraph= plot(xscale=:log, ylabel = "Temperature", xlabel = "r^2/t", legend=:bottomright)
pressuresgraph= plot(xscale=:log10, ylabel = "Pressure", xlabel = "r^2/t", legend=:bottomright, xlims = (.00001, 10))


r = 3.8003800380038
t = 100000

#temps = onetime.temperature
pressures = onetime.pgas[2:end]
depths = onetime.x[2:end]
sim = (depths.^2 / t)


#plot!(tempsgraph, sim, temps, label = "One Time (Depth varies)")
plot!(pressuresgraph, sim, pressures, label = "One Time (Depth varies)",)


times = onedepth.time[2:end]
#temps = onedepth.temperature[2:end]
pressures = onedepth.pgas[2:end]
sim = r^2 ./ times

#scatter!(tempsgraph, sim, temps, label = "One Depth (Time varies)")
scatter!(pressuresgraph, sim, pressures, label = "One Depth (Time varies)")


#savefig(tempsgraph, "SimilaritySolutionTemperature.png")
savefig(pressuresgraph, "IsoThermalSimilaritySolutionPressure.png")
