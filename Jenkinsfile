pipeline {
    agent any
    
    parameters {
        string(name: 'KUBE_API_EP', defaultValue: 'https://K8S-af8abfd91dc8ead1.elb.us-east-1.amazonaws.com', description: 'provide the image tag to be deployed')
        string(name: 'cert_name', defaultValue: 'deploy-qa.crt', description: 'Add/Select the K8s CERT filename of the cluster you want to connect') 
    }
    environment {
        DOCKER = credentials('Docker-creds')
        CERT = "$WORKSPACE/certs/${cert_name}"
    }
    stages{
        stage('CLEAN WORKSPACE'){
            steps{
                    cleanWs()
                }
            }
        stage ('git checkout') {
            steps {
                git 'https://github.com/syedmukthader/cicd1.git'
            }
        }
       stage("docker-build") {
    steps {
        sh '''
        echo "dckr_pat_6UBnYTY-v9DtMETl5X_cOS65acE" | docker login --username trydomain --password-stdin
        docker build -t regapp2 .
        docker tag regapp2:latest trydomain/regapp2:latest
        docker push trydomain/regapp2:latest
        '''
    }
}
        stage("k8s-deployment")
		{
			steps{
                withCredentials([string(credentialsId: 'K8S-TOKEN', variable: 'KUBE_API_TOKEN')]) {
                sh '''
                sh /var/lib/jenkins/workspace/cicd23/certs/set-k8s-context.sh \
                    "https://K8S-af8abfd91dc8ead1.elb.us-east-1.amazonaws.com****" \
                    "$KUBE_API_TOKEN" \
                    "/var/lib/jenkins/workspace/cicd23/certs/deploy-qa.crt"
                kubectl apply -f . --insecure-skip-tls-verify
                kubectl get all --insecure-skip-tls-verify
                '''
                }
            }
        }
    }
}  
