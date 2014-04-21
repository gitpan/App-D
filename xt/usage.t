#!/usr/bin/perl

use strict;
use warnings FATAL => 'all';
use utf8;
use open qw(:std :utf8);

use Test::More;
use Test::Differences;

use Class::Date qw(date);
use Capture::Tiny qw(capture_merged);

sub basic_usage {

    my $now = date('2014-04-21 16:11:40');

    no warnings 'once';
    no warnings 'redefine';
    *main::get_now = sub {
        return $now;
    };

    my $output = capture_merged {
        main();
    };

    my $space = " ";

    eq_or_diff(
        $output,
"
    2014-04-21 16:11:40 UTC
    2014-04-21 20:11:40 MSK

Пн Вт Ср Чт Пт Сб Вс
                1  2     март
 3  4  5  6  7  8  9$space
10 11 12 13 14 15 16$space
17 18 19 20 21 22 23$space
24 25 26 27 28 29 30$space
31  1  2  3  4  5  6     апрель
 7  8  9 10 11 12 13$space
14 15 16 17 18 19 20$space
21 22 23 24 25 26 27$space
28 29 30  1  2  3  4     май
 5  6  7  8  9 10 11$space
12 13 14 15 16 17 18$space
19 20 21 22 23 24 25$space
26 27 28 29 30 31$space

",
        'Got correct output for basic usage',
    );

    return '';
}

sub end_of_month {

    my $now = date('2014-03-30 16:11:40');

    no warnings 'once';
    no warnings 'redefine';
    *main::get_now = sub {
        return $now;
    };

    my $output = capture_merged {
        main();
    };

    my $space = " ";


    eq_or_diff(
        $output,
"
    2014-03-30 16:11:40 UTC
    2014-03-30 20:11:40 MSK

Пн Вт Ср Чт Пт Сб Вс
                1  2     февраль
 3  4  5  6  7  8  9$space
10 11 12 13 14 15 16$space
17 18 19 20 21 22 23$space
24 25 26 27 28  1  2     март
 3  4  5  6  7  8  9$space
10 11 12 13 14 15 16$space
17 18 19 20 21 22 23$space
24 25 26 27 28 29 30$space
31  1  2  3  4  5  6     апрель
 7  8  9 10 11 12 13$space
14 15 16 17 18 19 20$space
21 22 23 24 25 26 27$space
28 29 30$space

",
        'Got correct output for basic usage',
    );

    return '';
}

sub main_in_test {

    require 'bin/d';

    pass('Loaded ok');

    basic_usage();
    end_of_month();

    done_testing();

}
main_in_test();
