pipeline {
    agent any
    environment {
        containerName = "varshakumbham/persistent-web-app"
        container_version = "1.0.0.${BUILD_ID}"
        dockerTag = "${containerName}:${container_version}"
    }
    stages{
        stage ('Build Container') {
            steps {
                 sh "sudo chown root:jenkins /run/docker.sock"
                sh 'docker build -f "Dockerfile" --no-cache -t ${dockerTag} .'
                //sh 'docker build -f "Dockerfile" -t ${dockerTag} .'
                  }
             }
        stage('Docker Push') {
            // agent any
            steps {
             withCredentials([usernamePassword(credentialsId: 'dockerHub', passwordVariable: 'dockerHubPassword', usernameVariable: 'dockerHubUser')]) {
             sh "docker login -u ${env.dockerHubUser} -p ${env.dockerHubPassword}"
             sh 'docker push ${dockerTag}'
             }
        }
      }
        stage('Docker Cleanup') {
              steps {
                sh "docker images ${dockerTag} -q | tee ./xxx"
            sh 'docker rmi `cat ./xxx` --force ||exit 0'
            }
        }
        
    }
} 
         
