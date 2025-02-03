// Job DSL script to create folders for Lastmile

def folderNames = ['CI/MDM','CI/AYUSH','CI/CP','CI/Lastmile_Consumer_Service','CI/Streaming_Revenue_Processor', 'CI/Lastmile_Instruction_Service',  'CI/Dc_Cs', 'CI/MDM','CD/Test/MDM','CI/Midmile','CI/Firstmile', 'CI/Sathi/Ecom_Sathi_Service','CI/Sathi/Ecom_Sathi_Service_Drs','CI/Sathi/Ecom_Sathi_Rds_Service','CI/Sathi/Ecom_Sathi_Webhook_Service','CI/Sathi/Ecom_Sathi_V2_Integration','CI/Sathi/Ecom_Notification_V2_Service','CI/Sathi/Ecom_Callbridge_V3_Service','CI/Communication_SMS_Service', 'CI/Lastmile', 'CI/Manifest', 'CI/Bagging', 'CI/Scadi_UI', 'CI/Esp_Payout_Service', 'CI/Communication_ClickTocall_Service','CI/Ecom_Communication_Sms_Processing_Service' ,'CI/Ecom_Communication_Webhook_Integration','CI/Masterdata_Processor','CI/Sruti_Java','CD/Test/Streaming_Revenue_Processor',  'CD/Test/Bagging', 'CD/Test/Communication_SMS_Service' , 'CD/Test/Lastmile' , 'CD/Test/CP' , 'CD/Test/Dc_Cs', 'CD/Test/Manifest' , 'CD/Test/Scadi_UI' ,'CI/Sso_UI', 'CD/Test/Sso_UI', 'CD/Test/Lastmile_Consumer_Service', 'CD/Test/Midmile','CD/Test/Lastmile_Instruction_Service',  'Infra/DevopsAccount','CD/Test/Firstmile', 'CD/Test/Esp_Payout_Service','CI/Sso', 'CD/Test/Sso', 'CD/Test/Communication_ClickTocall_Service', 'CI/Shipment/Shipment_Explus_Service' ,'CD/Test/Shipment/Shipment_Explus_Service','CI/Shipment/postmanifestation_service' ,'CD/Test/Shipment/postmanifestation_service','CD/Test/Ecom_Communication_Sms_Processing_Service','CD/Test/Ecom_Communication_Webhook_Integration','CD/Test/Sathi/Ecom_Sathi_Service','CD/Test/Sathi/Ecom_Callbridge_V3_Service','CD/Test/Sathi/Ecom_Sathi_Service_Drs','CD/Test/Sathi/Ecom_Sathi_Webhook_Service','CD/Test/Sathi/Ecom_Sathi_V2_Integration','CD/Test/Sathi/Ecom_Notification_V2_Service','CD/Test/Sathi/Ecom_Sathi_Rds_Service','CD/Test/Masterdata_Processor','CI/Shipment/Order-management-system','CD/Test/Shipment/Order-management-system','CD/DR', 'CD/Test/Sruti_Java']
// Function to create a folder and its parent folders recursively
def createFolderRecursively(parent, folderName) {
    def folderParts = folderName.tokenize('/')
    def currentPath = ''
    
    folderParts.each { part ->
        currentPath = currentPath ? "${currentPath}/${part}" : part
        folder(currentPath) {
            // Additional configurations for the folder can be added here if needed
        }
    }
}

// Create folders
folderNames.each { folderName ->
    createFolderRecursively('', folderName)
}


///////////////////////////////////////////Lastmile_Consumer_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Lastmile_Consumer_Service/Lastmile_Consumer_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                    scriptPath('lastmile-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

multibranchPipelineJob('CI/Lastmile_Consumer_Service/Lastmile_Consumer_Service_Minimalist_CI_Pipeline') {
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
            scriptPath('lastmile-consumer-service/Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
    
}

pipelineJob('CI/Lastmile_Consumer_Service/Lastmile_Consumer_Service_Nightly_CI_Pipeline') {
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
                    scriptPath('lastmile-consumer-service/Jenkinsfile_nightly')
                }
            }
        }
    }
}

///////////////////////////////////////////Lastmile_Instruction////////////////////////////////////////////////////////////////////////

multibranchPipelineJob('CI/Lastmile_Instruction_Service/Lastmile_Instruction_Service_Minimalist_CI_Pipeline') {
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

pipelineJob('CI/Lastmile_Instruction_Service/Lastmile_Instruction_Service_Extensive_CI_Pipeline') {
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

pipelineJob('CI/Lastmile_Instruction_Service/Lastmile_Instruction_Service_Nightly_CI_Pipeline') {
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


///////////////////////////////////////////Lastmile////////////////////////////////////////////////////////////////////////

multibranchPipelineJob('CI/Lastmile/Lastmile_Minimalist_CI_Pipeline') {
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
            scriptPath('lastmile/Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
    
}




pipelineJob('CI/Lastmile/Lastmile_Extensive_CI_Pipeline') {
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
                    scriptPath('lastmile/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CI/Lastmile/LastMile_Nightly_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                    scriptPath('lastmile/Jenkinsfile_nightly')
                }
            }
        }
    }
}


////////////////////////////////////// [ Customer Panel ]/////////////////////////////////////////////////////



multibranchPipelineJob('CI/CP/CP_Minimalist_CI_Pipeline') {
    branchSources {
        git {
            id('my-git-source-id') // Provide a unique ID for the Git branch source
            remote('https://scm.ecomexpress.in/scm/ap/customerpanel_3.0.git') // URL of your Git repository
            credentialsId('ayush_bitbucket_original') // Optional: Credentials ID if authentication is required
            includes('**') // Include all branches
        }
    }
    factory {
        workflowBranchProjectFactory {
            scriptPath('Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
}




pipelineJob('CI/CP/CP_Extensive_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/ap/customerpanel_3.0.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}




pipelineJob('CI/CP/CP_Nightly_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/ap/customerpanel_3.0.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_nightly')
                }
            }
        }
    }
}



////////////////////////////////////// [ Manifest ]/////////////////////////////////////////////////////



multibranchPipelineJob('CI/Manifest/Manifest_Minimalist_CI_Pipeline') {
    branchSources {
        git {
            id('my-git-source-id') // Provide a unique ID for the Git branch source
            remote('https://scm.ecomexpress.in/scm/jass/shipment_service.git') // URL of your Git repository
            credentialsId('ayush_bitbucket_original') // Optional: Credentials ID if authentication is required
            includes('**') // Include all branches
        }
    }
    factory {
        workflowBranchProjectFactory {
            scriptPath('ecom-parrent/shipmentservice/Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
    
}




pipelineJob('CI/Manifest/Manifest_Extensive_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/shipment_service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing_master')
                    scriptPath('ecom-parrent/shipmentservice/Jenkinsfile_extensive')
                }
            }
        }
    }
}




pipelineJob('CI/Manifest/Manifest_Nightly_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/shipment_service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing_master')
                    scriptPath('ecom-parrent/shipmentservice/Jenkinsfile_nightly')
                }
            }
        }
    }
}




////////////////////////////////////// [ Bagging ]/////////////////////////////////////////////////////





multibranchPipelineJob('CI/Bagging/Bagging_Minimalist_CI_Pipeline') {
    branchSources {
        git {
            id('my-git-source-id') // Provide a unique ID for the Git branch source
            remote('https://scm.ecomexpress.in/scm/~ayush.k_ecomexpress.in/ayush-shipment_service.git') // URL of your Git repository
            credentialsId('ayush_bitbucket_original') // Optional: Credentials ID if authentication is required
            includes('**') // Include all branches
        }
    }
    factory {
        workflowBranchProjectFactory {
            scriptPath('ecom-parrent/baggingservice/Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
    
}




pipelineJob('CI/Bagging/Bagging_Extensive_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/~ayush.k_ecomexpress.in/ayush-shipment_service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ecom-parrent/baggingservice/Jenkinsfile_extensive')
                }
            }
        }
    }
}




pipelineJob('CI/Bagging/Bagging_Nightly_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/~ayush.k_ecomexpress.in/ayush-shipment_service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ecom-parrent/baggingservice/Jenkinsfile_nightly')
                }
            }
        }
    }
}




////////////////////////////////////// [ SCADI-UI ]/////////////////////////////////////////////////////




multibranchPipelineJob('CI/Scadi_UI/Scadi_UI_Minimalist_CI_Pipeline') {
    branchSources {
        git {
            id('my-git-source-id') // Provide a unique ID for the Git branch source
            remote('https://scm.ecomexpress.in/scm/sca2/mdm.git') // URL of your Git repository
            credentialsId('ayush_bitbucket_original') // Optional: Credentials ID if authentication is required
            includes('**') // Include all branches
        }
    }
    factory {
        workflowBranchProjectFactory {
            scriptPath('Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
    
}




pipelineJob('CI/Scadi_UI/Scadi_UI_Extensive_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/sca2/mdm.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing_master')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}




pipelineJob('CI/Scadi_UI/Scadi_UI_Nightly_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/sca2/mdm.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing_master')
                    scriptPath('Jenkinsfile_nightly')
                }
            }
        }
    }
}


///////////////////////////////////////////Esp_Payout_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Esp_Payout_Service/Esp_Payout_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jav/esp-payout-service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

multibranchPipelineJob('CI/Esp_Payout_Service/Esp_Payout_Service_Minimalist_CI_Pipeline') {
    branchSources {
        git {
            id('my-git-source-id') // Provide a unique ID for the Git branch source
            remote('https://scm.ecomexpress.in/scm/jav/esp-payout-service.git') // URL of your Git repository
            credentialsId('ayush_bitbucket_original') // Optional: Credentials ID if authentication is required
            includes('**') // Include all branches
        }
    }
    factory {
        workflowBranchProjectFactory {
            scriptPath('Jenkinsfile_minimalist') // Path to Jenkinsfile in each branch
        }
    }
    
}

pipelineJob('CI/Esp_Payout_Service/Esp_Payout_Service_Nightly_CI_Pipeline') {
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
                        url('https://scm.ecomexpress.in/scm/jav/esp-payout-service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_nightly')
                }
            }
        }
    }
}

////////////////////////////////////// [ INFRA TF Pipeline ]/////////////////////////////////////////////////////

pipelineJob('Infra/DevopsAccount/Network_Skeleton_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/network_skeleton/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('Infra/DevopsAccount/Jenkins_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/devops_management/jenkins/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('Infra/DevopsAccount/Bastion_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/devops_management/bastion/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('Infra/DevopsAccount/Sonarqube_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/devops_management/sonarqube/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('Infra/DevopsAccount/ECR_Repos_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/devops_management/ecr/Jenkinsfile')
                }
            }
        }
    }
}
pipelineJob('Infra/DevopsAccount/EKS_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/devops_management/eks/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('Infra/DevopsAccount/ArgoCD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/devops_management/argocd/Jenkinsfile')
                }
            }
        }
    }
}





/////////////////////////////////////////////////////////////////////[ Secret Manager ]/////////////////////////////////////////////////////////////////////////////////////

pipelineJob('Infra/DevopsAccount/Test_Secret_Manager_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/app_dependency_management/test/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('Infra/DevopsAccount/UAT_Secret_Manager_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/dev/ecomexp-devops-tf-infra.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('main')
                    scriptPath('devops_account/app_dependency_management/uat/Jenkinsfile')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Bagging/Bagging_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/~ayush.k_ecomexpress.in/ayush-shipment_service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ecom-parrent/baggingservice/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Lastmile/Lastmile_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/las/lastmile2.0.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('SCAD2-25474')
                    scriptPath('lastmile/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Lastmile_Consumer_Service/Lastmile_Consumer_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
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
                    scriptPath('lastmile-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Lastmile_Instruction_Service/Lastmile_Instruction_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
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
                    scriptPath('lastmile-instruction-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


pipelineJob('CD/Test/Manifest/Manifest_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/~ayush.k_ecomexpress.in/ayush-manifest_service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ecom-parrent/shipmentservice/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/Test/CP/CP_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/ap/customerpanel_3.0.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Scadi_UI/Scadi_UI_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/sca2/mdm.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing_master')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

//////////////////////////////////////////Esp_Payout_Service///////////////////////////////////////////////////////////////////

pipelineJob('CD/Test/Esp_Payout_Service/Esp_Payout_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/esp-payout-service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}
///////////////////////////////////////////MDM_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/MDM/MDM_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/javam/java_mdm.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('mdm-opstree')
                    scriptPath('ecom-parent-service/ecom-mdm/Jenkinsfile_extensive')
                }
            }
        }
    }
}
pipelineJob('CD/Test/MDM/MDM_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/javam/java_mdm.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('mdm-opstree')
                    scriptPath('ecom-parent-service/ecom-mdm/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}
///////////////////////////////////////////Firstmile_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Firstmile/Firstmile_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/firstmile_services.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Firstmile/Firstmile_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/firstmile_services.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}
///////////////////////////////////////////SSO_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sso/Sso_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jav/sso_java.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/sso/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sso/Sso_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sso_java.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/sso/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}
///////////////////////////////////////////Communication_SMS_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Communication_SMS_Service/Communication_SMS_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-sms-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Communication_SMS_Service/Communication_SMS_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-sms-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

///////////////////////////////////////////Communication_ClickTocall_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Communication_ClickTocall_Service/Communication_ClickTocall_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-clickTocall-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Communication_ClickTocall_Service/Communication_ClickTocall_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-clickTocall-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Ecom-Communication-Sms-Processing-Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Ecom_Communication_Sms_Processing_Service/Ecom_Communication_Sms_Processing_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-sms-processing-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Ecom_Communication_Sms_Processing_Service/Ecom_Communication_Sms_Processing_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-sms-processing-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Ecom-Communication-Webhook-Integration////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Ecom_Communication_Webhook_Integration/Ecom_Communication_Webhook_Integration_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-webhook-integration/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Ecom_Communication_Webhook_Integration/Ecom_Communication_Webhook_Integration_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/ecom-communication-service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('ecom-communication-services/ecom-communication-webhook-integration/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


/////////////////////////////////////////////////////Midmile///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Midmile_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Midmile_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


/////////////////////////////////////////////////////EwayBill///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Ewaybill_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ewaybill-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Ewaybill_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ewaybill-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


/////////////////////////////////////////////////////midmile-bag-closure-kafka-consumer-service///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Midmile_Bag_Closure_Kafka_Consumer_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-bag-closure-kafka-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Midmile_Bag_Closure_Kafka_Consumer_Service_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-bag-closure-kafka-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


/////////////////////////////////////////////////////ewaybill-status-update-sorterdb-consumer-service///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Ewaybill_Status_Update_Sorterdb_Consumer_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ewaybill-status-update-sorterdb-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Ewaybill_Status_Update_Sorterdb_Consumer_Service_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ewaybill-status-update-sorterdb-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


/////////////////////////////////////////////////////Midmile-Bag-Inscan-Kafka-Consumer-Service///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Midmile_Bag_Inscan_Kafka_Consumer_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-bag-inscan-kafka-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Midmile_Bag_Inscan_Kafka_Consumer_Service_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-bag-inscan-kafka-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////masterdata-processor////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Masterdata_Processor/Masterdata_Processor_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/scbl/masterdata-processor.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Masterdata_Processor/Masterdata_Processor_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/scbl/masterdata-processor.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Streaming_Revenue_Processor////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Streaming_Revenue_Processor/Streaming_Revenue_Processor_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/scbl/streaming-revenue-processor.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Streaming_Revenue_Processor_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/scbl/streaming-revenue-processor.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('test_opstree')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

///////////////////////////////////////////Shipment_Explus_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Shipment/Shipment_Explus_Service/Shipment_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/shipment_service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('EXPP-OPSTREE-TESTING')
                    scriptPath('ecom-parrent/shipmentservice/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Shipment/Shipment_Explus_Service/Shipment__CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/shipment_service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('EXPP-OPSTREE-TESTING')
                    scriptPath('ecom-parrent/shipmentservice/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}
///////////////////////////////////////////postmanifestation_Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Shipment/postmanifestation_service/postmanifestation_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/manifestv2/postmanifest-service.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree-testing')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Shipment/postmanifestation_service/postmanifestation_service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/manifestv2/postmanifest-service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree-testing')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

///////////////////////////////////////////Ecom-Sathi-Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sathi/Ecom_Sathi_Service/Ecom_Sathi_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sathi/Ecom_Sathi_Service/Ecom_Sathi_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Ecom-Sathi-Service-Drs////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sathi/Ecom_Sathi_Service_Drs/Ecom_Sathi_Service_Drs_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-service-drs/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sathi/Ecom_Sathi_Service_Drs/Ecom_Sathi_Service_Drs_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-service-drs/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}



//////////////////////////////////////////////////DcCustomerSupport//////////////////////////////////////////////////////////////


pipelineJob('CI/Dc_Cs/Dc_Cs_extensive_ci_pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/pyt/dc-cs-python.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Dc_Cs/Dc_Cs_cd_pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/pyt/dc-cs-python.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


//////////////////////////////////////////////////Shipment_order managment//////////////////////////////////////////////////////////////


pipelineJob('CI/Shipment/Order-management-system/Order-management-system_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/manifestv2/order-management-system.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Shipment/Order-management-system/Order-management-system_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/manifestv2/order-management-system.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


/////////////////////////////////////////////////////Midmile-Gtrackafka_Extensive_CI_Pipeline///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Midmile_Gtrackafka_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-gtrac-kafka-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Midmile_Gtrackafka_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-gtrac-kafka-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

/////////////////////////////////////////////////////midmile-kafka-exception-handler-consumer-service///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Midmile_Kafka_Exception_Handler_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-kafka-exception-handler-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Midmile_Kafka_Exception_Handler_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-kafka-exception-handler-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

/////////////////////////////////////////////////////midmile-debagging-kafka-consumer-service///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Midmile_Debagging_Kafka_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-debagging-kafka-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Midmile_Debagging_Kafka_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-debagging-kafka-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

/////////////////////////////////////////////////////midmile-fleetx-consumer-service///////////////////////////////////////////////////////////////////


pipelineJob('CI/Midmile/Midmile_Fleetx_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-fleetx-consumer-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Midmile/Midmile_Fleetx_CD_Pipeline') {
    logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/midmile.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('midmile-fleetx-consumer-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Ecom-Sathi-Webhook-Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sathi/Ecom_Sathi_Webhook_Service/Ecom_Sathi_Webhook_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-webhook-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sathi/Ecom_Sathi_Webhook_Service/Ecom_Sathi_Webhook_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-webhook-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Ecom-Sathi-V2-Integration////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sathi/Ecom_Sathi_V2_Integration/Ecom_Sathi_V2_Integration_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('repo_branch', '', 'provide repo branch')
    }

// Disable concurrent builds

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-v2-integration/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sathi/Ecom_Sathi_V2_Integration/Ecom_Sathi_V2_Integration_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-v2-integration/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Ecom-Callbridge-V3-Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sathi/Ecom_Callbridge_V3_Service/Ecom_Callbridge_V3_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('repo_branch', '', 'provide repo branch')
    }

// Disable concurrent builds

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-callbridge-v3-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sathi/Ecom_Callbridge_V3_Service/Ecom_Callbridge_V3_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-callbridge-v3-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Ecom-Notification-V2-Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sathi/Ecom_Notification_V2_Service/Ecom_Notification_V2_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('repo_branch', '', 'provide repo branch')
    }

// Disable concurrent builds

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-notification-v2-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sathi/Ecom_Notification_V2_Service/Ecom_Notification_V2_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-notification-v2-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


///////////////////////////////////////////Sruti_Java ////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sruti_Java/Sruti_Java_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('repo_branch', '', 'provide repo branch')
    }

// Disable concurrent builds

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/sruti_java.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sruti_Java/Sruti_Java_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jass/sruti_java.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

////////////////////////////////////// [ SSO-UI ]/////////////////////////////////////////////////////

pipelineJob('CI/Sso_UI/Sso_UI_Extensive_CI_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
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
                        url('https://scm.ecomexpress.in/scm/sca2/sso_ui.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sso_UI/Sso_UI_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/sca2/sso_ui.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}




///////////////////////////////////////////Ecom-Sathi-Rds-Service////////////////////////////////////////////////////////////////////////

pipelineJob('CI/Sathi/Ecom_Sathi_Rds_Service/Ecom_Sathi_Rds_Service_Extensive_CI_Pipeline') {
// Configure build retention to keep only the last 4 builds
logRotator {
    numToKeep(4)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('repo_branch', '', 'provide repo branch')
    }

// Disable concurrent builds

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')
                        
                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-rds-service/Jenkinsfile_extensive')
                }
            }
        }
    }
}

pipelineJob('CD/Test/Sathi/Ecom_Sathi_Rds_Service/Ecom_Sathi_Rds_Service_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/jav/sathiv3.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing')
                    scriptPath('ecom-parent/ecom-sathi-rds-service/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}


/////////////////////////////////////////////////////////////////////////////////DR_ACCOUNT/////////////////////////////////////////////////////////////////////////////////////////////////////

pipelineJob('CD/DR/Bagging_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/~ayush.k_ecomexpress.in/ayush-shipment_service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ecom-parrent/baggingservice/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/DR/Lastmile_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/las/lastmile2.0.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('SCAD2-25474')
                    scriptPath('lastmile/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/DR/Manifest_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/~ayush.k_ecomexpress.in/ayush-manifest_service.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('ecom-parrent/shipmentservice/Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/DR/CP_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/ap/customerpanel_3.0.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}

pipelineJob('CD/DR/Scadi_UI_CD_Pipeline') {
    logRotator {
    numToKeep(2)  // Keep the last 4 builds
}

parameters {
        booleanParam('enable_jira', true, 'Support flag for build')
        stringParam('jira_ticket_id', '', 'The Jira issue key to update')
        stringParam('image_name', '', 'The name of the Docker image')
        stringParam('image_tag', '', 'The tag of the Docker image')
    }

    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/sca2/mdm.git')

                        credentials('ayush_bitbucket_original') // Optional if authentication is required
                    }
                    branch('opstree_testing_master')
                    scriptPath('Jenkinsfile_Test_CD')
                }
            }
        }
    }
}
