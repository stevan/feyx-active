package FeyX::Active::Schema;
use Moose;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

use Fey::Table;
use Fey::DBIManager;

extends 'Fey::Schema';

has 'dbi_manager' => (
    is      => 'ro',
    isa     => 'Fey::DBIManager',
    lazy    => 1,
    default => sub { Fey::DBIManager->new() },
);

__PACKAGE__->meta->make_immutable;

no Moose; 1;

__END__

=pod

=head1 NAME

FeyX::Active::Schema - An active Fey Schema

=head1 SYNOPSIS

  use FeyX::Active::Schema;

  my $schema = FeyX::Active::Schema->new( name => 'MySchema' );

  $schema->dbi_manager->add_source( dsn => 'dbi:SQLite:dbname=foo' );

  # ...

=head1 DESCRIPTION

This is just a subclass of L<Fey::Schema> which also happens to
have a L<Fey::DBIManager> instance handy. Nothing much else going
on here actually.

=head1 ATTRIBUTES

=over 4

=item B<dbi_manager>

This will lazily create a L<Fey::DBIManager> instance to be
used by this schema.

=back

=head1 BUGS

All complex software has bugs lurking in it, and this module is no
exception. If you find a bug please either email me, or add the bug
to cpan-RT.

=head1 AUTHOR

Stevan Little E<lt>stevan.little@iinteractive.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2009 Infinity Interactive, Inc.

L<http://www.iinteractive.com>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
