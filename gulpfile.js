var gulp = require('gulp');
var gulpsync = require('gulp-sync')(gulp);
var shell = require('gulp-shell');
var markdown = require('gulp-markdown');

gulp.task('build', function (cb) {
  return gulp.src('index.md')
    .pipe(markdown())
    .pipe(gulp.dest('dist'));
});

gulp.task('deploy', shell.task([
  'surge ./dist -d adam.surge.sh'
]));

gulp.task('default', gulpsync.sync(['build', 'deploy']));
