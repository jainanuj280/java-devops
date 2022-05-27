pipeline {
    agent any

    stages {
        stage ('Clone') {
            steps {
                git branch: 'master', url: "https://github.com/jainanuj280/java-devops.git"
            }
        }

        stage ('Artifactory configuration') {
            steps {
                rtServer (
                    id: "jfrog-artifactory",
                    url: "https://daj.jfrog.io/",
                    credentialsId: "jfrog"
                )
            }
        }

        stage ('Build Docker Image') {
            steps {
                script {
                    docker.build("daj.jfrog.io/docker-local/" + "java-docker:${BUILD_NUMBER}")
                }
            }
        }

        stage ('Push image to Artifactory') {
            steps {
                rtDockerPush(
                    serverId: "jfrog-artifactory",
                    image: "daj.jfrog.io/docker-local/" + "java-docker:${BUILD_NUMBER}",
                    // Host:
                    // On OSX: "tcp://127.0.0.1:1234"
                    // On Linux can be omitted or null
                    // host: HOST_NAME,
                    targetRepo: 'docker-local',
                    // Attach custom properties to the published artifacts:
                    // properties: 'project-name=docker1;status=stable'
                )
            }
        }

        // stage ('Publish build info') {
        //     steps {
        //         rtPublishBuildInfo (
        //             serverId: "jfrog-artifactory"
        //         )
        //     }
        // }
    }
}
