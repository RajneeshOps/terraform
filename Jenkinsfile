pipeline {
    agent any
    tools {
        terraform 'terraform'
    }

    parameters {
        choice(name: 'ACTION', choices: ['apply', 'destroy'], description: 'Select the Terraform action to perform')
    }

    stages {
        stage('Clean Workspace') {
            steps {
                script {
                    deleteDir()
                }
            }
        }

        stage("Git Checkout") {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/RajneeshOps/terraform.git'
                }
            }
        }

        stage("Terraform Init") {
            steps {
                script {
                    sh 'terraform init'
                }
            }
        }

        stage("Terraform Validate") {
            steps {
                script {
                    sh 'terraform validate'
                }
            }
        }

        stage('Terraform Plan') {
            steps {
                script {
                    sh 'terraform plan'
                }
            }
        }

        stage('Terraform Approval') {
            steps {
                script {
                    def userInput = input(id: 'confirm', message: 'Approve Terraform ?', parameters: [
                        [$class: 'BooleanParameterDefinition', defaultValue: false, description: 'Approve Terraform', name: 'confirm']
                    ])
                    if (!userInput) {
                        error('Terraform action not approved')
                    }
                }
            }
        }

        stage('Terraform Action') {
            steps {
                script {
                    if (params.ACTION == 'apply' || params.ACTION == 'destroy') {
                        sh "terraform ${params.ACTION} --auto-approve"
                    } else {
                        error('Invalid Terraform action')
                    }
                }
            }
        }
    }
}
