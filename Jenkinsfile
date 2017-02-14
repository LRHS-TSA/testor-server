node('basic') {
  def commit_id
  def app
  def tag

  stage('Checkout source') {
    slackSend "[Testor Server] Build #${env.BUILD_NUMBER} of ${env.BRANCH_NAME} started (${env.BUILD_URL})"
    checkout scm
    sh 'git rev-parse HEAD > .git-commit-id'
    commit_id = readFile('.git-commit-id').trim()
  }

  stage('Build image') {
    app = docker.build 'lrhstsa/testor-server'
  }

  stage('Push image') {
    withCredentials([string(credentialsId: 'docker-hub-password', variable: 'DOCKER_HUB_PASSWORD')]) {
      sh 'docker login --username ccatlett2000 --password $DOCKER_HUB_PASSWORD'
    }
    tag = "${env.BRANCH_NAME}-${commit_id}"
    switch(env.BRANCH_NAME) {
      case "develop":
        tag = "${env.BRANCH_NAME}-${commit_id}"
      break
      case "master":
        sh 'git describe --tags > .git-tag'
        tag = readFile('.git-tag').trim()
      break
    }
    app.push "${tag}"
  }

  stage('Deploy to cluster') {
    milestone()
    switch(env.BRANCH_NAME) {
      case 'develop':
        milestone()
        sh "kubectl --namespace development set image deployment testor-server testor-server=lrhstsa/testor-server:${tag}"
        slackSend color: 'good', message: "[Testor Server] Commit `${tag}` deployed to development"
      break
      case 'master':
        slackSend "[Testor Server] Release `${tag}` awaiting admin approval"
        input 'Deploy to production?'
        milestone()
        sh "kubectl --namespace default set image deployment testor-server testor-server=lrhstsa/testor-server:${tag}"
        slackSend color: 'good', message: "[Testor Server] Release `${tag}` deployed to production"
      break
    }
  }
}
