This is a small script pack that allows unconscious players using ACE to spectate players around them, as well as a lightweight system for playing animation whilst unconscious with injured sounds.


This script pack assumes that you already have a basic mission structure set up, with basic init files etc.


HOW TO USE:


************* 1. init.sqf ***************

Add this line:

JM_unconSpectator = true;




************* 2. initPlayerLocal.sqf ***************

Include my file by adding the following line to the end of the file:

#include "\JM_unconSpectator\initLocal.sqf";




************* 3. onPlayerRespawn.sqf AND onPlayerKilled.sqf ***************

These lines should go at the end of their respective files as they deal with updating units and vision modes. Placing them at the start may delay or interfere with any other functions you have running in these files. Add these lines to the end of these files respectively:

#include "\JM_unconSpectator\initRespawn.sqf";

#include "\JM_unconSpectator\initKilled.sqf";


************* 4. Description.ext ********************

Add this to your CfgSounds setup in your description.ext, if you do not have a CfgSounds setup already, look online for a template at least. This file only contains classes for the additional sounds and will break if you don't set your CfgSounds up properly:

#include "\JM_unconSpectator\UnconSounds.hpp";





EXAMPLE CFGSOUNDS:

class CfgSounds {

    sounds[] = {};

// your sound classes here!

};




