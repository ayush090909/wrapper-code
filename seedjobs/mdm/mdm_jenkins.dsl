///////////////////////////////////////////Lastmile_Instruction////////////////////////////////////////////////////////////////////////

multibranchPipelineJob('CI/MDM/Lastmile_Instruction_Service_Minimalist_CI_Pipeline') {
    branchSources {
        git {
            id('my-git-source-id') // Provide a unique ID for the Git branch source
            remote('https://scm.ecomexpress.in/scm/las/lastmile2.0.git') // URL of your Git repository
            credentialsId('ayush_bitbucket_original') // Optional: Credentials ID if authentication is required
            includes('**') // Include all branches
        }
    }
    factory {
        workflowBranchProjectFactory {
            scriptPath('lastmile-instruction-service/Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
    
}

pipelineJob('CI/MDM/MDM_Instruction_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
    }

// Disable concurrent builds

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/las/lastmile2.0.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('lastmile-instruction-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CI/MDM/Lastmile_Instruction_Service_Nightly_CI_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
    }
    triggers {
        cron('H 18 * * *')  // Schedule the job to run at 12:00 AM IST (18:00 UTC)
    }
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/las/lastmile2.0.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('lastmile-instruction-service/Jenkinsfile_nightly')
                }
            }
        }
    }
}

