package FeyX::Active::SQL;
use Moose::Role;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

has 'dbh' => (
    is        => 'ro',
    isa       => 'DBI::db',   
    required  => 1,
);

has 'execute_rv' => (is => 'rw', isa => 'Any');

sub prepare_sql {
    my $self = shift;
    $self->sql( $self->dbh )    
}

sub prepare {
    my $self = shift;
    $self->dbh->prepare( $self->prepare_sql );
}

sub execute {
    my $self = shift;
    my $sth  = $self->prepare;
    $self->execute_rv( $sth->execute( $self->bind_params ) );
    $sth;
}

around sql => sub {
    my $next = shift;
    my $self = shift;
    $self->$next( $self->dbh );
};

no Moose::Role; 1;

__END__

=pod

=head1 NAME

FeyX::Active::SQL - A Moosey solution to this problem

=head1 SYNOPSIS

  use FeyX::Active::SQL;

=head1 DESCRIPTION

=head1 METHODS 

=over 4

=item B<>

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
