node('basic') {
  def commit_id
  def app
  def tag

  stage('Checkout source') {
    checkout scm
    sh 'git rev-parse HEAD > .git-commit-id'
    commit_id = readFile('.git-commit-id').trim()
  }

  stage('Build image') {
    app = docker.build 'lrhstsa/testor-server'
  }

  stage('Push image') {
    sh 'docker login --username $DOCKER_HUB_USERNAME --password $DOCKER_HUB_PASSWORD'
    tag = "${env.BRANCH_NAME}-${commit_id}"
    switch(env.BRANCH_NAME) {
      case "develop":
        tag = "${env.BRANCH_NAME}-${commit_id}"
      break
      case "master":
        tag = binding.variables.get("TAG_NAME")
        sh 'git describe --tags > .git-tag'
        tag = readFile('.git-tag').trim()
      break
    }
    app.push "${tag}"
  }

  stage('Deploy to cluster') {
    def namespace
    switch(env.BRANCH_NAME) {
      case 'develop':
        namespace = 'development'
      break
      case 'master':
        namespace = 'master'
      break
    }
    sh "kubectl --namespace ${namespace} set image deployment testor-server testor-server=lrhstsa/testor-server:${tag}"
  }
}
