pipeline {
    agent any

    environment {
        // Replace with your repository details
        NEXUS_URL = "nexus-service:8081"
        NEXUS_CREDENTIALS_ID = "nexus-auth" 
    }

    stages {
        stage('Checkout') {
            steps {
                // Pulls code from your GitHub repository 
                checkout scm
            }
        }

        stage('Build JAR') {
            steps {
                // Compiles and packages your Spring Boot app [cite: 8, 14]
                sh './mvnw clean package -DskipTests'
            }
        }

        stage('Push to Nexus') {
            steps {
                // Uploads the artifact to your Nexus server 
                script {
                    sh "curl -v -u admin:admin123 --upload-file target/*.jar http://${NEXUS_URL}/repository/maven-releases/"
                }
            }
        }
    }
}
