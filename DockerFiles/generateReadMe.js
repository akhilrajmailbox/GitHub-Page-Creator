var marked = require('marked');
var fs = require('fs');
const HTML_FILE_NAME = process.env.HTML_FILE_NAME || 'README.md';
const DEST_FILE_NAME = process.env.DEST_FILE_NAME || 'noname.html';

var readMe = fs.readFileSync(HTML_FILE_NAME, 'utf-8');
var markdownReadMe = marked(readMe);

fs.writeFileSync(DEST_FILE_NAME, markdownReadMe);