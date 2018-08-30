pipeline {
    agent any
    environment {
        TERRAFORM = 'docker run --network host -w /app -v ${HOME}/.aws:/root/.aws -v ${HOME}/.ssh:/root/.ssh -v `pwd`:/app hashicorp/terraform:light'
    }
    stages {
        stage('checkout repo') {
            steps {
                script {
                    def scmVars = checkout scm
                    env.GIT_COMMIT = scmVars.GIT_COMMIT
                    env.GIT_BRANCH = scmVars.GIT_BRANCH
                }
            }
        }

        stage('run delphix automation framework') {
            steps {
                writeFile file: 'payload.json', text: payload
                script {
                    withCredentials([string(credentialsId: 'delphix_engine', variable: 'engine'), string(credentialsId: 'delphix_user', variable: 'user'), string(credentialsId: 'delphix_pass', variable: 'pass')]) {
                        env.DELPHIX_ENGINE = engine
                        env.DELPHIX_USER = user
                        env.DELPHIX_PASS = pass
                    }
                }
                sh "java -jar daf.jar"
            }
        }

        stage('migrate schema') {
            steps {
                sh "cp ./src/main/resources/application.properties.example ./src/main/resources/application.properties"
                withCredentials([string(credentialsId: 'dev_host', variable: 'dev_host'), string(credentialsId: 'dev_user', variable: 'dev_user'), string(credentialsId: 'dev_pass', variable: 'dev_pass')]) {
                    sh 'mvn liquibase:update -Dliquibase.password=$dev_pass -Dliquibase.username=$dev_user -Dliquibase.url=jdbc:postgresql://$dev_host:5434/postgres'
                }
            }
        }

        /*
        stage('pull latest light terraform image') {
            steps {
                sh  "docker pull hashicorp/terraform:light"
            }
        }
        stage('init') {
            steps {
                dir ('terraform') {
                    sh  "${TERRAFORM} init -backend=true -input=false"
                }
            }
        }
        stage('workspace') {
            steps {
                dir ('terraform') {
                    sh  "${TERRAFORM} workspace select production"
                }
            }
        }
        stage('plan') {
            steps {
                dir ('terraform') {
                    sh  "${TERRAFORM} plan -out=tfplan -input=false"
                    script {
                        timeout(time: 10, unit: 'MINUTES') {
                            input(id: "Deploy Gate", message: "Deploy ${params.project_name}?", ok: 'Deploy')
                        }
                    }
                }
            }
        }
        stage('apply') {
            steps {
                dir ('terraform') {
                    sh  "${TERRAFORM} apply -lock=false -input=false tfplan"
                }
            }
        }
        */
    }
}
