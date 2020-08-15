//
// convert textile to html using textile-j
//

@Grab(group='net.java', module='textile-j', version='2.2')

import net.java.textilej.parser.MarkupParser;
import net.java.textilej.parser.builder.HtmlDocumentBuilder;

import net.java.textilej.parser.markup.textile.TextileDialect;

/*
import net.java.textilej.parser.markup.confluence.ConfluenceDialect;
import net.java.textilej.parser.markup.Dialect;
import net.java.textilej.parser.markup.mediawiki.MediaWikiDialect;
import net.java.textilej.parser.markup.trac.TracWikiDialect;
*/


def textile = '''
h1. hello textile-j
'''


def parser = new MarkupParser(new TextileDialect()) 
//def parser = new MarkupParser(new ConfluenceDialect())

def sw = new StringWriter()
HtmlDocumentBuilder builder = new HtmlDocumentBuilder(sw)
def isDocument=false
builder.setEmitAsDocument(isDocument)

parser.setBuilder(builder)
parser.parse(textile)

println sw.toString()

