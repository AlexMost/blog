const cheerio = require('cheerio');
const base64 = require('base64-img');
const fs = require('fs');
const path = require('path');

/*
 <img class="lazyload blur-up"
 data-sizes="auto"
 src="/images/istambul/220IMG_2916.jpg"
 data-srcset="/images/istambul/220IMG_2916.jpg 220w,
 /images/istambul/300IMG_2916.jpg 300w,
 /images/istambul/600IMG_2916.jpg 600w,
 /images/istambul/900IMG_2916.jpg 900w"
 />
 */

function lazify(filepath) {
    const basedir = process.cwd() + '/_site/images';
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