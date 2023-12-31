// groovylint-disable-next-line CompileStatic, NoDef, UnusedVariable, VariableName, VariableTypeRequired
@Library('jenkins-pipeline-setup') _

String webhooks  = 'webhooks'
String terraform = 'terraform'

library(
  identifier: 'jenkins-shared-lib@v6.10.1',
  retriever: modernSCM([
    $class: 'GitSCMSource',
    remote: 'https://github.com/Tealium/jenkins-shared-lib',
    credentialsId: 'github-cicd-bot-teal-token'
  ])
)

pipeline {
  agent {
    kubernetes {
      yaml podDef([retrofit: 'jenkins/k8s-pods.yaml'])
    }
  }

  options {
    ansiColor('xterm')
    skipStagesAfterUnstable()
    timeout(time: 1, unit: 'HOURS')
    timestamps()
  }

  environment {
    ENVIRONMENT = "${env.ENVIRONMENT}"
    ENVIRONMENT_PREFIX = "${env.ENVIRONMENT_PREFIX}"
    // Needed for updatePipeline
    TF_IN_AUTOMATION = 'true'
  }

  stages {
    // CICD-related Jenkins pipeline configuration. 'Update Pipeline' MUST be the first stage in the pipeline.
    stage('Update Pipeline') {
      steps { script { updatePipeline([]) } }
    }

    stage('Preliminaries') {
      steps {
        container(webhooks) {
          script {
            gitCheckout()
            sourceVersion()
            // webhooksHelper.inProgress()
            // sourceVersion.checkUpToDate()
          }
        }
      }
    }

    stage('Terraform') {
      environment {
        ACCOUNT_ID = "${env.ACCOUNT_ID}"
        ACCOUNT_NAME = "${env.ACCOUNT_NAME}"
        COMPONENT = 'registry-routing'
        ENVIRONMENT_TYPE = "${env.ENVIRONMENT_TYPE}"
        PLATFORM_NAME = "${env.PLATFORM_NAME}"
        REGION = "${params.REGION_OVERRIDE ?: env.REGION}"
        // None of the above are actually needed by terraform, but must be specified in order
        // to satisfy the tealTerraform var script
        OVERRIDES_FILE_BASENAME = "${terraform}"
      }

      stages {
        stage('Plan') {
          steps {
            container(terraform) {
              dir(terraform) {
                script {
                    sh '''
                      terraform init
                      terraform plan -input=false -out=./tf.plan
                      terraform apply -input=false -auto-approve ./tf.plan
                    '''
                    // tealTerraform.plan()
                }
              }
            }
          }
        }

        // stage('Apply') {
        //   steps {
        //     container(terraform) {
        //       dir(terraform) {
        //         script { tealTerraform.apply() }
        //       }
        //     }
        //   }
        // }
      }
    }

    // stage('Create Pre-Release') {
    //   when { expression { sourceVersion.runningOnDefaultBranch() } }
    //   steps { container(webhooks) { script { cutRelease() } } }
    // }
  }

//   post {
//     always {
//       container(webhooks) {
//         script {
//         //   deploymentOrchestrator(env.ENVIRONMENT)
//         //   sourceVersion.checkUpToDate()
//         //   webhooksHelper.post()
//         }
//       }
//     }
//   }
}
