milestone()
timeout(time: 1, unit: 'HOURS'){
  lock(resource: "${env.JOB_NAME}", inversePrecedence: true) {
      try{
        stage ('Checkout/Prebuild'){
          milestone()
          node('centos') {
            checkout scm
            gitCommit = sh(returnStdout: true, script: 'git rev-parse HEAD').trim()
            shortCommit = gitCommit.take(6)
            gitBranch = scm.branches[0].name
            dockerTag = gitBranch.replace('\\','.').replace('/','.').take(128)
            buildVersion = "0.0"
            buildDisplayName = "${buildVersion}.${env.BUILD_NUMBER}-${shortCommit}"
            currentBuild.displayName = buildDisplayName

            println gitCommit
            println shortCommit
            println gitBranch
            println buildVersion
            sh "env"
	    
	    sh "rm -rf {build,dist} || true"
	    sh "mkdir -p {build/opt/vault,dist}"
	    sh  ./create_certificates.sh
	     



sh "fpm -v ${buildVersion}.${env.BUILD_NUMBER} --before-install ./pack-inst-scrpt/before_install.sh --after-install ./pack-inst-scrpt/after_install.sh --after-remove ./pack-inst-scrpt/after_remove.sh --before-upgrade ./pack-inst-scrpt/before_upgrade.sh --after-upgrade ./pack-inst-scrpt/after_upgrade.sh --rpm-user vault --rpm-group vault --directories /opt/vault/ --config-files /etc/vault/vault.hcl --force --package dist -s virtualenv -t rpm --name vault --prefix /opt/vault --virtualenv-other-files-dir=./build requirements.txt"
