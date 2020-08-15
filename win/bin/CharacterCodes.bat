@echo off
set PLAF=com.sun.java.swing.plaf.motif.MotifLookAndFeel
set PLAF=javax.swing.plaf.nimbus.NimbusLookAndFeel
set PLAF=net.sourceforge.openlook_plaf.OpenLookLookAndFeel
start javaw -Dswing.defaultlaf=%PLAF% -jar "C:\opt\lib\CharacterCodeDisplayer.jar"

