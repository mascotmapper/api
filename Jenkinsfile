pipeline {
    agent any
    options {
        buildDiscarder(logRotator(daysToKeepStr: '10', numToKeepStr: '10'))
        timeout(time: 12, unit: 'HOURS')
        timestamps()
    }
    stages {
        stage('Requirements') {
            steps {
                sh('''
                        python3 -m venv local
                        source ./local/bin/activate
                        pip install -U -r requirements.txt
                        ''')
            }
        }
        stage('Check') {
            steps {
                sh('''
                        source ./local/bin/activate
                        ''')
            }
        }
        stage('Build') {
            steps {
                sh('''
                        source ./local/bin/activate
                        ''')
            }
        }
        stage('Deploy Staging') {
            steps {
                sh('''
                        source ./local/bin/activate
                        ''')
            }
        }
        stage('Test Staging') {
            steps {
                sh('''
                        source ./local/bin/activate
                        ''')
            }
        }
        stage('Deploy Production') {
            steps {
                sh('''
                        source ./local/bin/activate
                        ''')
            }
        }
        stage('Test Production') {
            steps {
                sh('''
                        source ./local/bin/activate
                        ''')
            }
        }
    }
}

Requirements
Check
Build
Deploy Staging
Test Staging
Deploy Production
Test Production
