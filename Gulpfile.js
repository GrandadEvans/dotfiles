var gulp       = require('gulp');
var mocha      = require('gulp-mocha');
var source     = require('vinyl-source-stream');
var babelify   = require('babelify');
var browserify = require('browserify');

gulp.task('browserify', function() {
    return browserify('./js/app.js')
    .transform(babelify, { stage: 0 })
    .bundle()
    .on('error', function(e){
        console.log(e.message);

        this.emit('end');
    })
    .pipe(source('bundle.js'))
    .pipe(gulp.dest('js'));
});

gulp.task('tests-mocha', function () {
    return gulp.src('test.js', {read: false})
    .once('error', function () {
        process.exit(1);
    })
    .once('end', function () {
        process.exit();
    })
    // gulp-mocha needs filepaths so you can't have any plugins before it
    .pipe(mocha({reporter: 'nyan'}));
});

gulp.task('tests-phpunit', function () {
    return gulp.src('
gulp.task('watch', function() {
    gulp.watch('**/*.js', ['browserify', 'tests-mocha']);
});
