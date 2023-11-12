pipeline {
    agent any
    stages {
        stage ('Build') {
            steps {
                sh 'printenv'
            }
        }
        stage ('Publish ECR'){
            steps {
                withEnv (["AWS_ACCESS_KEY_ID=${env.AWS_ACCESS_KEY_ID}", "AWS_SECRET_ACCESS_KEY=${env.AWS_SECRET_ACCESS_KEY}", "AWS_DEFAULT_REGION=${env.AWS_DEFAULT_REGION}"]) {
                    sh '/usr/local/bin/docker login -u AWS -p $(/usr/local/bin/aws ecr get-login-password --region us-east-1) 036249831903.dkr.ecr.us-east-1.amazonaws.com'
                    sh '/usr/local/bin/docker build -t demoapp/frontendservice .'
                    sh '/usr/local/bin/docker tag demoapp/frontendservice:""$BUILD_ID""'
                    sh '/usr/local/bin/docker push 036249831903.dkr.ecr.us-east-1.amazonaws.com/demoapp/frontendservice:""$BUILD_ID""'
                }
            }
        }
    }
}