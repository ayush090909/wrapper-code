pipelineJob('SeedJobs/Sathi_Service_SeedJob') {
    logRotator {
        numToKeep(5)  // Keep the last 5 builds for this seed job
    }

    definition {
        cps {
            script("""
pipeline {
    agent any
    stages {
        stage('Checkout Repository') {
            steps {
                git url: 'https://scm.ecomexpress.in/scm/las/lastmile2.0.git',
                    branch: 'opstree',
                    credentialsId: 'ayush_bitbucket_original'
            }
        }
        stage('Generate Jobs') {
            steps {
                jobDsl targets: 'sathi-service/*.groovy'
            }
        }
    }
    post {
        success {
            echo 'Sathi Service jobs successfully created.'
        }
        failure {
            echo 'Failed to create jobs for Sathi Service.'
        }
    }
}
            """.stripIndent())
        }
    }
}

