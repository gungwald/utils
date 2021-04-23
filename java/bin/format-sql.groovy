#!/usr/bin/env groovy
@Grab('com.github.vertical-blank:sql-formatter:2.0.0')
import com.github.vertical_blank.sqlformatter.SqlFormatter
import static com.github.vertical_blank.sqlformatter.languages.Dialect.PlSql

// If there are no arguments, then read input from stdin.
if (args.length == 0) {
    println(cleanup(SqlFormatter.of(PlSql).format(System.in.text)))
} else {
    args.each { String arg -> println(cleanup(SqlFormatter.of(PlSql).format(new File(arg).text))) }
}

String cleanup(String sql) {
    // Fix corrupted variable references
    // Remove spaces added unnecessarily
    return sql.replaceAll(/\$ \{ (\w+) \}/, { Object[] captureGroup -> "\${${captureGroup[1]}}"})
        .replaceAll(/(\w) \.(\w)/, { Object[] captureGroup -> "${captureGroup[1]}.${captureGroup[2]}"})
}
