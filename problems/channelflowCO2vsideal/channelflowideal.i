T_in = 300. # K
m_dot_in = 1e-2 # kg/s
press = 10e5 # Pa


[GlobalParams]
rdg_slope_reconstruction = full
initial_p = ${press}
initial_vel = 0.0001
initial_T = ${T_in}
closures = thm_closures
fp = co2
[]

[Components]
  [core_chan]
    type = FlowChannel1Phase
    position = '0 0 0'
    orientation = '0 0 1'
    length = 1
    n_elems = 25
    A = 7.2548e-3
    D_h = 7.0636e-2
    []
  
  [inlet]
    type = InletMassFlowRateTemperature1Phase
    input = 'core_chan:in'
    m_dot = ${m_dot_in}
    T = ${T_in}
    []
  [outlet]
    type = Outlet1Phase
    input = 'core_chan:out'
    p = ${press}
  []
[]

[FluidProperties]
  [co2]
    type = IdealGasFluidProperties
    molar_mass = 44.01e-3
    gamma = 1.3
    k = 0.2556
    mu = 3.22639e-5
  []
[]

[Closures]
  [thm_closures]
    type = Closures1PhaseTHM
  []
[]



[Postprocessors]
  [core_p_in]
    type = SideAverageValue
    boundary = core_chan:in
    variable = p
  []
[]

[Postprocessors]
  [core_p_out]
    type = SideAverageValue
    boundary = core_chan:out
    variable = p
  []
[]

[Postprocessors]
  [core_delta_p]
    type = ParsedPostprocessor
    pp_names = 'core_p_in core_p_out'
    expression = 'core_p_in - core_p_out'
  []
[]

[Executioner]
  type = Transient
  solve_type = NEWTON
  line_search = basic

  start_time = 0
  end_time = 1000
  dt = 10

  petsc_options_iname = '-pc_type'
  petsc_options_value = 'lu'

  nl_rel_tol = 1e-8
  nl_abs_tol = 1e-8
  nl_max_its = 25
[]

[Outputs]
  exodus = true
  csv = true

  [console]
    type = Console
    max_rows = 1
    outlier_variable_norms = false
  []
  print_linear_residuals = false
[]