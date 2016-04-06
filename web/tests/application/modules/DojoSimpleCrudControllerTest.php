<?php

class Components_DojoSimpleCrudControllerTest extends Zend_Test_PHPUnit_ControllerTestCase
{

    public function setUp()
    {
        $this->bootstrap = $this->bootstrap = new Zend_Application(
            APPLICATION_ENV,
            $_ENV['APPLICATION_CONFIG']
        );
        $options = $this->bootstrap->getBootstrap()->getOptions();
        $_SERVER['HTTP_HOST'] = $options['zwei']['uTesting']['httpHost'];
        parent::setUp();
    }
    
    public function initUserInfo()
    {
        $this->getFrontController()->setParam('bootstrap', $this->bootstrap->getBootstrap());
        $authAdapter = Zwei_Admin_Auth::getInstance()->getAuthAdapter();
        
        $username = PHPUNIT_USERNAME;
        $password = PHPUNIT_PASSWORD;
        $auth = Zend_Auth::getInstance();
        
        $authAdapter->setIdentity($username)
            ->setCredential($password);
        $result = $auth->authenticate($authAdapter);
        
        if ($result->isValid()) {
            Zwei_Admin_Auth::initUserInfo($authAdapter);
        } else {
            echo "Usuario '$username' o Password '$password' incorrectos.";
        }
    }
    
    public function testUploadAction()
    {
        $this->initUserInfo();
        
        $params = array('action' => 'upload', 'controller' => 'DojoSimpleCrud', 'module' => 'components');
        
        $params['accion'] = 'insert';
        $params['p'] = 'abonados.xml';
        
        $urlParams = $this->urlizeOptions($params);
        
        $_FILES = array (
            'file' => array (
                'name' => 'DbTable_TestingAbonados.csv',
                'type' => 'text/csv',
                'tmp_name' => APPLICATION_PATH . '/../tests/fake-upfiles/DbTable_TestingAbonados.csv',
                'error' => 0,
                'size' => 3468
            )
        );
        
        
        $url = $this->url($urlParams);
        $this->dispatch($url);
        
        // assertions
        $this->assertModule($urlParams['module']);
        $this->assertController($urlParams['controller']);
        $this->assertAction($urlParams['action']);
    }

    public function testUploadFormAction()
    {
        $this->initUserInfo();
        
        $params = array('action' => 'uploadForm', 'controller' => 'DojoSimpleCrud', 'module' => 'components');
        $urlParams = $this->urlizeOptions($params);
        $url = $this->url($urlParams);
        
        $subParams = array(
            'action' => 'load',
            'p' => 'abonados.xml'
        );
        
        $queryParams = http_build_query($subParams);
        
        $this->dispatch($url . "?" . $queryParams);
        
        $queryParams = http_build_query($subParams);
        
        // assertions
        $this->assertModule($urlParams['module']);
        $this->assertController($urlParams['controller']);
        $this->assertAction($urlParams['action']);
    }


}



















