const cheerio = require('cheerio');
const fs = require('fs');
const path = require('path');


function insertCss(filepath) {
    const fd = fs.openSync(filepath, 'r+');
    const data = fs.readFileSync(fd);
    const $ = cheerio.load(data);
    let count = 0;
    let allCss = "";
    $('link[rel="stylesheet"]').each((index, link) => {
        const cssFile = $(link).attr('href');
        const cssContent = fs.readFileSync(path.resolve(path.dirname(filepath), cssFile));
        $(link).remove();
        allCss += cssContent;
        count += 1;
    });

    if (count > 0) {
        console.log(`insert css > ${filepath} (${count})`);
        $(`<style>${allCss}</style>`).insertAfter('head');
    }

    fs.writeFileSync(fd, $.html());
    fs.closeSync(fd);
}


insertCss(process.argv[2]);
