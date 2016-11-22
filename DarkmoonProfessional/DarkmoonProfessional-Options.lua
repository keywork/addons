DMPOptions = {};
DMPOptions.panel = CreateFrame( "Frame", "DMPOptions", UIParent );
-- Register in the Interface Addon Options GUI
-- Set the name for the Category for the Options Panel
DMPOptions.panel.name = "Darkmoon Professional";
-- Add the panel to the Interface Options
InterfaceOptions_AddCategory(DMPOptions.panel);
 
-- Make a child panel
-- DMPOptions.childpanel = CreateFrame( "Frame", "DMPOptionsChild", DMPOptions.panel);
-- DMPOptions.childpanel.name = "Subcategory";
-- Specify childness of this panel (this puts it under the little red [+], instead of giving it a normal AddOn category)
-- DMPOptions.childpanel.parent = DMPOptions.panel.name;
-- Add the child to the Interface Options
-- InterfaceOptions_AddCategory(DMPOptions.childpanel);
