package WWW::Anvil::Schema::Result::Video;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WWW::Anvil::Schema::Result::Video

=cut

__PACKAGE__->table("video");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: nextval('video_id_seq'::regclass)
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: text
  default_value: undef
  is_nullable: 0

=head2 description

  data_type: text
  default_value: undef
  is_nullable: 0

=head2 posted

  data_type: timestamp without time zone
  default_value: undef
  is_nullable: 1

=head2 person_id

  data_type: integer
  default_value: undef
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('video_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "title",
  { data_type => "text", default_value => undef, is_nullable => 0 },
  "description",
  { data_type => "text", default_value => undef, is_nullable => 0 },
  "posted",
  {
    data_type     => "timestamp without time zone",
    default_value => undef,
    is_nullable   => 1,
  },
  "person_id",
  {
    data_type      => "integer",
    default_value  => undef,
    is_foreign_key => 1,
    is_nullable    => 1,
  },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 person

Type: belongs_to

Related object: L<WWW::Anvil::Schema::Result::Person>

=cut

__PACKAGE__->belongs_to(
  "person",
  "WWW::Anvil::Schema::Result::Person",
  { id => "person_id" },
  { join_type => "LEFT" },
);

=head2 video_shows

Type: has_many

Related object: L<WWW::Anvil::Schema::Result::VideoShow>

=cut

__PACKAGE__->has_many(
  "video_shows",
  "WWW::Anvil::Schema::Result::VideoShow",
  { "foreign.video_id" => "self.id" },
);

=head2 video_tags

Type: has_many

Related object: L<WWW::Anvil::Schema::Result::VideoTag>

=cut

__PACKAGE__->has_many(
  "video_tags",
  "WWW::Anvil::Schema::Result::VideoTag",
  { "foreign.video_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2010-02-28 16:57:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:FUBvRSIBetS7YdeEKv+6og


# You can replace this text with custom content, and it will be preserved on regeneration
1;
