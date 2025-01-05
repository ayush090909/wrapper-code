folder('CI/Sathi/Ecom_Sathi_Service') {
    description('Folder for Ecom Sathi Service CI jobs.')
}

pipelineJob('CI/Sathi/Ecom_Sathi_Service/Minimalist_CI_Pipeline') {
    definition {
        cpsScm {
            scm {
                git {
                    remote {
                        url('https://scm.ecomexpress.in/scm/las/lastmile2.0.git')
                        credentials('ayush_bitbucket_original')
                    }
                    branch('opstree')
                    scriptPath('ecom-sathi-service/Jenkinsfile_minimalist')
                }
            }
        }
    }
}
