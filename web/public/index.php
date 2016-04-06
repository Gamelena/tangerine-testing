<?php
/**
 * Puerta de entrada a la aplicación,
 * todo requerimiento es procesado por este script en primer lugar
 *
 *
 * @version $Id:$
 * @since 0.1
 *
 */


// Define path to application directory
defined('APPLICATION_PATH')
    || define('APPLICATION_PATH', realpath(dirname(__FILE__) . '/../application'));

// Define application environment
defined('APPLICATION_ENV')
    || define('APPLICATION_ENV', (getenv('APPLICATION_ENV') ? getenv('APPLICATION_ENV') : 'production'));



    //Autoloader de Composer
if (file_exists(APPLICATION_PATH . '/../vendor/autoload.php')) {
    require_once APPLICATION_PATH . '/../vendor/autoload.php';
}
    
    
/** Zend_Application */
require_once 'Zend/Application.php';

$application = new Zend_Application(
    APPLICATION_ENV,
    APPLICATION_PATH . '/configs/application.ini'
);

/*
 * @see APPLICATION_PATH "Bootstrap.php"
*/
$application->bootstrap()
            ->run();