package Dancer::Template::Semantic;

use strict;
use warnings;
use Carp;

use Dancer::Config 'setting';
use Dancer::ModuleLoader;
use Dancer::FileUtils 'path';

use base 'Dancer::Template::Abstract';

sub init {
    my ($self) = @_;

    croak "Template::Semantic is needed by Dancer::Template::Semantic"
      unless Dancer::ModuleLoader->load('Template::Semantic');

    $self->{_engine} = Template::Semantic->new;
}

sub render {
    my ($self, $template, $tokens) = @_;
    croak "'$template' is not a regular file"
      if !ref($template) && (!-f $template);

    my $content = $self->{_engine}->process($template, $tokens) or croak $self->{_engine}->error;
    return $content;
}

1;

__END__

=pod

=head1 NAME

Dancer::Template::Semantic - Semantic Template wrapper for Dancer

=head1 DESCRIPTION

This class is an interface between Dancer's template engine abstraction layer
and the L<Template::Semantic> module.

In order to use this engine, use the template setting:

    template: semantic

This can be done in your config.yml file or directly in your app code with the
B<set> keyword. 

=head1 SEE ALSO

L<Dancer>, L<Template::Semantic>

=head1 CONTRIBUTORS

Damien Krotkine

=head1 AUTHOR

Squeeks, C<squeek at cpan.org>

=head1 LICENSE

This module is free software and is released under the same terms as Perl
itself.

=cut

