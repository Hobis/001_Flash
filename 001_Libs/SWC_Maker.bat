@echo off
REM compc -output D:\01_Flash\000_Libs\as3\ppp.swc -source-path D:\01_Flash\000_Libs\as3\ -include-classes HB_Scope
REM compc -output D:\01_Flash\000_Libs\as3\ppp.swc -source-path D:\01_Flash\000_Libs\as3\ -include-sources dir=D:\01_Flash\000_Libs\as3\ includes="*"
REM ./mybin/mylib.swc -include-classes a.MyAssets -compiler.source-path=./src,./icons
REM D:\01_Flash\040_Flex_Sdk\bin>compc -output D:\01_Flash\000_Libs\as3\ppp.swc -include-sources D:\01_Flash\000_Libs\as3
REM D:\01_Flash\040_Flex_Sdk\bin\compc -output D:\_Test\HB_Libs.swc -include-sources D:\_Test
REM SWC Making...
..\040_Flex_Sdk\bin\compc -output D:\_Test\HB_Libs.swc -include-sources D:\_Test
PAUSE
