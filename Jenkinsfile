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
                sh('''#!/bin/bash
                        /usr/bin/python3 -m venv local
                        source ./local/bin/activate
                        pip install --upgrade --requirement requirements.txt
                        ''')
            }
        }
        stage('Check') {
            steps {
                sh('''#!/bin/bash
                        source ./local/bin/activate
                        make lint unittest
                        ''')
            }
        }
        stage('Build') {
            steps {
                sh('''#!/bin/bash
                        source ./local/bin/activate
                        make upload
                        ''')
            }
        }
        stage('Deploy Staging') {
            steps {
                sh('''#!/bin/bash
                        source ./local/bin/activate
                        make deploy ENV=staging
                        ''')
            }
        }
        stage('Test Staging') {
            steps {
                sh('''#!/bin/bash
                        source ./local/bin/activate
                        make test ENV=staging
                        ''')
            }
        }
        stage('Deploy Production') {
            steps {
                sh('''#!/bin/bash
                        source ./local/bin/activate
                        make deploy ENV=production
                        ''')
            }
        }
        stage('Test Production') {
            steps {
                sh('''#!/bin/bash
                        source ./local/bin/activate
                        make test ENV=production
                        ''')
            }
        }
    }
}
