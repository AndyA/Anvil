package WWW::Anvil::Schema::Result::Person;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WWW::Anvil::Schema::Result::Person

=cut

__PACKAGE__->table("person");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: nextval('person_id_seq'::regclass)
  is_auto_increment: 1
  is_nullable: 0

=head2 name

  data_type: text
  default_value: undef
  is_nullable: 0

=head2 email

  data_type: text
  default_value: undef
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('person_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "name",
  { data_type => "text", default_value => undef, is_nullable => 0 },
  "email",
  { data_type => "text", default_value => undef, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 shows

Type: has_many

Related object: L<WWW::Anvil::Schema::Result::Show>

=cut

__PACKAGE__->has_many(
  "shows",
  "WWW::Anvil::Schema::Result::Show",
  { "foreign.person_id" => "self.id" },
);

=head2 videos

Type: has_many

Related object: L<WWW::Anvil::Schema::Result::Video>

=cut

__PACKAGE__->has_many(
  "videos",
  "WWW::Anvil::Schema::Result::Video",
  { "foreign.person_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2010-02-28 16:57:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:nC3SWv9aXyxJP3UCoS/eYw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
