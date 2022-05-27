pipeline {
    agent any

    stages {
        stage('Checkout') {
            steps {
                // Get some code from a GitHub repository
                git 'https://github.com/jainanuj280/java-devops.git'
            }
        }
        
        stage('Docker Image Build') {
            steps {
                sh "touch newfile.war"
                sh "docker build -t java-docker:${BUILD_NUMBER} ."
            }
        }

    	stage ('Server'){
                steps {
                   rtServer (
                     id: "jfrog-artifactory",
                     url: 'http://192.168.33.8:8082/artifactory',
                     username: 'jenkins',
                     password: 'Jenkins@123',
                     bypassProxy: true,
                     timeout: 300
                    )
                }
            }
            
        stage('Upload'){
            steps{
                rtUpload (
                 serverId:"jfrog-artifactory" ,
                  spec: '''{
                   "files": [
                      {
                      "pattern": "*.war",
                      "target": "java-repo"
                    }
                    ]
                   }''',
                )
            }
        }
        
        stage ('Publish build info') {
            steps {
                rtPublishBuildInfo (
                    serverId: "jfrog-artifactory"
                )
            }
        }       
    }
}

