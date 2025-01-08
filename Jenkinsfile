pipeline {
    agent any
    environment {
        DOCKER_IMAGE = "obaid069/sample-app"
        AWS_EC2_USER = "ec2-user"
        AWS_EC2_IP = "your-ec2-instance-ip"
    }
    stages {
        stage('Clone Repository') {
            steps {
                git 'https://github.com/obaid069/final_paper.git'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    sh 'docker build -t paper-devops .'
                }
            }
        }
        stage('Push Docker Image') {
            steps {
                withDockerRegistry([credentialsId: 'docker-hub-credentials', url: '']) {
                    sh 'docker push obaid069/paper-devops:1.0'
                }
            }
        }
        stage('Deploy to AWS EC2') {
            steps {
                sshagent(['ec2-key-pair-id']) {
                    sh """
                    ssh -o StrictHostKeyChecking=no $AWS_EC2_USER@$AWS_EC2_IP \
                    'docker pull $DOCKER_IMAGE && docker run -d paper-devops'
                    """
                }
            }
        }
    }
}
