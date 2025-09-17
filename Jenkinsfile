pipeline {

    agent any
 
    
    tools {
        // Ensure this matches the Git tool name configured in Jenkins Global Tool Configuration
        git 'Default'
        maven 'DefaultMaven'
    }

    environment {

        REGISTRY = "docker.io"

        REPO = "sabula/codeaws"

        IMAGE_TAG = "latest"

    }
 
    stages {

        stage('Checkout Code') {

            steps {

                git branch: 'main', url: 'https://github.com/ebby121/sample-java-app.git'


            }

        }
 
        stage('Build & Unit Tests') {

            steps {

                sh 'mvn clean compile test'

            }

        }
 
        stage('Code Quality Check - SonarQube') {

            steps {

                withSonarQubeEnv('SonarQubeServer') {

                    sh 'mvn sonar:sonar'

                }

            }

        }
 
        stage('Security Scan - Dependency Check') {

            steps {

                sh 'mvn org.owasp:dependency-check-maven:check'

            }

        }
 
        stage('Build Docker Image') {

            steps {

                sh "docker build -t $REPO:$IMAGE_TAG ."

            }

        }
 
        stage('Image Scan - Trivy') {

            steps {

                sh "trivy image --exit-code 1 --severity HIGH,CRITICAL $REPO:$IMAGE_TAG || true"

            }

        }
 
        stage('Push to DockerHub') {

            steps {

                withCredentials([usernamePassword(credentialsId: 'dockerhub-creds', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {

                    sh 'echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin'

                    sh "docker push $REPO:$IMAGE_TAG"

                }

            }

        }
 
        stage('Deploy to EC2 Docker Runtime') {

            steps {

                sshagent(['ec2-ssh-key']) {

                    sh '''

                    ssh -o StrictHostKeyChecking=no ec2-user@<EC2_PUBLIC_IP> \

                    "docker pull $REPO:$IMAGE_TAG && docker stop javaapp || true && docker rm javaapp || true && docker run -d -p 8080:8080 --name javaapp $REPO:$IMAGE_TAG"

                    '''

                }

            }

        }

    }

}

 