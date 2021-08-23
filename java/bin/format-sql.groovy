#!/usr/bin/env groovy
@Grab('com.github.vertical-blank:sql-formatter:2.0.0')
import com.github.vertical_blank.sqlformatter.SqlFormatter
import com.github.vertical_blank.sqlformatter.core.FormatConfig
import groovy.transform.Field

import static com.github.vertical_blank.sqlformatter.languages.Dialect.PlSql

@Field
FormatConfig formatConfig = FormatConfig.builder().linesBetweenQueries(2).uppercase(true).build()
@Field
boolean modifyFilesInPlace = false

// If there are no arguments, then read input from stdin.
if (args.length == 0) {
    println(format(System.in.text))
} else {
    args.each { String arg ->
        if (arg == "--in-place" || arg == "-i") {
            modifyFilesInPlace = true
        } else {
            File sqlFile = new File(arg)
            if (modifyFilesInPlace) {
               sqlFile.text = format(sqlFile.text)
           } else {
               println(format(sqlFile.text))
           }
        }
    }
}

String format(String sql) {
    return cleanup(SqlFormatter.of(PlSql).format(sql as String, formatConfig as FormatConfig))
}

static String cleanup(String sql) {
    // Fix corrupted variable references
    // Remove spaces added unnecessarily
    return sql.replaceAll(/\$ \{ (\w+) \}/, { Object[] captureGroup -> "\${${captureGroup[1]}}" })
            .replaceAll(/(\w) \.(\w)/, { Object[] captureGroup -> "${captureGroup[1]}.${captureGroup[2]}" })
}