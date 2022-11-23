pipeline {
environment {
    //registry = "arshsahzad/dryruntest"
    //registryCredential = 'arshsahzad'
    dockerImage = ''
}
agent any
stages {
    stage('Cloning Repo...') {
    steps {
        git 'https://github.com/arshsahzad/DryRunTest.git'
    }
    }
    stage('Building the Image') {
    steps {
        script {
        dockerImage = docker.build registry + ":$BUILD_NUMBER"
        }
    }
    }
    stage ('Running the Image') {
    steps {
        sh '''
        docker run -d --name demo -p 80:82 $dockerImage 
        '''
    }
    }
}
}