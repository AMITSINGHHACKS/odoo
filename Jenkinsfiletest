pipeline {
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
    environment {
        SCANNER_HOME=tool 'sonar-scanner' 
    }
    stages {
        stage("Sonarqube Analysis") {
            steps {
                script {
                    withSonarQubeEnv('sonar-scanner') {
                        sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=devops \
                    -Dsonar.projectKey=devops '''
                    }
                }
            }

        }
        
    }
   
}
