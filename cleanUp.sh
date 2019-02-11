function cleanUp {
    rm -rf "$buildDir/$1"
    mkdir "$buildDir/$1"
    echo "clean build dir"
}

function maybeCleanUp {
    if [ -f "$buildDir/$1-incomplete" ]; then
        cleanUp $1
    fi
}

function markBuildIncomplete {
    touch "$buildDir/$1-incomplete"
}

function markBuildComplete {
    rm "$buildDir/$1-incomplete"
}
