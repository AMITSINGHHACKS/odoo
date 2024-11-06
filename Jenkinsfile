pipeline {
    agent any
    tools{
        jdk 'jdk17'
        nodejs 'node16'
    }
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
        stage("Sonarqube Analysis 2nd") {
            steps {
                script {
                    withSonarQubeEnv('sonar-scanner') {
                        sh ''' $SCANNER_HOME/bin/sonar-scanner -Dsonar.projectName=devops2 \
                    -Dsonar.projectKey=devops2 '''
                    }
                }
            }

        }
        stage("Build & Push Docker Image") {
            steps {
                script {
                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image = docker.build "${IMAGE_NAME}"
                    }

                    docker.withRegistry('',DOCKER_PASS) {
                        docker_image.push("${IMAGE_TAG}")
                        docker_image.push('latest')
                    }
                }
            }

        }
        stage ('Cleanup Artifacts') {
            steps {
                script {
                    sh "docker rmi ${IMAGE_NAME}:${IMAGE_TAG}"
                    sh "docker rmi ${IMAGE_NAME}:latest"
                }
            }
        }
        stage('Trigger ManifestUpdate') {
            steps {  
                echo "triggering update manifest job"
                sh "curl -v -k --user admin:${JENKINS_API_TOKEN} -X POST -H 'cache-control: no-cache' -H 'content-type: application/x-www-form-urlencoded' --data 'IMAGE_TAG=${IMAGE_TAG}' 'http://4.240.19.95:8080/job/Devops+Kube/buildWithParameters?token=gitops-token'"
            }
        }
        
    }
   
}
