package WWW::Anvil::Schema::Result::Tag;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

use strict;
use warnings;

use base 'DBIx::Class::Core';

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 NAME

WWW::Anvil::Schema::Result::Tag

=cut

__PACKAGE__->table("tag");

=head1 ACCESSORS

=head2 id

  data_type: integer
  default_value: nextval('tag_id_seq'::regclass)
  is_auto_increment: 1
  is_nullable: 0

=head2 tag

  data_type: text
  default_value: undef
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  {
    data_type         => "integer",
    default_value     => \"nextval('tag_id_seq'::regclass)",
    is_auto_increment => 1,
    is_nullable       => 0,
  },
  "tag",
  { data_type => "text", default_value => undef, is_nullable => 0 },
);
__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 video_tags

Type: has_many

Related object: L<WWW::Anvil::Schema::Result::VideoTag>

=cut

__PACKAGE__->has_many(
  "video_tags",
  "WWW::Anvil::Schema::Result::VideoTag",
  { "foreign.tag_id" => "self.id" },
);


# Created by DBIx::Class::Schema::Loader v0.05003 @ 2010-02-28 16:57:52
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:/HlZ5AuE0F+OnFZpEAUlhw


# You can replace this text with custom content, and it will be preserved on regeneration
1;
