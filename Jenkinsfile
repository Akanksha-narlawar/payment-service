stage('Archive') {
    steps {
        script {
            def jarFiles = findFiles(glob: 'target/*.jar')

            if (jarFiles.length == 0) {
                error 'No JAR file was generated'
            }

            if (jarFiles.length > 1) {
                error 'Multiple JAR files found'
            }

            env.ARTIFACT = jarFiles[0].path

            echo "Generated artifact: ${env.ARTIFACT}"

            archiveArtifacts(
                artifacts: env.ARTIFACT,
                fingerprint: true
            )

            stash(
                name: 'deployment-artifact',
                includes: env.ARTIFACT
            )
        }
    }
}