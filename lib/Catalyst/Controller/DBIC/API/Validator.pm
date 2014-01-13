package Catalyst::Controller::DBIC::API::Validator;

#ABSTRACT: Provides validation services for inbound requests against whitelisted parameters
use Moose;
use Catalyst::Controller::DBIC::API::Validator::Visitor;
use namespace::autoclean;

BEGIN { extends 'Data::DPath::Validator'; }

has '+visitor' => ( 'builder' => '_build_custom_visitor' );

sub _build_custom_visitor {
    return Catalyst::Controller::DBIC::API::Validator::Visitor->new();
}

__PACKAGE__->meta->make_immutable;

1;
