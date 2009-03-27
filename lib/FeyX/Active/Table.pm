package FeyX::Active::Table;
use Moose;

our $VERSION   = '0.01';
our $AUTHORITY = 'cpan:STEVAN';

use FeyX::Active::SQL::Select;
use FeyX::Active::SQL::Update;
use FeyX::Active::SQL::Insert;
use FeyX::Active::SQL::Delete;

extends 'Fey::Table';

# 
# ->select      => all columns
# ->select('*') => all columns
# ->select(
#      'foo', 
#      'bar', 
#      'baz'
#   )           => foo bar baz columns
#

sub select {
    my ($self, @names) = @_;
    
    my $select = FeyX::Active::SQL::Select->new( 
        dbh => $self->schema->dbi_manager->default_source->dbh 
    );
    
    if (scalar @names == 0 || (scalar @names == 1 && $names[0] eq '*')) {
        $select->select( $self );
    }
    else {
        $select->select( $self->columns( @names ) );
    }
    
    # NOTE: 
    # this can be called later 
    # and overwritten without 
    # issue (so say the Fey docs)
    # - SL
    $select->from( $self );
    $select;
}

#
# ->delete
#

sub delete {
    my $self = shift;
    my $delete = FeyX::Active::SQL::Delete->new(
        dbh => $self->schema->dbi_manager->default_source->dbh 
    );
    
    $delete->from($self);
    $delete;
}

# 
# ->insert( foo => 'FOO', bar => $bar, baz => Baz->new )
# 

sub insert {
    my $self = shift;
    my $insert = FeyX::Active::SQL::Insert->new(
        dbh => $self->schema->dbi_manager->default_source->dbh 
    );
    
    $insert->into($self);
    $insert->values( @_ ) if @_;    
    $insert;
}

# 
# ->update( foo => 'FOO', baz => Baz->new )
#

sub update {
    my $self = shift;
    my $update = FeyX::Active::SQL::Update->new(
        dbh => $self->schema->dbi_manager->default_source->dbh 
    );
    
    $update->update($self);
    $update->set( @_ ) if @_;
    $update;
}

__PACKAGE__->meta->make_immutable;

no Moose; 1;

__END__

=pod

=head1 NAME

FeyX::Active::Table - A Moosey solution to this problem

=head1 SYNOPSIS

  use FeyX::Active::Table;

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
