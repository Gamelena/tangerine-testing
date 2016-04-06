<?php

class CrudRequestControllerTest extends Zend_Test_PHPUnit_ControllerTestCase
{

    protected $_modulesXml;
    
    public function setUp()
    {
        $this->bootstrap = $this->bootstrap = new Zend_Application(
            APPLICATION_ENV,
            $_ENV['APPLICATION_CONFIG']
        );
        $options = $this->bootstrap->getBootstrap()->getOptions();
        $_SERVER['HTTP_HOST'] = $options['zwei']['uTesting']['httpHost'];
        
        $model = new DbTable_AclModules();
        
        $select = $model->select()
            ->where("approved='1'")
            ->where("type='xml'");
        
        $this->_modulesXml = $model->fetchAll($select);
        
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
    
   
    
    public function testReadAllDojoSimpleCRUD()
    {
        $this->initUserInfo();
       
        
        foreach ($this->_modulesXml as $module) {
            $filename = Zwei_Admin_Xml::getFullPath($module->module);
            
            $xml = new Zwei_Admin_Xml($filename, null, true);
            
            if ($xml->getAttribute('type') === 'dojo-simple-crud') {
                if ($xml->getAttribute('target')) {
                    $params = array(
                        'module' => 'default',
                        'controller' => 'CrudRequest',
                        'action' => 'index'
                    );
                    
                    $subParams = array(
                        'p' => $module->module,
                        'model' => $xml->getAttribute('target'),
                        'start' => '0',
                        'count' => '25',
                        'format' => 'json'
                    );
                    
                    $queryParams = http_build_query($subParams);
                    
                    $urlParams = $this->urlizeOptions($params);
                    $url = $this->url($urlParams);
                    $this->dispatch($url . "?" . $queryParams);
                    
                    // assertions
                    $this->assertModule($urlParams['module']);
                    $this->assertController($urlParams['controller']);
                    $this->assertAction($urlParams['action']);
                }
            }
        }
    }
    
    
    /**
     * 
     */
    public function testReadAllDojoSimpleCRUDCsv()
    {
        $this->initUserInfo();
         
        
        foreach ($this->_modulesXml as $module) {
            $filename = Zwei_Admin_Xml::getFullPath($module->module);
    
            $xml = new Zwei_Admin_Xml($filename, null, true);
    
            if ($xml->getAttribute('type') === 'dojo-simple-crud') {
                
                if ($xml->getAttribute('target')) {
                    
                    $params = array(
                            'module' => 'default',
                            'controller' => 'CrudRequest',
                            'action' => 'index'
                    );
    
                    $subParams = array(
                            'p' => $module->module,
                            'model' => $xml->getAttribute('target'),
                            'start' => '0',
                            'count' => '25',
                            'format' => 'excel',
                            'excel_formatter' => 'csv'
                    );
    
                    $queryParams = http_build_query($subParams);
    
                    $urlParams = $this->urlizeOptions($params);
                    $url = $this->url($urlParams);

                    $this->dispatch($url . "?" . $queryParams);
                    // assertions
                    $this->assertModule($urlParams['module']);
                    $this->assertController($urlParams['controller']);
                    $this->assertAction($urlParams['action']);
                    

                }
            }
        }
    }
    
    public function testAllModels()
    {
        $models = [
            new AclActionsModel(), 
            new AclGroupsModel(), 
            new AclGroupsModulesActionsModel(), 
            new AclModulesModel(),
            new AclPermissionsComboModel(),
            new AclRolesModel(),
            new AclRolesModulesActionsModel(),
            new AclSessionModel(),
            new AclSessionOnlineModel(),
            new AclUsersGroupsModel(),
            new AclUsersModel(),
            new IconsModel(),
            new PersonalInfoModel(),
            new SettingsModel(),
            new TablesLoggedModel(),
        ];
        
        //Se han probado los constructores, hacer test avanzados de los modelos acá
        
    }


}



