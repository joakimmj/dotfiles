---
created: 2026-11-13
tool: bash
tags: [shell]
---
<!-- SYNAPSES -->
- **up:** [bash_config](bash_config.md)
***
<!-- /SYNAPSES -->

# Bash: Java helpers

Helper functions for starting and testing maven projects. They live in their
own file, `.bash_java`, so only tangle this file on machines that need them:
```bash
md-tangle configurations/bash_java.md
```

> If you need a custom trust store, add `-Djavax.net.ssl.trustStore=<path>` to
> the `java -jar` calls on the machine that needs it (not committed here).

Name of the current directory (the jar is named after the project folder).
```bash tangle:~/.bash_java
_current_dir() {
    local current_dir
    current_dir=${PWD##*/}        # to assign to a variable
    current_dir=${current_dir:-/} # to correct for the case where PWD is / (root)
    echo "${current_dir}"
}
```

Build and start the project. `jstart [profile]` runs with profile `local` (plus
the given profile), `jcleanstart` does a clean build first.
```bash tangle:~/.bash_java

jstart() {
    clear
    echo "mvn package -Dmaven.test.skip"
    mvn package -Dmaven.test.skip
    local profiles="local"
    if [ "$#" -eq 1 ]; then
        profiles+=",$1"
    fi
    local current_dir=$(_current_dir)
    echo "java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar
}

jcleanstart() {
    clear
    echo "mvn -U clean package -Dmaven.test.skip"
    mvn -U clean package -Dmaven.test.skip
    local profiles="local"
    if [ "$#" -eq 1 ]; then
        profiles+=",$1"
    fi
    local current_dir=$(_current_dir)
    echo "java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar"
    java -jar -Dspring.profiles.active=${profiles} target/${current_dir}.jar
}
```

Run tests. `jtest [class [method]]`, `jitest` runs the integration tests.
```bash tangle:~/.bash_java

jtest() {
    clear
    local args
    if [ "$#" -eq 1 ]; then
        args="-Dtest=$1"
    elif [ "$#" -eq 2 ]; then
        args="-Dtest=$1#$2"
    fi
    echo "mvn -U clean test ${args}"
    mvn -U clean test ${args}
}

jitest() {
    clear
    echo "mvn -U clean verify -Pintegration-test"
    mvn -U clean verify -Pintegration-test
}
```

