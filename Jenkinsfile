pipeline {
    agent any

    environment {
        ARTIFACT = ''
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build') {
            steps {
                bat 'mvn clean package -DskipTests'
            }
        }

        stage('Test') {
            steps {
                bat 'mvn test'
            }
        }

        stage('Archive') {
            steps {
                script {
                    def jarFiles = findFiles(glob: 'target/*.jar')

                    if (jarFiles.length == 0) {
                        error 'No JAR file was generated'
                    }

                    if (jarFiles.length > 1) {
                        error 'Multiple JAR files found. Deployment stopped.'
                    }

                    def artifact = jarFiles[0].path

                    echo "Generated artifact: ${artifact}"

                    archiveArtifacts(
                        artifacts: artifact,
                        fingerprint: true
                    )

                    stash(
                        name: 'deployment-artifact',
                        includes: artifact
                    )

                    env.ARTIFACT = artifact
                }
            }
        }

        stage('Approval') {
            steps {
                input(
                    message: 'Approve deployment to production?',
                    ok: 'Deploy'
                )
            }
        }

        stage('Deploy') {
            steps {
                script {
                    unstash 'deployment-artifact'

                    withCredentials([
                        usernamePassword(
                            credentialsId: 'deployment-credentials',
                            usernameVariable: 'DEPLOY_USER',
                            passwordVariable: 'DEPLOY_PASSWORD'
                        )
                    ]) {
                        bat '''
                            echo Deploying approved artifact...
                            bash deploy.sh "%ARTIFACT%"
                        '''
                    }
                }
            }
        }
    }

    post {

        always {
            junit(
                testResults: 'target/surefire-reports/*.xml',
                allowEmptyResults: true
            )

            echo 'Publishing test results and cleaning workspace...'

            cleanWs()
        }

        success {
            echo 'STATUS: Build and deployment completed successfully.'
        }

        failure {
            echo 'STATUS: Pipeline failed. Deployment was not successful.'
        }

        aborted {
            echo 'STATUS: Pipeline was aborted. Deployment was not completed.'
        }
    }
}