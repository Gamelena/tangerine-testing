#bin/bash

CURRENT_PATH=$PWD

COMPOSER_EXEC=$(which composer)
if [ ! -x "$COMPOSER_EXEC" ];
then
        if [ ! -f /tmp/composer.phar ];
        then
                cd /tmp
                curl -sS https://getcomposer.org/installer | php --
                if [ ! -f /tmp/composer.phar ];
                then
                        echo "No se pudo obtener composer!!!!!!"
                        exit 255;
                fi;
                COMPOSER_EXEC=/tmp/composer.sh
        fi
fi

BOWER_EXEC=$(which bower)
if [ ! -x "$BOWER_EXEC" ];
then
        npm install bower -g
        if [ ! -f /usr/bin/bower ];
        then
                echo "No se pudo instalar bower!!!!!!"
                exit 255;
        fi;
fi

if [ -z "$USSDPATH" ];
then
	export USSDPATH="/var/www/ussd-arboles-canvas"
        echo "No esta definida la variable ( USSDPATH ), usando $USSDPATH para generar la documentación post-instalación."
fi

COMPOSER_OPT="--no-dev"
if [ "$1" = "--dev" ];
then
	COMPOSER_OPT=""
fi

$COMPOSER_EXEC install $COMPOSER_OPT
$COMPOSER_EXEC  update $COMPOSER_OPT
$BOWER_EXEC install 
$BOWER_EXEC update 

npm install && npm run dist

if [ ! -f bower_components/qTip2/dist/jquery.qtip.min.js ];
then
	cd bower_components/qTip2/
	npm install
	npm run build
	cd -
fi

echo "Aplicando parches de components"
patch -p 2 -N --dry-run --silent < bower_components/editor-diagrama/patches/navigator/navigator.patch >> /dev/null
if [ $? -eq 0 ];
then
	#apply the patch
	patch -p 2 < bower_components/editor-diagrama/patches/navigator/navigator.patch
else
	echo "Navigator patch ya aplicado"
fi
patch -p 2 -N --dry-run --silent < bower_components/editor-diagrama/patches/panzoom/panzoom.patch >> /dev/null
if [ $? -eq 0 ];
then
    #apply the patch
    patch -p 2 < bower_components/editor-diagrama/patches/panzoom/panzoom.patch
else
	echo "Panzoom patch ya aplicado"
fi
patch -p 2 -N --dry-run --silent < bower_components/editor-diagrama/patches/cxtmenu/cxt.patch >> /dev/null
if [ $? -eq 0 ];
then
    #apply the patch
    patch -p 2 < bower_components/editor-diagrama/patches/cxtmenu/cxt.patch
else
	echo "CXT patch ya aplicado"
fi

cd $CURRENT_PATH

chmod a+w cache*
chmod a+w log
chmod a+w -R public/upfiles
chmod a+w -R upfiles
tar zcf ../gamelena-gw-ussd-dev-arboles-canvas-web.tar.gz .



echo "\
En el \$HOME del usuario apache debe exitir la carpeta .ssh, en la cual debe estar la llave provida, con la
cual el usuario pueda ingresar al repositorio git. Ademas en el mismo directorio, en el archivo config agregar:

			Host gitserver
			        Hostname gitserver
			        IdentityFile ~/.ssh/llaveGit

donde gitserver es un host valido.

"
echo "===================================================================================="
echo "Se generó ../gamelena-gw-ussd*.tar.gz, PARA INSTALAR EJECUTE LOS SIGUIENTES COMANDOS:"
echo "------------------------------------------------------------------------------------"
echo "mkdir -p $USSDPATH
tar zxf ../gamelena-gw-ussd*.tar.gz* -pC $USSDPATH"
echo "===================================================================================="
echo " "
echo "----------------------------------------------------------------------------------"
echo "Considere estos ejemplos de alias de apache"
echo "\(La ruta \"$USSDPATH\" aplica sólo si fueron ejecutados los COMANDOS del recuadro anterior\)"
echo "----------------------------------------------------------------------------------"
echo " "
echo "Crear archivo /etc/apache2/alias/ussd-arboles-canvas.conf o /etc/httpd/alias/ussd-arboles-canvas.conf con el contenido:"
echo " "
echo "\
Alias /ussd-arboles-canvas \"$USSDPATH/public\"
<Directory \"$USSDPATH/public\">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        #Allow from all
        DirectoryIndex index.html index.php
        #LogLevel alert rewrite:trace3       
        SetEnv APPLICATION_ENV demo
</Directory>

Alias /ussd-components \"$USSDPATH/bower_components\"
<Directory \"$USSDPATH/bower_components\">
        Options Indexes FollowSymLinks
        AllowOverride All
        Require all granted
        #Allow from all
        DirectoryIndex index.html index.php
        #LogLevel alert rewrite:trace3       
</Directory>
"
