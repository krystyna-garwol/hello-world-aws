pipeline { 
    environment {
        registry = '0028e93734a9/hello-world'
        registryCredential = 'dockerhub'
        dockerImage = ''
    }

    agent any

    tools { nodejs 'node' }

    stages {
        stage('Build App') {
            steps {
                sh '''
                npm install
                npm run build
                '''
            }
        }
        stage('Test App') {
            steps {
                sh 'npm test'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dockerImage = docker.build registry + ":$BUILD_NUMBER"
                }
            }
        }
        stage('Deploy Image to dockerhub') {
            steps {
                script {
                    docker.withRegistry( '', registryCredential) {
                        dockerImage.push()
                        }
                }
            }
        }
        stage('Removed Unused Image') {
            steps {
                sh "docker rmi $registry:$BUILD_NUMBER" 
            }
        }  
    }
}
