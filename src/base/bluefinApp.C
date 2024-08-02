#include "bluefinApp.h"
#include "Moose.h"
#include "AppFactory.h"
#include "ModulesApp.h"
#include "MooseSyntax.h"

InputParameters
bluefinApp::validParams()
{
  InputParameters params = MooseApp::validParams();
  params.set<bool>("use_legacy_material_output") = false;
  params.set<bool>("use_legacy_initial_residual_evaluation_behavior") = false;
  return params;
}

bluefinApp::bluefinApp(InputParameters parameters) : MooseApp(parameters)
{
  bluefinApp::registerAll(_factory, _action_factory, _syntax);
}

bluefinApp::~bluefinApp() {}

void
bluefinApp::registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  ModulesApp::registerAllObjects<bluefinApp>(f, af, s);
  Registry::registerObjectsTo(f, {"bluefinApp"});
  Registry::registerActionsTo(af, {"bluefinApp"});

  /* register custom execute flags, action syntax, etc. here */
}

void
bluefinApp::registerApps()
{
  registerApp(bluefinApp);
}

/***************************************************************************************************
 *********************** Dynamic Library Entry Points - DO NOT MODIFY ******************************
 **************************************************************************************************/
extern "C" void
bluefinApp__registerAll(Factory & f, ActionFactory & af, Syntax & s)
{
  bluefinApp::registerAll(f, af, s);
}
extern "C" void
bluefinApp__registerApps()
{
  bluefinApp::registerApps();
}
