pipeline {
    agent any

    environment {
        APP_NAME = "azure-web-search"
        RELEASE = "1.0.0"
        DOCKER_USER = "amitsingh01"
        DOCKER_PASS = 'dockerhub'
        IMAGE_NAME = "${DOCKER_USER}" + "/" + "${APP_NAME}"
        IMAGE_TAG = "${RELEASE}-${BUILD_NUMBER}"
        SCANNER_HOME=tool 'sonar-scanner' 
    }
    stages {
        stage("Sonarqube Analysis") {
            steps {
                script {
                    withSonarQubeEnv('sonar-scanner') {
                        sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=odootest \
                    -Dsonar.projectKey=odootest '''
                    }
                }
            }

        }
        
    }
   
}
