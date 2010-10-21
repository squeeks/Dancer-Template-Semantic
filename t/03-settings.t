use strict;
use warnings;
use lib qw(../lib);
use Test::More;

plan tests => 3;

{
    package Webservice;
    use Dancer;
    # configure Dancer to use semantic template with no option
    set template => 'semantic';

    get '/foo' => sub {
		template 'example', { title => 'TESTING',
                              '#header' => 'These are a few of my favourite things',
                              '//a[@id="link"]/@href' => 'http://perl.org'
                            };
    };
}

use lib 't';
use TestUtils;

{
my $response = get_response_for_request(GET => '/foo');
my $expected = 
q(<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>TESTING</title>
</head>
<body>
	<h1 id="header">These are a few of my favourite things</h1>
	<div class="container">
		<a id="link" href="http://perl.org"></a>
	</div>
</body>
</html>
);

is($response->{content}, $expected);
}

$ENV{_test_flag} = 0;

{
    package Webservice;
    use Dancer;
    # configure Dancer to use semantic template with some options
    set engines => {
        semantic => {
            parser => 'MyParser',
            recover => 2,
        },
    };
    set template => 'semantic';

    get '/foo' => sub {
		template 'example', { title => 'TESTING',
                              '#header' => 'These are a few of my favourite things',
                              '//a[@id="link"]/@href' => 'http://perl.org'
                            };
    };
}

{
my $response = get_response_for_request(GET => '/foo');
my $expected = 
q(<html xmlns="http://www.w3.org/1999/xhtml">
<head><meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
	<title>TESTING</title>
</head>
<body>
	<h1 id="header">These are a few of my favourite things</h1>
	<div class="container">
		<a id="link" href="http://perl.org"></a>
	</div>
</body>
</html>
);

is($response->{content}, $expected);

is($ENV{_test_flag}, 1);
delete $ENV{_test_flag};

}

