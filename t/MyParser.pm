package MyParser;
use base qw(XML::LibXML);

# our parser does nothing more than XML::LibXML, except that it sets our
# test environment variable to 1
sub new {
    $ENV{_test_flag} = 1;
    shift->SUPER::new(@_);
}

1;
