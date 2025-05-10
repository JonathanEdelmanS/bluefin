import CoolProp.CoolProp as CP
import numpy as np
import csv

fluid = "CO2"
T_vals = np.linspace(280, 320, 100)  # Temperature in K
P_vals = np.linspace(1e6, 30e6, 100)  # Pressure in Pa

with open("co2_tabulated_sw.csv", "w", newline="") as f:
    writer = csv.writer(f)
    writer.writerow(["pressure","temperature","density","internal_energy",
                     "enthalpy","entropy","Cp","Cv","viscosity","thermal_conductivity"])
    
    for P in P_vals:
        for T in T_vals:
            try:
                rho = CP.PropsSI("D", "T", T, "P", P, fluid)
                u = CP.PropsSI("U", "T", T, "P", P, fluid)
                h = CP.PropsSI("H", "T", T, "P", P, fluid)
                s = CP.PropsSI("S", "T", T, "P", P, fluid)
                cp = CP.PropsSI("C", "T", T, "P", P, fluid)
                cv = CP.PropsSI("O", "T", T, "P", P, fluid)
                mu = CP.PropsSI("V", "T", T, "P", P, fluid)
                k = CP.PropsSI("L", "T", T, "P", P, fluid)

                writer.writerow([P, T, rho, u, h, s, cp, cv, mu, k])
            except Exception as e:
                print(f"Failed at T={T} K, P={P} Pa: {e}")
