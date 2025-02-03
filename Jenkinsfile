pipeline {
    agent any
    stages {
        stage('Checkout Repository') {
            steps {
                // Clone the Git repository containing the Job DSL scripts
                git url: 'https://github.com/ayush090909/wrapper-code.git', branch: 'main'
            }
        }
        stage('Run DSL Scripts') {
            steps {
                // Use the Job DSL plugin to process all Groovy scripts in the directory
                jobDsl targets: 'seedjobs/**/**/*.dsl', ignoreExisting: true
            }
        }
    }
    post {
        success {
            echo "All Job DSL scripts executed successfully."
        }
        failure {
            echo "Failed to execute Job DSL scripts."
        }
    }
}
