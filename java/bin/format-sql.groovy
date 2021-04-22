#!/usr/bin/env groovy
@Grab('com.github.vertical-blank:sql-formatter:2.0.0')
import static com.github.vertical_blank.sqlformatter.SqlFormatter.of as SqlFormatter
import static com.github.vertical_blank.sqlformatter.languages.Dialect.PlSql

args.each { String arg -> println(SqlFormatter(PlSql).format(new File(arg).text)) }
