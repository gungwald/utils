#!/usr/bin/env groovy

// Groovy script to run Maven to create a JAR project.
//
// This script requires Groovy. Install it using the command appropriate to your system:
//
//      Fedora: sudo dnf install groovy
//      RHEL:   sudo yum install groovy
//      Debyan: sudo apt install groovy
//      Windows:choco install groovy

final int EXIT_SUCCESS = 0
final int EXIT_FAILURE = 1

exitCode = EXIT_SUCCESS

try 
{
    stdin = new BufferedReader(new InputStreamReader(System.in))

    print("Enter groupId (example: com.companyname.groupname): ")
    group = stdin.readLine()

    print("Enter artifactId (example: my-component-name): ")
    artifact = stdin.readLine()

    String[] cmd = 
    [
            "mvn", 
            "archetype:generate",
            "-DgroupId=${group}",
            "-DartifactId=${artifact}",
            "-DarchetypeArtifactId=maven-archetype-quickstart",
            "-DinteractiveMode=false"
    ]
    exitCode = new ProcessBuilder(cmd).inheritIO().start().waitFor()
} 
catch (Exception e) 
{
    println(e.getLocalizedMessage())
    e.printStackTrace();
    exitCode = EXIT_FAILURE
}

System.exit(exitCode)

