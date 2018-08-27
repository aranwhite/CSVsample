pipeline{
agent any
stages {
    stage('Checkout code') {
        steps {
            checkout scm
        }
    }
    stage('Build API Server') {
        steps {
            sh '/usr/local/bin/docker-compose -f docker-compose-mysql-4_1.yml up -d'
            timeout(5) {
               waitUntil {
                  script {
                     def r = sh script: 'wget -q http://34.210.71.26:8082/APICreator/#/ -O /dev/null', returnStatus: true
                     return (r == 0);
                  }
               }
           }
        }
    } 
    stage('Copy CSV to LAC') {
        steps {
            sh '/usr/bin/docker cp ./VistaChangeExport_Sample.csv csvexample_lac_1:/input.csv'
        }
    } 
    
    stage('Create API') {
        steps {
            sh 'ls -l'
            sh './deploy2.sh'
        }
    }
  
   
}
}
