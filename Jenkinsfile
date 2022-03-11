def mailRecipients = "Connor.Trostel@br-automation.com"

def Version() {
    echo "Version";
    def branch = Branch();
    def tag = Tag();
    def count = powershell(returnStdout: true, script: "git rev-list HEAD --count").trim();
    try {
        count = powershell(returnStdout: true, script: "git rev-list $tag..HEAD --count").trim();
    }
    catch (err){
    }

    if (branch.matches("release/(.*)")) {
        echo "Release Branch";
        return "$tag.$count";
    }
    echo "Not Release Branch";
    tag = tag.substring(0, tag.lastIndexOf('.'))
    tag = tag + '.9';
    return "$tag.$count";
}

def Tag() {
    echo "Tag";
    def tag = "V0.0.9"
    try{
        tag = powershell(returnStdout: true, script: "git describe --abbrev=0 --always").trim();
    }
    catch (err){
    }
    return "$tag";
}

def Branch(){
    echo "Branch";
    def branch = "";
    try {
        branch = "${env.BRANCH_NAME}";
    }
    catch (err)
    {
        branch = powershell(returnStdout: true, script: "git branch --show-current")
    }
    return "$branch";
}

pipeline {
    agent any 
    triggers {
        cron(Branch().matches('release/*') ? '50 8 * * *' : '')
    }

    environment {
        PROJECT_DIR = "$WORKSPACE\\BaseProject";
        INSTALLER_SETUP = "$WORKSPACE\\InstallerSetup";
        TECHNOLOGY_SOLUTION = "$INSTALLER_SETUP\\Installer AS Technology Solution\\TechnologySolution";
        HELP_LOCATION = "$WORKSPACE\\External";
        HELP_FILE = "TrakMapHelp.hnd";
        HELP_OUTPUT = "..\\InstallerSetup\\Installer AS Technology Solution\\SetupData\\Help";
    }
    stages {
        stage('Install Dependencies')
        {
            steps {
                powershell(returnStdout: true, script: "pip install pysimplegui");
                powershell(returnStdout: true, script: "pip install pyinstaller");
            }
        }
        stage('Build AS') {
            steps {
                powershell(returnStdout: true, script:  "python \"$ProjectBuilderScripts\\ASProjectCompile.py\" --project \"$PROJECT_DIR\" --configuration TestConfig");
            }
        }
        /*stage('Run Unit Tests') {
            when
            {
                branch 'release*'
            }
            steps {
                powershell(returnStdout: true, script:  "python \"$ProjectBuilderScripts\\ASProjectCompile.py\" --project \"$PROJECT_DIR\" --configuration TS_UnitTest");
                powershell(returnStdout: true, script:  "python \"$ProjectBuilderScripts\\CreateArSimInstallation.py\" --project \"$PROJECT_DIR\" --configuration TS_UnitTest --simulationDirectory \"$PROJECT_DIR\\ArSim\"");
                powershell(returnStdout: true, script:  "python \"$ProjectBuilderScripts\\StartArSim.py\" --simulationDirectory \"$PROJECT_DIR\\ArSim\"");
                powershell(returnStdout: true, script:  "python \"$ProjectBuilderScripts\\RunUnitTests.py\" --test all --output \"$PROJECT_DIR\\TestResults\"");
                powershell(returnStdout: true, script:  "python \"$ProjectBuilderScripts\\StopArSim.py\" --simulationDirectory \"$PROJECT_DIR\\ArSim\"");
            }
        }*/
        stage('Export Libraries') {
            when { expression { return false } }
            environment {
                VERSION = Version()
            }
            steps {
                powershell(returnStdout: true, script:  "python \"$ProjectBuilderScripts\\LibraryBuild.py\" --project \"$PROJECT_DIR\" --config \"TestConfig\" --library \"TrakDiag\" --directory \"$INSTALLER_SETUP\\Installer AS Technology Solution\\Compiled Library\"");
            }
        }
        stage('Build TrakMap Importer') {
            environment {
                VERSION = Version()
            }
            steps {
                powershell(returnStdout: true, script:  "pyinstaller \"External\\TrakMapImporter\\TrakMapImporter.py\" --onefile --clean --distpath \"InstallerSetup\\Installer AS Technology Solution\\SetupData\\Help\\Help-en\\TrakMapWidgetLibraryHelp\" ");
            }
        }
        stage('Build Help') {
            environment {
                VERSION = Version()
            }
            options {
                timeout(time: 30, unit: "SECONDS")
            }
            steps {
                script {
                    Exception caughtException = null
                    catchError(buildResult: 'SUCCESS', stageResult: 'ABORTED') { 
                        try { 
                            powershell(returnStdout: true, script: "python \"$ProjectBuilderScripts\\BuildHelp.py\" --project \"$HELP_LOCATION\" --name $HELP_FILE --output \"$HELP_OUTPUT\"");
                        } catch (org.jenkinsci.plugins.workflow.steps.FlowInterruptedException e) {
                            error "Caught ${e.toString()}" 
                        } catch (Throwable e) {
                            caughtException = e
                        }
                    }
                    if (caughtException) {
                        error caughtException.message
                    }
                }
            }
        }
        stage('Create Technology Solution') {
            environment {
                VERSION = Version()
            }
            steps {
                writeFile file: "${env.JOB_BASE_NAME}.json", text: '''{
                    "libraries" :
                    [
                        "brdkSTR",
                        "snprintf",
                        "TrkDiag",
                        "TrkPaper"
                    ],
                    "files" :
                    [
                        "Logical\\\\Source\\\\Diagnostic\\\\TrakDiag",
                        "Logical\\\\mappView\\\\Resources\\\\Themes\\\\BuRThemeFlat2",
                        "Logical\\\\mappView\\\\Widgets\\\\TrakMap"
                    ]
                }'''

                dir("$VERSION"){ deleteDir(); }
                dir("$TECHNOLOGY_SOLUTION"){ deleteDir(); }
                powershell(returnStdout: true, script: "python \"$ProjectBuilderScripts\\Export.py\" --project \"$PROJECT_DIR\" --output \"$VERSION\" --physical \"Physical\\TestConfig\" --config \"${env.JOB_BASE_NAME}.json\" --zip \"False\"");
                powershell(returnStdout: true, script: "Copy-Item \"$INSTALLER_SETUP\\Installer AS Technology Solution\\AdvancedExport.xml\" -Destination \"$VERSION\"");
                powershell(returnStdout: true, script: "Copy-Item \"$INSTALLER_SETUP\\Installer AS Technology Solution\\Image.png\" -Destination \"$VERSION\"");
                powershell(returnStdout: true, script: "New-Item -Path '$TECHNOLOGY_SOLUTION\\$VERSION\\' -ItemType Directory");
                powershell(returnStdout: true, script: "Compress-Archive -Path \"$VERSION\\*\"  -DestinationPath \"$TECHNOLOGY_SOLUTION\\$VERSION\\${env.JOB_BASE_NAME}.zip\"");
            }
        }
        stage('Create Installer') {
            environment {
                VERSION = Version()
            }
            steps {
                powershell(returnStdout: true, script: "python \"$ProjectBuilderScripts\\UpdateInstallerVersion.py\" --project \"$INSTALLER_SETUP\\Installer AS Technology Solution\" --name TrakMap --version $VERSION");
                powershell(returnStdout: true, script: "& 'C:\\Program Files (x86)\\NSIS\\makensis.exe' '$INSTALLER_SETUP\\Installer AS Technology Solution\\SetupTechnologySolutionComplete.nsi'");
            }
        }
        stage('Deploy Release')
        {
            environment {
                TAG = Tag()
            }
            when
            {
                branch 'release'
            }
            steps {
                bat "xcopy \"InstallerSetup\\Installer AS Technology Solution\\Install\\*.exe\" \"C:\\Users\\buchananw\\ABB\\Team Orange - Releases\\Releases\\$TAG\\\" /y"
            }
        }
        stage('Deploy Feature')
        {
            when
            {
                anyOf {
                    branch 'feature/*'
                    branch 'development'
                }
            }
            steps {
                bat "xcopy \"InstallerSetup\\Installer AS Technology Solution\\Install\\*.exe\" \"C:\\Users\\buchananw\\ABB\\Team Orange - Releases\\Dev\\$BRANCH_NAME\\\" /y"
            }
        }
    }
    post {
         success {
            script {
                def jobName = currentBuild.fullDisplayName
                emailext body: '''${SCRIPT, template="groovy-html.template"}''',
                        mimeType: 'text/html',
                        subject: "[Jenkins] ${jobName}",
                        to: "${mailRecipients}",
                        from: "wesley.buchanan@br-automation.com",
                        replyTo: "${mailRecipients}"
            }
        }
         failure {
            script {
            
                def jobName = currentBuild.fullDisplayName
                emailext body: '''${SCRIPT, template="groovy-html.template"}''',
                        mimeType: 'text/html',
                        subject: "[Jenkins] ${jobName}",
                        to: "${mailRecipients}",
                        from: "wesley.buchanan@br-automation.com",
                        replyTo: "${mailRecipients}"
            }

         }
         unstable {
             echo 'This will run only if the run was marked as unstable'
         }
         changed {
             echo 'This will run only if the state of the Pipeline has changed'
             echo 'For example, if the Pipeline was previously failing but is now successful'
         }
    }
}