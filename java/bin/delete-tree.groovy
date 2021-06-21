#!/usr/bin/env groovy

import java.nio.file.attribute.BasicFileAttributes
import java.nio.file.FileVisitResult
import java.nio.file.SimpleFileVisitor
import java.nio.file.Files
import java.nio.file.Path

static void deleteTree(Path start) {
    Files.walkFileTree(start, new SimpleFileVisitor<Path>() {
        FileVisitResult visitFile(Path p, BasicFileAttributes attrs) throws IOException {
            printf("Deleting %s%n", p.toString())
            Files.delete(p)
            return FileVisitResult.CONTINUE
        }
    })
}

args.each {deleteTree(it)}
