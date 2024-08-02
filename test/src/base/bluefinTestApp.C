//* This file is part of the MOOSE framework
//* https://www.mooseframework.org
//*
//* All rights reserved, see COPYRIGHT for full restrictions
//* https://github.com/idaholab/moose/blob/master/COPYRIGHT
//*
//* Licensed under LGPL 2.1, please see LICENSE for details
//* https://www.gnu.org/licenses/lgpl-2.1.html
#include "bluefinTestApp.h"
#include "bluefinApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "MooseSyntax.h"

InputParameters
bluefinTestApp::validParams()
{
  InputParameters params = bluefinApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

bluefinTestApp::bluefinTestApp(InputParameters parameters) : MooseApp(parameters)
{
  bluefinTestApp::registerAll(
      _factory, _action_factory, _syntax, getParam<bool>("allow_test_objects"));
}

bluefinTestApp::~bluefinTestApp() {}

void
bluefinTestApp::registerAll(Factory & f, ActionFactory & af, Syntax & s, bool use_test_objs)
{
  bluefinApp::registerAll(f, af, s);
  if (use_test_objs)
  {
    Registry::registerObjectsTo(f, {"bluefinTestApp"});
    Registry::registerActionsTo(af, {"bluefinTestApp"});
  }
}

void
bluefinTestApp::registerApps()
{
  registerApp(bluefinApp);
  registerApp(bluefinTestApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
// External entry point for dynamic application loading
extern "C" void
bluefinTestApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  bluefinTestApp::registerAll(f, af, s);
}
extern "C" void
bluefinTestApp__registerApps()
{
  bluefinTestApp::registerApps();
}
