pipeline { 
    environment {
        AWS_ACCOUNT_ID = "104430712741"
        AWS_DEFAULT_REGION = "eu-west-1"
        IMAGE_REPO_NAME = "hello-world-aws"
        REPO_URI = "${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}"
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
                    sh "docker build -t ${IMAGE_REPO_NAME}:$BUILD_NUMBER ."
                }
            }
        }
        stage('Log into AWS ECR') {
            steps {
                script {
                    sh "aws ecr get-login-password --region ${AWS_DEFAULT_REGION} | docker login --username AWS --password-stdin ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com"
                }
            }
        }
        stage('Deploy Docker Image to AWS ECR') {
            steps {
                script {
                    sh "docker tag ${IMAGE_REPO_NAME}:$BUILD_NUMBER ${REPO_URI}:$BUILD_NUMBER"
                    sh "docker push ${AWS_ACCOUNT_ID}.dkr.ecr.${AWS_DEFAULT_REGION}.amazonaws.com/${IMAGE_REPO_NAME}:$BUILD_NUMBER"
                }
            }
        }
    }
}
