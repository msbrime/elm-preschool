var
    gulp = require('gulp'),
    sass = require('gulp-sass'),
    autoprefixer = require('gulp-autoprefixer'), 
    elm = require('gulp-elm'),
    browserSync = require('browser-sync').create(),
    plumber = require('gulp-plumber'),
    path = require('path'),
    newer = require('gulp-newer'),
    imagemin = require('gulp-imagemin'),
    cleanCss= require('gulp-clean-css'),

    io = {
        assets: path.resolve(__dirname + "/assets/"),
        app: path.resolve(__dirname + "/app/"),
        dest: path.resolve(__dirname + "/build/"),
    },
    
    imagePaths = {
        input: io.assets + "/images/**/*.*",
        output: io.dest + "/images/",
        watch: io.assets + "/images/**/*.*"
    },
    
    cssPaths = {
        input: io.assets + "/css/main.scss",
        output: io.dest + "/css/",
        watch: io.assets + "/css/**/*.*"
    },

    elmPaths = {
        input : io.app + '/Main.elm',
        watch : [ io.app + '/**/*.elm' , io.app + '/**/*.elm'],
        output : io.dest
    },
        
    sassConfig = { 
        outputStyle: 'compressed',
        includePaths: [
            "./node_modules/foundation-sites",
            "./node_modules/animate.css",
            "./node_modules/normalize-scss"
        ]
    };

gulp.task("sass", function () {
    return gulp.src(cssPaths.input)
        .pipe(plumber())
        .pipe(sass(sassConfig))
        .pipe(autoprefixer())
        .pipe(cleanCss({level:{1:{ specialComments:false }}}))
        .pipe(gulp.dest(cssPaths.output))
        .pipe(browserSync.stream());
});

gulp.task("images",function(){
    return gulp.src(imagePaths.input)
        .pipe(newer(imagePaths.output))
        .pipe(imagemin())
        .pipe(gulp.dest(imagePaths.output));
});

gulp.task('bundle',function () {
    return gulp.src(elmPaths.input)
        .pipe(plumber())
        .pipe(elm.bundle('elm.js'))
        .pipe(gulp.dest(elmPaths.output))
});

gulp.task('bundle:watch',['bundle'],function () {
    browserSync.reload();
});

gulp.task('images:watch',['images'],function () {
    browserSync.reload();
});

gulp.task('serve',function(){
    browserSync.init({
        server:{
            baseDir:'./'
        }
    });
});

gulp.task('build',['sass','images','bundle']);

gulp.task('watch', ['build','serve'], function () {
    gulp.watch(cssPaths.watch, ['sass']);
    gulp.watch(imagePaths.watch, ['images:watch']);
    gulp.watch(elmPaths.watch,['bundle:watch']);
});