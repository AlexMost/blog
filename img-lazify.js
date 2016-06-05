const cheerio = require('cheerio');
const base64 = require('base64-img');
const fs = require('fs');
const path = require('path');


function lazify(filepath) {
    const basedir = process.cwd() + '/_site';
    const fd = fs.openSync(filepath, 'r+');
    const data = fs.readFileSync(fd);
    const $ = cheerio.load(data);
    let count = 0;

    $('img').each((index, img) => {
        const imgRelPath = $(img).attr('src');
        const isLazy = $(img).hasClass('lazyload');

        if (!isLazy) {
            return;
        }
        const imgAbsPath = path.resolve(basedir, imgRelPath);
        const lpipPath = imgAbsPath.replace(".jpg", "-lqip.jpg");
        const b64 = base64.base64Sync(lpipPath);

        $(img).attr('data-src', imgRelPath);

        $(img).attr('src', b64);
        
        count += 1;
    });

    if (count > 0) {
        console.log(`lazify > ${filepath} (${count})`);
    }

    fs.writeFileSync(fd, $.html());
    fs.closeSync(fd);
}

// process.argv.forEach(lazify);
lazify(process.argv[2]);