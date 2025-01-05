// Create a folder for Ecom Sathi Service jobs
folder('CI/Sathi/Ecom_Sathi_Service') {
    description('Folder for Ecom Sathi Service CI jobs.')
}

// Create the pipeline job for Minimalist CI Pipeline
pipelineJob('CI/Sathi/Ecom_Sathi_Service/Minimalist_CI_Pipeline') {
    logRotator {
        numToKeep(5)  // Keep the last 5 builds for this job
    }

    parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/las/lastmile2.0.git') // Repository URL
                        credentials('ayush_bitbucket_original')  // Credentials ID for accessing the repository
                    }
                    branch('opstree')  // The branch to check out
                    scriptPath('ecom-sathi-service/Jenkinsfile_minimalist') // Path to Jenkinsfile in the repo
                }
            }
        }
    }
}
