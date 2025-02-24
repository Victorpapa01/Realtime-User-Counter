pipeline {
    agent {
        label 'docker-agent'
    }
     environment {
        APP_NAME = "realtime-user-counter"
        CONTAINER_NAME = "active-users-app"
        APP_PORT = "5000"
    }

    stages {
        stage('Clone Repository') {
            steps {
                git branch: 'main', url: 'https://github.com/Victorpapa01/Realtime-User-Counter.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh "docker build -t ${APP_NAME}:latest ."
            }
        }

        stage('Deploy on Agent') {
            steps {
                script {
                    // Stop and remove existing container if running
                    sh """
                        if [ \$(docker ps -q -f name=${CONTAINER_NAME}) ]; then
                            docker stop ${CONTAINER_NAME}
                            docker rm ${CONTAINER_NAME}
                        fi
                    """

                    // Run new container
                    sh """
                        docker run -d --name ${CONTAINER_NAME} -p ${APP_PORT}:${APP_PORT} ${APP_NAME}:latest
                    """
                }
            }
        }

        stage('Send Slack Notification') {
            steps {
        sh '''
            curl -X POST -H "Content-type: application/json" --data '{
                "channel": "#jenkins-builds",
                "text": "Build is deployed successfully on agent node."
            }' https://hooks.slack.com/services/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
        '''
    }
        }
    }
}