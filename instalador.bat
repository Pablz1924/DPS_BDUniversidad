echo Instalador de la BDUniversidad
echo Autor: Peña Tejada, Pabel Sebastian
echo 10/08/2022
sqlcmd -S. -E -i BDUniversidad.sql
sqlcmd -S. -E -i BDUniversidadPA.sql
echo Se ejecuto correctamente la BD
pause