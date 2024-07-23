pipeline {
    agent any
    tools {
        terraform 'terraform'
    }

    stages {
        stage("Git Checkout") {
            steps {
                script {
                    git branch: 'main', url: 'https://github.com/RajneeshOps/terraform.git'
                }
            }
        }

        stage("Parameter Setup") {
            steps {
                script {
                    properties([
                        parameters([
                            choice(choices: ['apply', 'destroy'], name: 'ACTION')
                        ])
                    ])
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
                }
            }
        }

        stage('Terraform Action') {
            steps {
                script {
                    sh "terraform ${params.ACTION} --auto-approve"
                }
            }
        }
    }
}
