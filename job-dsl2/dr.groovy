// Creating folders for Lastmile Consumer Service jobs
folder('CD/Lastmile_Consumer_Service') {
    description('Folder for Lastmile Consumer Service CI jobs.')
}

// Example pipeline job for Lastmile Consumer Service
pipelineJob('CD/Lastmile_Consumer_Service/Lastmile_Consumer_Service_Extensive_CI_Pipeline') {
    logRotator {
        numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/las/lastmile2.0.git')
                        credentials('ayush_bitbucket_original')
                    }
                    branch('opstree')
                    scriptPath('lastmile-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}
