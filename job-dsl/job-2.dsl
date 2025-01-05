// Creating folders for Lastmile Instruction Service jobs
folder('CI/Lastmile_Instruction_Service') {
    description('Folder for Lastmile Instruction Service CI jobs.')
}

// Example pipeline job for Lastmile Instruction Service
pipelineJob('CI/Lastmile_Instruction_Service/Lastmile_Instruction_Service_Extensive_CI_Pipeline') {
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
                    scriptPath('lastmile-instruction-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}
