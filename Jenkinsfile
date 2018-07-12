Pipeline {
    agent any
    environment {
        containerName = "persistent-web-appr"
        container_version = "1.0.0.${BUILD_ID}"
        dockerTag = "${containerName}:${container_version}"
    }
    stages{
        stage ('Build Container') {
            steps {
                sh 'docker build -f "Dockerfile" --no-cache -t ${dockerTag} .''
            }
        }
        
    }
} 
          
