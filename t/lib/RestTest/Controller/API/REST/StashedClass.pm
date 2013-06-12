package RestTest::Controller::API::REST::StashedClass;
use Moose;
BEGIN { extends 'Catalyst::Controller::DBIC::API::REST' }

use namespace::autoclean;

sub setup :Chained('/api/rest/rest_base') :CaptureArgs(1) :PathPart('stashedclass') {
    my ($self, $c, $class) = @_;
    $c->stash->{class} = $class;
    $self->next::method($c);
}

1;
