#!groovy​

// Setup the AWS Credentials
withCredentials([[$class: 'UsernamePasswordMultiBinding', credentialsId: "${env.AWS_CREDENTIALS}",
                 usernameVariable: 'USERNAME', passwordVariable: 'PASSWORD']]) {
    env.AWS_ACCESS_KEY_ID = "$USERNAME"
    env.AWS_SECRET_ACCESS_KEY = "$PASSWORD"
}

node {
   stage 'checkout'
        checkout scm

   stage 'dependencies'
        sh "test -f bin/terraform || (mkdir -p bin && wget https://releases.hashicorp.com/terraform/0.8.1/terraform_0.8.1_linux_amd64.zip && unzip terraform_0.8.1_linux_amd64.zip -d bin/)"
   stage 'state'
        sh "rm -rf .terraform"
        sh "rm -f terraform.tfstate*"
   stage name: 'build', concurrency: 1
        echo "packer build project.json"

   stage name: 'plan', concurrency: 1
        sh "bin/terraform plan --out plan.tfplan terraform/"

   stage name: 'apply', concurrency: 1
        def deploy_validation = input(
            id: 'apply',
            message: 'apply planned changes',
            type: "boolean")

        sh "bin/terraform apply plan.tfplan"
   
   stage name: 'integration testing', concurrency: 1
        sh "test -f bin/terraform"
   
   stage name: 'destroy', concurrency: 1
        def destroy_validation = input(
            id: 'destroy',
            message: 'destroy environment',
            type: "boolean")

        sh "bin/terraform destroy plan.tfplan"
}
