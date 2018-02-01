pipeline {
    agent any 

    stages {
        stage('checkout') { 
            steps { 
                /*
                withCredentials([[
                    $class: 'UsernamePasswordMultiBinding', 
                    credentialsId: 'mylogin',
                    usernameVariable: 'USERNAME', 
                    passwordVariable: 'PASSWORD']]) {
                      sh '''
                        set +x
                        curl -u $USERNAME:$PASSWORD https://private.server/ > output
                      '''
                }
                */
                git url: "https://github.com/ibata/terraform-pipeline.git"
                withCredentials([[
                    $class: 'AmazonWebServicesCredentialsBinding',
                    credentialsId: 'jenkins-aws-iam',
                    accessKeyVariable: 'AWS_ACCESS_KEY_ID',
                    secretKeyVariable: 'AWS_SECRET_ACCESS_KEY'
                    ]]) {

                            //Templating with Linux in a Shell                         
                            //sh 'sed -e "s/ACCESS_KEY/$AWS_ACCESS_KEY_ID/" -e "s/SECRET_ACCESSKEY/$AWS_SECRET_ACCESS_KEY/"  terraform/injectinputs.tfvars'
                            sh '''
                                sed -e "s/ACCESS_KEY/$AWS_ACCESS_KEY_ID/" -e "s,SECRET_ACCESSKEY,$AWS_SECRET_ACCESS_KEY,"  terraform/injectinputs.tfvars
                            '''

                           
                    }
            }
        }

        stage('dependencies') {
            steps {
                sh "test -f bin/terraform || (mkdir -p bin && wget https://releases.hashicorp.com/terraform/0.8.1/terraform_0.8.1_linux_amd64.zip && unzip terraform_0.8.1_linux_amd64.zip -d bin/)"
            }
        }
        stage('state'){
            steps {
                sh "rm -rf .terraform"
                sh "rm -f terraform.tfstate*"
            }
        }
        stage('plan') {
            steps {
                sh "bin/terraform plan --out plan.tfplan terraform/"
            }
        }
        stage('apply') {
            steps {
                sh "bin/terraform apply plan.tfplan"
            }
        }
        stage('integration testing') {
            steps {
                sh "test -f bin/terraform"
            }
        }

    }
}

